// Activity Dashboard JavaScript
// Chart.js visualization and API integration

// API base URL
const API_BASE = window.location.origin;

// Chart instances
let githubChart = null;
let blogChart = null;
let combinedChart = null;

// Initialize dashboard on page load
document.addEventListener('DOMContentLoaded', function() {
    loadDashboard();
    
    // Set up event listeners
    document.getElementById('refresh-btn').addEventListener('click', function() {
        loadDashboard();
    });
    
    document.getElementById('clear-cache-btn').addEventListener('click', function() {
        clearCache();
    });
});

// Load all dashboard data
async function loadDashboard() {
    updateLastUpdateTime();
    
    // Load GitHub and Blog data in parallel
    await Promise.all([
        loadGitHubData(),
        loadBlogData()
    ]);
    
    // Update combined chart
    updateCombinedChart();
}

// Load GitHub data
async function loadGitHubData() {
    const loadingEl = document.getElementById('github-loading');
    const errorEl = document.getElementById('github-error');
    const statsEl = document.getElementById('github-stats');
    
    loadingEl.style.display = 'block';
    errorEl.style.display = 'none';
    statsEl.style.display = 'none';
    
    try {
        const response = await fetch(`${API_BASE}/api/github/stats`);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (data.error) {
            throw new Error(data.error);
        }
        
        // Update stats
        document.getElementById('github-repos').textContent = data.public_repos || 0;
        document.getElementById('github-followers').textContent = data.followers || 0;
        document.getElementById('github-following').textContent = data.following || 0;
        document.getElementById('github-events-week').textContent = data.events_last_week || 0;
        
        // Update top repos
        if (data.top_repos && data.top_repos.length > 0) {
            const reposList = document.getElementById('top-repos');
            reposList.innerHTML = '';
            
            data.top_repos.forEach(repo => {
                const li = document.createElement('li');
                li.innerHTML = `
                    <a href="${repo.html_url}" target="_blank">${repo.name}</a>
                    <div class="repo-info">
                        <span class="stars">⭐ ${repo.stargazers_count}</span>
                        <span>${repo.description || 'No description'}</span>
                    </div>
                `;
                reposList.appendChild(li);
            });
            
            document.getElementById('github-repos-list').style.display = 'block';
        }
        
        // Update chart
        updateGitHubChart(data);
        
        // Show stats
        loadingEl.style.display = 'none';
        statsEl.style.display = 'grid';
        document.getElementById('github-chart-container').style.display = 'block';
        
    } catch (error) {
        console.error('Error loading GitHub data:', error);
        loadingEl.style.display = 'none';
        errorEl.textContent = `Failed to load GitHub data: ${error.message}`;
        errorEl.style.display = 'block';
    }
}

// Load Blog data
async function loadBlogData() {
    const loadingEl = document.getElementById('blog-loading');
    const errorEl = document.getElementById('blog-error');
    const statsEl = document.getElementById('blog-stats');
    
    loadingEl.style.display = 'block';
    errorEl.style.display = 'none';
    statsEl.style.display = 'none';
    
    try {
        const response = await fetch(`${API_BASE}/api/blog/stats`);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (data.error) {
            throw new Error(data.error);
        }
        
        // Update stats
        document.getElementById('blog-total').textContent = data.total_posts || 0;
        document.getElementById('blog-recent').textContent = data.recent_posts_month || 0;
        
        // Update latest posts
        if (data.latest_posts && data.latest_posts.length > 0) {
            const postsList = document.getElementById('latest-posts');
            postsList.innerHTML = '';
            
            data.latest_posts.forEach(post => {
                const li = document.createElement('li');
                const date = post.published_date ? new Date(post.published_date).toLocaleDateString() : 'Unknown date';
                li.innerHTML = `
                    <a href="${post.link}" target="_blank">${post.title}</a>
                    <div class="post-info">
                        <span class="date">📅 ${date}</span>
                        <span>${post.author}</span>
                    </div>
                `;
                postsList.appendChild(li);
            });
            
            document.getElementById('blog-posts-list').style.display = 'block';
        }
        
        // Update chart
        updateBlogChart(data);
        
        // Show stats
        loadingEl.style.display = 'none';
        statsEl.style.display = 'grid';
        document.getElementById('blog-chart-container').style.display = 'block';
        
    } catch (error) {
        console.error('Error loading blog data:', error);
        loadingEl.style.display = 'none';
        errorEl.textContent = `Failed to load blog data: ${error.message}`;
        errorEl.style.display = 'block';
    }
}

// Update GitHub chart
function updateGitHubChart(data) {
    const ctx = document.getElementById('github-chart').getContext('2d');
    
    if (githubChart) {
        githubChart.destroy();
    }
    
    githubChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Repos', 'Followers', 'Following', 'Events (Week)', 'Events (Month)'],
            datasets: [{
                label: 'GitHub Activity',
                data: [
                    data.public_repos || 0,
                    data.followers || 0,
                    data.following || 0,
                    data.events_last_week || 0,
                    data.events_last_month || 0
                ],
                backgroundColor: [
                    'rgba(102, 126, 234, 0.8)',
                    'rgba(118, 75, 162, 0.8)',
                    'rgba(237, 100, 166, 0.8)',
                    'rgba(255, 154, 158, 0.8)',
                    'rgba(255, 206, 154, 0.8)'
                ],
                borderColor: [
                    'rgba(102, 126, 234, 1)',
                    'rgba(118, 75, 162, 1)',
                    'rgba(237, 100, 166, 1)',
                    'rgba(255, 154, 158, 1)',
                    'rgba(255, 206, 154, 1)'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
}

// Update Blog chart
function updateBlogChart(data) {
    const ctx = document.getElementById('blog-chart').getContext('2d');
    
    if (blogChart) {
        blogChart.destroy();
    }
    
    blogChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Recent Posts (30d)', 'Older Posts'],
            datasets: [{
                label: 'Blog Posts',
                data: [
                    data.recent_posts_month || 0,
                    (data.total_posts || 0) - (data.recent_posts_month || 0)
                ],
                backgroundColor: [
                    'rgba(102, 126, 234, 0.8)',
                    'rgba(200, 200, 200, 0.8)'
                ],
                borderColor: [
                    'rgba(102, 126, 234, 1)',
                    'rgba(200, 200, 200, 1)'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });
}

// Update combined chart
async function updateCombinedChart() {
    try {
        const response = await fetch(`${API_BASE}/api/dashboard`);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const data = await response.json();
        
        const ctx = document.getElementById('combined-chart').getContext('2d');
        
        if (combinedChart) {
            combinedChart.destroy();
        }
        
        const githubData = data.github || {};
        const blogData = data.blog || {};
        
        combinedChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Repos', 'Followers', 'GitHub Events (Week)', 'Blog Posts (Total)', 'Blog Posts (Month)'],
                datasets: [{
                    label: 'Activity Metrics',
                    data: [
                        githubData.public_repos || 0,
                        githubData.followers || 0,
                        githubData.events_last_week || 0,
                        blogData.total_posts || 0,
                        blogData.recent_posts_month || 0
                    ],
                    fill: true,
                    backgroundColor: 'rgba(102, 126, 234, 0.2)',
                    borderColor: 'rgba(102, 126, 234, 1)',
                    borderWidth: 3,
                    tension: 0.4,
                    pointBackgroundColor: 'rgba(102, 126, 234, 1)',
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 5,
                    pointHoverRadius: 7
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
        
    } catch (error) {
        console.error('Error updating combined chart:', error);
    }
}

// Clear cache
async function clearCache() {
    if (!confirm('Are you sure you want to clear the cache?')) {
        return;
    }
    
    try {
        const response = await fetch(`${API_BASE}/api/cache`, {
            method: 'DELETE'
        });
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        const result = await response.json();
        alert(result.message || 'Cache cleared successfully');
        
        // Reload dashboard
        loadDashboard();
        
    } catch (error) {
        console.error('Error clearing cache:', error);
        alert(`Failed to clear cache: ${error.message}`);
    }
}

// Update last update time
function updateLastUpdateTime() {
    const now = new Date();
    const timeString = now.toLocaleString();
    document.getElementById('last-update-time').textContent = timeString;
}
