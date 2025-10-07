# Activity Dashboard

A comprehensive web-based dashboard for tracking GitHub and blog activities. Built with FastAPI (backend) and Chart.js (frontend visualization).

## 🎯 Features

- **GitHub Activity Tracking**
  - Repository statistics
  - Follower/Following counts
  - Recent events and activity
  - Top repositories by stars

- **Blog RSS Integration**
  - Latest blog posts
  - Publishing statistics
  - Recent activity tracking

- **Data Visualization**
  - Interactive charts using Chart.js
  - Real-time activity metrics
  - Combined activity overview

- **Performance Optimization**
  - Redis caching for API responses
  - Configurable cache TTL
  - Efficient data aggregation

## 📁 Project Structure

```
activity-dashboard/
├── backend/
│   ├── main.py              # FastAPI server
│   ├── services/
│   │   ├── github.py        # GitHub API integration
│   │   ├── blog.py          # Blog RSS parser
│   │   └── cache.py         # Redis caching
│   ├── config.py            # Configuration settings
│   └── requirements.txt     # Python dependencies
├── frontend/
│   ├── index.html           # Dashboard UI
│   ├── style.css            # Styling
│   └── app.js               # Chart.js visualization
├── .env.example             # Environment variables template
└── README.md                # This file
```

## 🚀 Getting Started

### Prerequisites

- Python 3.8+
- Redis (optional, for caching)
- GitHub Personal Access Token (optional, for private repo access)

### Installation

1. **Clone the repository**
   ```bash
   cd activity-dashboard
   ```

2. **Set up Python environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r backend/requirements.txt
   ```

4. **Configure environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your settings
   ```

5. **Start Redis (optional)**
   ```bash
   redis-server
   ```
   *Note: The dashboard will work without Redis, but caching will be disabled.*

### Running the Application

```bash
# From the activity-dashboard directory
python -m backend.main
```

Or using uvicorn directly:
```bash
uvicorn backend.main:app --host 0.0.0.0 --port 8000 --reload
```

The dashboard will be available at: `http://localhost:8000`

## ⚙️ Configuration

Edit the `.env` file to configure the dashboard:

### Server Settings
- `HOST`: Server host address (default: 0.0.0.0)
- `PORT`: Server port (default: 8000)
- `DEBUG`: Enable debug mode (default: False)

### GitHub Settings
- `GITHUB_TOKEN`: Your GitHub personal access token
- `GITHUB_USERNAME`: Your GitHub username

To create a GitHub token:
1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Generate a new token with `public_repo` scope
3. Copy the token to your `.env` file

### Blog Settings
- `BLOG_RSS_URL`: URL to your blog's RSS feed

### Redis Settings
- `REDIS_HOST`: Redis server host (default: localhost)
- `REDIS_PORT`: Redis server port (default: 6379)
- `REDIS_DB`: Redis database number (default: 0)
- `REDIS_PASSWORD`: Redis password (if required)

### Cache Settings
- `CACHE_TTL`: Cache time-to-live in seconds (default: 3600)

## 📊 API Endpoints

### Health Check
- `GET /health` - Service health status

### GitHub Endpoints
- `GET /api/github/user` - Get user information
- `GET /api/github/repos` - Get user repositories
- `GET /api/github/events` - Get user events
- `GET /api/github/stats` - Get aggregated GitHub statistics

### Blog Endpoints
- `GET /api/blog/posts` - Get blog posts
- `GET /api/blog/info` - Get blog feed information
- `GET /api/blog/stats` - Get blog statistics

### Dashboard
- `GET /api/dashboard` - Get combined dashboard data

### Cache Management
- `DELETE /api/cache` - Clear all cached data

## 🎨 Frontend Features

- **Responsive Design**: Works on desktop and mobile devices
- **Real-time Updates**: Refresh data with a single click
- **Interactive Charts**: Visualize activity with Chart.js
- **Loading States**: Clear feedback during data fetching
- **Error Handling**: Graceful error messages

## 🔧 Development

### Project Structure

The backend follows a service-oriented architecture:
- `main.py`: FastAPI application and route definitions
- `config.py`: Centralized configuration management
- `services/`: Business logic and external integrations
  - `cache.py`: Redis caching layer
  - `github.py`: GitHub API client
  - `blog.py`: RSS feed parser

### Adding New Features

1. Create service modules in `backend/services/`
2. Add API endpoints in `backend/main.py`
3. Update frontend visualization in `frontend/app.js`

## 🛠️ Troubleshooting

### Redis Connection Issues
If Redis is not available, the dashboard will still work but without caching. Check logs for warnings about disabled cache.

### GitHub API Rate Limiting
Without a GitHub token, you're limited to 60 requests per hour. With a token, the limit increases to 5,000 requests per hour.

### CORS Issues
If accessing from a different domain, update `CORS_ORIGINS` in your `.env` file.

## 📝 License

This project is open source and available for use and modification.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.
