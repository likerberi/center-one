"""FastAPI server for activity dashboard."""
import logging
from typing import Dict, Any
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
import uvicorn

from .config import settings
from .services import github_service, blog_service, cache

# Configure logging
logging.basicConfig(
    level=logging.DEBUG if settings.DEBUG else logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)

# Initialize FastAPI app
app = FastAPI(
    title="Activity Dashboard API",
    description="API for GitHub and blog activity tracking",
    version="1.0.0"
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount static files
import os
frontend_path = os.path.join(os.path.dirname(__file__), "..", "frontend")
if os.path.exists(frontend_path):
    app.mount("/static", StaticFiles(directory=frontend_path), name="static")


@app.get("/")
async def root():
    """Serve the frontend dashboard."""
    frontend_index = os.path.join(frontend_path, "index.html")
    if os.path.exists(frontend_index):
        return FileResponse(frontend_index)
    return {"message": "Activity Dashboard API", "version": "1.0.0"}


@app.get("/health")
async def health_check():
    """Health check endpoint."""
    return {
        "status": "healthy",
        "cache_enabled": cache.enabled,
        "github_configured": bool(settings.GITHUB_TOKEN and settings.GITHUB_USERNAME),
        "blog_configured": bool(settings.BLOG_RSS_URL)
    }


@app.get("/api/github/user")
async def get_github_user(username: str = None):
    """
    Get GitHub user information.
    
    Args:
        username: GitHub username (optional, uses configured username if not provided)
    """
    try:
        user_info = github_service.get_user_info(username)
        if not user_info:
            raise HTTPException(status_code=404, detail="User not found or API error")
        return user_info
    except Exception as e:
        logger.error(f"Error fetching GitHub user: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/github/repos")
async def get_github_repos(username: str = None, limit: int = 30):
    """
    Get user repositories.
    
    Args:
        username: GitHub username (optional)
        limit: Maximum number of repositories to return
    """
    try:
        repos = github_service.get_user_repos(username, per_page=limit)
        return {"repos": repos, "count": len(repos)}
    except Exception as e:
        logger.error(f"Error fetching GitHub repos: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/github/events")
async def get_github_events(username: str = None, limit: int = 30):
    """
    Get user public events.
    
    Args:
        username: GitHub username (optional)
        limit: Maximum number of events to return
    """
    try:
        events = github_service.get_user_events(username, per_page=limit)
        return {"events": events, "count": len(events)}
    except Exception as e:
        logger.error(f"Error fetching GitHub events: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/github/stats")
async def get_github_stats(username: str = None):
    """
    Get aggregated GitHub activity statistics.
    
    Args:
        username: GitHub username (optional)
    """
    try:
        stats = github_service.get_activity_stats(username)
        if "error" in stats:
            raise HTTPException(status_code=400, detail=stats["error"])
        return stats
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error fetching GitHub stats: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/blog/posts")
async def get_blog_posts(url: str = None, limit: int = 10):
    """
    Get blog posts from RSS feed.
    
    Args:
        url: RSS feed URL (optional, uses configured URL if not provided)
        limit: Maximum number of posts to return
    """
    try:
        posts = blog_service.get_posts(url, limit=limit)
        return {"posts": posts, "count": len(posts)}
    except Exception as e:
        logger.error(f"Error fetching blog posts: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/blog/info")
async def get_blog_info(url: str = None):
    """
    Get blog feed metadata.
    
    Args:
        url: RSS feed URL (optional)
    """
    try:
        info = blog_service.get_feed_info(url)
        if "error" in info:
            raise HTTPException(status_code=400, detail=info["error"])
        return info
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error fetching blog info: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/blog/stats")
async def get_blog_stats(url: str = None):
    """
    Get blog activity statistics.
    
    Args:
        url: RSS feed URL (optional)
    """
    try:
        stats = blog_service.get_activity_stats(url)
        if "error" in stats:
            raise HTTPException(status_code=400, detail=stats["error"])
        return stats
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error fetching blog stats: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/api/dashboard")
async def get_dashboard_data():
    """
    Get all dashboard data (GitHub + Blog stats).
    """
    try:
        dashboard_data: Dict[str, Any] = {}
        
        # Get GitHub stats
        if settings.GITHUB_USERNAME:
            try:
                dashboard_data["github"] = github_service.get_activity_stats()
            except Exception as e:
                logger.error(f"Error fetching GitHub data: {e}")
                dashboard_data["github"] = {"error": str(e)}
        else:
            dashboard_data["github"] = {"error": "GitHub not configured"}
        
        # Get blog stats
        if settings.BLOG_RSS_URL:
            try:
                dashboard_data["blog"] = blog_service.get_activity_stats()
            except Exception as e:
                logger.error(f"Error fetching blog data: {e}")
                dashboard_data["blog"] = {"error": str(e)}
        else:
            dashboard_data["blog"] = {"error": "Blog not configured"}
        
        return dashboard_data
    except Exception as e:
        logger.error(f"Error fetching dashboard data: {e}")
        raise HTTPException(status_code=500, detail=str(e))


@app.delete("/api/cache")
async def clear_cache():
    """Clear all cached data."""
    try:
        success = cache.clear()
        return {"success": success, "message": "Cache cleared" if success else "Cache not enabled"}
    except Exception as e:
        logger.error(f"Error clearing cache: {e}")
        raise HTTPException(status_code=500, detail=str(e))


def main():
    """Run the server."""
    uvicorn.run(
        "backend.main:app",
        host=settings.HOST,
        port=settings.PORT,
        reload=settings.DEBUG
    )


if __name__ == "__main__":
    main()
