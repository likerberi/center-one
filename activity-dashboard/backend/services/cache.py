"""Redis caching service for activity dashboard."""
import json
import logging
from typing import Optional, Any
import redis
from redis.exceptions import RedisError

from ..config import settings

logger = logging.getLogger(__name__)


class CacheService:
    """Redis-based caching service."""
    
    def __init__(self):
        """Initialize Redis connection."""
        try:
            self.redis_client = redis.Redis(
                host=settings.REDIS_HOST,
                port=settings.REDIS_PORT,
                db=settings.REDIS_DB,
                password=settings.REDIS_PASSWORD,
                decode_responses=True,
                socket_connect_timeout=5
            )
            # Test connection
            self.redis_client.ping()
            self.enabled = True
            logger.info("Redis cache initialized successfully")
        except (RedisError, Exception) as e:
            logger.warning(f"Redis connection failed: {e}. Cache will be disabled.")
            self.enabled = False
            self.redis_client = None
    
    def get(self, key: str) -> Optional[Any]:
        """
        Get value from cache.
        
        Args:
            key: Cache key
            
        Returns:
            Cached value or None if not found or cache disabled
        """
        if not self.enabled:
            return None
        
        try:
            value = self.redis_client.get(key)
            if value:
                return json.loads(value)
            return None
        except (RedisError, json.JSONDecodeError) as e:
            logger.error(f"Cache get error for key {key}: {e}")
            return None
    
    def set(self, key: str, value: Any, ttl: Optional[int] = None) -> bool:
        """
        Set value in cache.
        
        Args:
            key: Cache key
            value: Value to cache (must be JSON serializable)
            ttl: Time to live in seconds (default: settings.CACHE_TTL)
            
        Returns:
            True if successful, False otherwise
        """
        if not self.enabled:
            return False
        
        try:
            ttl = ttl or settings.CACHE_TTL
            serialized = json.dumps(value)
            self.redis_client.setex(key, ttl, serialized)
            return True
        except (RedisError, TypeError, json.JSONEncodeError) as e:
            logger.error(f"Cache set error for key {key}: {e}")
            return False
    
    def delete(self, key: str) -> bool:
        """
        Delete value from cache.
        
        Args:
            key: Cache key
            
        Returns:
            True if successful, False otherwise
        """
        if not self.enabled:
            return False
        
        try:
            self.redis_client.delete(key)
            return True
        except RedisError as e:
            logger.error(f"Cache delete error for key {key}: {e}")
            return False
    
    def clear(self) -> bool:
        """
        Clear all cache entries.
        
        Returns:
            True if successful, False otherwise
        """
        if not self.enabled:
            return False
        
        try:
            self.redis_client.flushdb()
            return True
        except RedisError as e:
            logger.error(f"Cache clear error: {e}")
            return False


# Global cache instance
cache = CacheService()
