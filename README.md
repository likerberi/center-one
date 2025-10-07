# 📊 Activity Dashboard

NestJS + TypeScript로 구현한 GitHub 활동 및 블로그 통계 대시보드

## 🌟 주요 기능

- **GitHub 통계**: 커밋, PR, 이슈 통계 및 일별 기여도 차트
- **블로그 RSS**: RSS 피드를 통한 블로그 포스팅 통계
- **Redis 캐싱**: API 응답 캐싱으로 빠른 성능 제공
- **실시간 대시보드**: Chart.js 기반 인터랙티브 시각화

## 📁 프로젝트 구조

```
activity-dashboard/
├── src/
│   ├── main.ts                      # 애플리케이션 진입점
│   ├── app.module.ts                # 루트 모듈
│   └── modules/
│       ├── github/                  # GitHub API 모듈
│       │   ├── github.module.ts
│       │   ├── github.service.ts
│       │   └── github.controller.ts
│       ├── blog/                    # 블로그 RSS 모듈
│       │   ├── blog.module.ts
│       │   ├── blog.service.ts
│       │   └── blog.controller.ts
│       └── cache/                   # Redis 캐시 모듈
│           ├── cache.module.ts
│           └── cache.service.ts
├── public/                          # 정적 파일 (프론트엔드)
│   ├── index.html
│   ├── style.css
│   └── app.js
├── .env.example                     # 환경변수 템플릿
└── README.md
```

## 🚀 시작하기

### 1. 필수 요구사항

- Node.js 18 이상
- Redis 서버
- GitHub Personal Access Token (선택사항, API 제한 완화)

### 2. 설치

```bash
# 의존성 설치
npm install

# 환경변수 설정
cp .env.example .env
```

### 3. 환경변수 설정

`.env` 파일을 열고 다음 값을 설정하세요:

```env
# 서버 설정
PORT=3000

# GitHub 설정
GITHUB_USERNAME=your-github-username
GITHUB_TOKEN=your-github-personal-access-token

# 블로그 RSS 설정
BLOG_RSS_URL=https://your-blog.com/rss

# Redis 설정
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=
REDIS_DB=0
```

### 4. Redis 실행

```bash
# Docker를 사용하는 경우
docker run -d -p 6379:6379 redis:latest

# 또는 로컬 Redis 서버 실행
redis-server
```

### 5. 애플리케이션 실행

```bash
# 개발 모드
npm run start:dev

# 프로덕션 빌드
npm run build
npm run start:prod
```

브라우저에서 `http://localhost:3000`으로 접속하세요.

## 📡 API 엔드포인트

### GitHub Activity

```
GET /api/github/activity?username={username}
```

응답 예시:
```json
{
  "totalCommits": 42,
  "totalPRs": 15,
  "totalIssues": 8,
  "recentEvents": [...],
  "contributions": [
    { "date": "2025-10-07", "count": 5 }
  ]
}
```

### Blog Activity

```
GET /api/blog/activity?rssUrl={rssUrl}
```

응답 예시:
```json
{
  "totalPosts": 24,
  "recentPosts": [...],
  "postsPerMonth": [
    { "month": "2025-10", "count": 3 }
  ]
}
```

## 🏗️ 기술 스택

### Backend
- **NestJS**: Node.js 프레임워크
- **TypeScript**: 타입 안전성
- **Redis**: 캐싱
- **Axios**: HTTP 클라이언트
- **rss-parser**: RSS 피드 파싱

### Frontend
- **Vanilla JavaScript**: 프론트엔드 로직
- **Chart.js**: 데이터 시각화
- **CSS3**: 스타일링

## 🔧 개발

### 프로젝트 빌드

```bash
npm run build
```

### 타입 체크

```bash
npx tsc --noEmit
```

## 📝 주요 특징

### 1. 모듈화된 아키텍처
NestJS의 모듈 시스템을 활용하여 각 기능을 독립적인 모듈로 분리했습니다.

### 2. 캐싱 전략
Redis를 사용하여 API 응답을 1시간 동안 캐싱하여 외부 API 호출을 최소화합니다.

### 3. 타입 안전성
TypeScript를 사용하여 컴파일 타임에 타입 오류를 방지합니다.

### 4. 에러 처리
각 서비스에서 적절한 에러 처리를 수행하여 안정성을 보장합니다.

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

ISC License

## 📧 문의

프로젝트에 대한 질문이나 제안사항이 있으시면 이슈를 열어주세요.
