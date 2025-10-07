"""Blog RSS parser service."""
import logging
from typing import List, Dict, Any, Optional
from datetime import datetime
import feedparser
from feedparser import FeedParserDict

from ..config import settings
from .cache import cache

logger = logging.getLogger(__name__)


class BlogService:
    """Service for parsing blog RSS feeds."""
    
    def __init__(self):
        """Initialize blog service."""
        self.rss_url = settings.BLOG_RSS_URL
    
    def parse_feed(self, url: Optional[str] = None) -> Optional[FeedParserDict]:
        """
        Parse RSS feed.
        
        Args:
            url: RSS feed URL (defaults to configured URL)
            
        Returns:
            Parsed feed object or None on error
        """
        url = url or self.rss_url
        if not url:
            logger.error("No RSS URL provided")
            return None
        
        try:
            feed = feedparser.parse(url)
            if feed.bozo:
                logger.warning(f"RSS feed parsing had errors: {feed.bozo_exception}")
            return feed
        except Exception as e:
            logger.error(f"Failed to parse RSS feed: {e}")
            return None
    
    def get_posts(self, url: Optional[str] = None, limit: int = 10) -> List[Dict[str, Any]]:
        """
        Get blog posts from RSS feed.
        
        Args:
            url: RSS feed URL (defaults to configured URL)
            limit: Maximum number of posts to return
            
        Returns:
            List of blog post dicts
        """
        url = url or self.rss_url
        if not url:
            logger.warning("No RSS URL configured")
            return []
        
        # Check cache
        cache_key = f"blog:posts:{url}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return cached_data[:limit]
        
        # Parse feed
        feed = self.parse_feed(url)
        if not feed or not hasattr(feed, 'entries'):
            return []
        
        # Extract post information
        posts = []
        for entry in feed.entries[:limit]:
            post = {
                "title": entry.get("title", "No title"),
                "link": entry.get("link", ""),
                "summary": entry.get("summary", entry.get("description", "")),
                "published": entry.get("published", entry.get("updated", "")),
                "author": entry.get("author", "Unknown")
            }
            
            # Parse published date
            if "published_parsed" in entry and entry.published_parsed:
                try:
                    post["published_date"] = datetime(*entry.published_parsed[:6]).isoformat()
                except Exception:
                    post["published_date"] = post["published"]
            else:
                post["published_date"] = post["published"]
            
            posts.append(post)
        
        # Cache the result
        if posts:
            cache.set(cache_key, posts, ttl=3600)
        
        return posts
    
    def get_feed_info(self, url: Optional[str] = None) -> Dict[str, Any]:
        """
        Get blog feed metadata.
        
        Args:
            url: RSS feed URL (defaults to configured URL)
            
        Returns:
            Dict with feed information
        """
        url = url or self.rss_url
        if not url:
            return {"error": "No RSS URL configured"}
        
        # Check cache
        cache_key = f"blog:info:{url}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return cached_data
        
        # Parse feed
        feed = self.parse_feed(url)
        if not feed or not hasattr(feed, 'feed'):
            return {"error": "Failed to parse feed"}
        
        feed_info = {
            "title": feed.feed.get("title", "Unknown"),
            "description": feed.feed.get("description", ""),
            "link": feed.feed.get("link", ""),
            "language": feed.feed.get("language", ""),
            "updated": feed.feed.get("updated", "")
        }
        
        # Cache the result
        cache.set(cache_key, feed_info, ttl=7200)
        
        return feed_info
    
    def get_activity_stats(self, url: Optional[str] = None) -> Dict[str, Any]:
        """
        Get blog activity statistics.
        
        Args:
            url: RSS feed URL (defaults to configured URL)
            
        Returns:
            Dict with blog statistics
        """
        url = url or self.rss_url
        if not url:
            return {"error": "No RSS URL configured"}
        
        # Check cache
        cache_key = f"blog:stats:{url}"
        cached_data = cache.get(cache_key)
        if cached_data:
            return cached_data
        
        posts = self.get_posts(url, limit=100)
        feed_info = self.get_feed_info(url)
        
        if not posts:
            return {"error": "No posts found", "total_posts": 0}
        
        # Calculate stats
        from datetime import datetime, timedelta
        now = datetime.utcnow()
        month_ago = now - timedelta(days=30)
        
        recent_posts = []
        for post in posts:
            try:
                if "published_date" in post:
                    pub_date = datetime.fromisoformat(post["published_date"].replace("Z", "+00:00"))
                    if pub_date.replace(tzinfo=None) > month_ago:
                        recent_posts.append(post)
            except Exception:
                continue
        
        stats = {
            "blog_title": feed_info.get("title", "Unknown"),
            "total_posts": len(posts),
            "recent_posts_month": len(recent_posts),
            "latest_posts": posts[:5]
        }
        
        # Cache the result
        cache.set(cache_key, stats, ttl=3600)
        
        return stats


# Global blog service instance
blog_service = BlogService()
