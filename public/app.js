// API 엔드포인트
const API_BASE = window.location.origin;

let githubChart = null;
let blogChart = null;

// GitHub 데이터 로드
async function loadGithubData() {
    try {
        const response = await fetch(`${API_BASE}/api/github/activity`);
        const data = await response.json();

        // 통계 업데이트
        document.getElementById('github-commits').textContent = data.totalCommits;
        document.getElementById('github-prs').textContent = data.totalPRs;
        document.getElementById('github-issues').textContent = data.totalIssues;

        // 차트 생성
        createGithubChart(data.contributions);
    } catch (error) {
        console.error('Failed to load GitHub data:', error);
        document.getElementById('github-commits').textContent = 'Error';
    }
}

// 블로그 데이터 로드
async function loadBlogData() {
    try {
        const response = await fetch(`${API_BASE}/api/blog/activity`);
        const data = await response.json();

        // 통계 업데이트
        document.getElementById('blog-total').textContent = data.totalPosts;

        // 차트 생성
        createBlogChart(data.postsPerMonth);

        // 최근 포스트 렌더링
        renderRecentPosts(data.recentPosts);
    } catch (error) {
        console.error('Failed to load blog data:', error);
        document.getElementById('blog-total').textContent = 'Error';
    }
}

// GitHub 차트 생성
function createGithubChart(contributions) {
    const ctx = document.getElementById('github-chart').getContext('2d');

    // 기존 차트 삭제
    if (githubChart) {
        githubChart.destroy();
    }

    // 최근 30일 데이터만 표시
    const recentContributions = contributions.slice(0, 30).reverse();

    githubChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: recentContributions.map(c => c.date),
            datasets: [{
                label: 'Daily Contributions',
                data: recentContributions.map(c => c.count),
                borderColor: '#667eea',
                backgroundColor: 'rgba(102, 126, 234, 0.1)',
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            }
        }
    });
}

// 블로그 차트 생성
function createBlogChart(postsPerMonth) {
    const ctx = document.getElementById('blog-chart').getContext('2d');

    // 기존 차트 삭제
    if (blogChart) {
        blogChart.destroy();
    }

    // 최근 12개월 데이터만 표시
    const recentMonths = postsPerMonth.slice(0, 12).reverse();

    blogChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: recentMonths.map(m => m.month),
            datasets: [{
                label: 'Posts per Month',
                data: recentMonths.map(m => m.count),
                backgroundColor: '#764ba2',
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            }
        }
    });
}

// 최근 포스트 렌더링
function renderRecentPosts(posts) {
    const list = document.getElementById('recent-posts-list');
    list.innerHTML = '';

    posts.forEach(post => {
        const li = document.createElement('li');
        const date = new Date(post.pubDate).toLocaleDateString('ko-KR');

        li.innerHTML = `
            <a href="${post.link}" target="_blank">${post.title}</a>
            <span class="post-date">${date}</span>
        `;

        list.appendChild(li);
    });
}

// 페이지 로드 시 데이터 가져오기
document.addEventListener('DOMContentLoaded', () => {
    loadGithubData();
    loadBlogData();

    // 30분마다 데이터 갱신
    setInterval(() => {
        loadGithubData();
        loadBlogData();
    }, 30 * 60 * 1000);
});
