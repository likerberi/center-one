"""GitHub API integration service."""
import logging
from typing import Optional, List, Dict, Any
from datetime import datetime, timedelta
import requests

from ..config import settings
from .cache import cache

logger = logging.getLogger(__name__)


class GitHubService:
    """Service for interacting with GitHub API."""
    
    BASE_URL = "https://api.github.com"
    
    def __init__(self):
        """Initialize GitHub service."""
        self.token = settings.GITHUB_TOKEN
        self.username = settings.GITHUB_USERNAME
        self.headers = {}
        
        if self.token:
            self.headers["Authorization"] = f"token {self.token}"
        self.headers["Accept"] = "application/vnd.github.v3+json"
    
    def _make_request(self, endpoint: str, params: Optional[Dict] = None) -> Optional[Any]:
        """
        Make a request to GitHub API.
        
        Args:
            endpoint: API endpoint (relative to BASE_URL)
            params: Query parameters
            
        Returns:
            Response JSON or None on error
        """
        url = f"{self.BASE_URL}{endpoint}"
        
        try:
            response = requests.get(url, headers=self.headers, params=params, timeout=10)
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            logger.error(f"GitHub API request failed: {e}")
            return None
    
    def get_user_info(self, username: Optional[str] = None) -> Optional[Dict[str, Any]]:
        """
        Get GitHub user information.
        
        Args:
            username: GitHub username (defaults to configured username)
            
        Returns:
            User information dict or None on error
        """
        username = username or self.username
        if not username:
            logger.error("No GitHub username provided")
            return None
        
        # Check cache
        cache_key = f"github:user:{username}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return cached_data
        
        # Fetch from API
        data = self._make_request(f"/users/{username}")
        
        if data:
            # Cache the result
            cache.set(cache_key, data, ttl=3600)
        
        return data
    
    def get_user_repos(self, username: Optional[str] = None, per_page: int = 30) -> List[Dict[str, Any]]:
        """
        Get user repositories.
        
        Args:
            username: GitHub username (defaults to configured username)
            per_page: Number of repos per page
            
        Returns:
            List of repository dicts
        """
        username = username or self.username
        if not username:
            logger.error("No GitHub username provided")
            return []
        
        # Check cache
        cache_key = f"github:repos:{username}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return cached_data
        
        # Fetch from API
        params = {"per_page": per_page, "sort": "updated"}
        data = self._make_request(f"/users/{username}/repos", params=params)
        
        if data and isinstance(data, list):
            # Cache the result
            cache.set(cache_key, data, ttl=1800)
            return data
        
        return []
    
    def get_user_events(self, username: Optional[str] = None, per_page: int = 30) -> List[Dict[str, Any]]:
        """
        Get user public events.
        
        Args:
            username: GitHub username (defaults to configured username)
            per_page: Number of events per page
            
        Returns:
            List of event dicts
        """
        username = username or self.username
        if not username:
            logger.error("No GitHub username provided")
            return []
        
        # Check cache
        cache_key = f"github:events:{username}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return cached_data
        
        # Fetch from API
        params = {"per_page": per_page}
        data = self._make_request(f"/users/{username}/events", params=params)
        
        if data and isinstance(data, list):
            # Cache the result for shorter time (events change frequently)
            cache.set(cache_key, data, ttl=600)
            return data
        
        return []
    
    def get_activity_stats(self, username: Optional[str] = None) -> Dict[str, Any]:
        """
        Get aggregated activity statistics.
        
        Args:
            username: GitHub username (defaults to configured username)
            
        Returns:
            Dictionary with activity statistics
        """
        username = username or self.username
        if not username:
            return {"error": "No username provided"}
        
        # Check cache
        cache_key = f"github:stats:{username}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return cached_data
        
        # Gather data
        events = self.get_user_events(username)
        repos = self.get_user_repos(username)
        user_info = self.get_user_info(username)
        
        # Calculate stats
        now = datetime.utcnow()
        week_ago = now - timedelta(days=7)
        month_ago = now - timedelta(days=30)
        
        recent_events_week = [
            e for e in events 
            if datetime.strptime(e.get("created_at", ""), "%Y-%m-%dT%H:%M:%SZ") > week_ago
        ] if events else []
        
        recent_events_month = [
            e for e in events 
            if datetime.strptime(e.get("created_at", ""), "%Y-%m-%dT%H:%M:%SZ") > month_ago
        ] if events else []
        
        stats = {
            "username": username,
            "total_repos": len(repos),
            "public_repos": user_info.get("public_repos", 0) if user_info else 0,
            "followers": user_info.get("followers", 0) if user_info else 0,
            "following": user_info.get("following", 0) if user_info else 0,
            "events_last_week": len(recent_events_week),
            "events_last_month": len(recent_events_month),
            "recent_activity": events[:10] if events else [],
            "top_repos": sorted(repos, key=lambda r: r.get("stargazers_count", 0), reverse=True)[:5] if repos else []
        }
        
        # Cache the result
        cache.set(cache_key, stats, ttl=1800)
        
        return stats


# Global GitHub service instance
github_service = GitHubService()
