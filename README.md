# center-one

## Activity Dashboard

A comprehensive web-based dashboard for tracking GitHub and blog activities.

### 🎯 Features

- Real-time GitHub activity tracking
- Blog RSS feed integration
- Interactive data visualization with Chart.js
- Redis-based caching for performance
- RESTful API built with FastAPI

### 📁 Project Structure

```
activity-dashboard/
├── backend/              # FastAPI server and services
├── frontend/             # HTML/CSS/JS dashboard UI
├── .env.example          # Environment configuration template
└── README.md            # Detailed documentation
```

### 🚀 Quick Start

```bash
cd activity-dashboard
pip install -r backend/requirements.txt
cp .env.example .env
# Configure your .env file
python -m backend.main
```

Visit `http://localhost:8000` to view the dashboard.

For detailed documentation, see [activity-dashboard/README.md](activity-dashboard/README.md).