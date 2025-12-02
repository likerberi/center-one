# Parallel Memory

**Market Cycle Pre-Alert System**

시장 사이클을 계절로 시각화하여 위기와 기회를 사전에 경보하는 금융 엔진

## 주요 특징

- ✅ **Explainable AI**: 블랙박스가 아닌 설명 가능한 알고리즘
- ✅ **Pre-Alert System**: 위기와 기회를 사전에 경보
- ✅ **Season Metaphor**: 시장을 봄·여름·가을·겨울로 직관적 시각화
- ✅ **Backtested vs RL**: 강화학습 알고리즘과 비교 검증 완료
- ✅ **완전 반응형**: 모바일/태블릿/데스크톱 최적화
- ✅ **Google Fonts**: Poppins (영문) + Noto Sans (한글)

## 설치 및 실행

### 1. Flutter 설치 확인
```bash
flutter --version
```

### 2. 의존성 설치
```bash
flutter pub get
```

### 3. 웹에서 실행 (개발 모드)
```bash
flutter run -d chrome
```

### 4. 빌드 (배포용)
```bash
flutter build web
```

빌드된 파일은 `build/web` 폴더에 생성됩니다.

## Firebase Hosting 배포

### 1. Firebase CLI 설치
```bash
npm install -g firebase-tools
```

### 2. Firebase 로그인
```bash
firebase login
```

### 3. Firebase 초기화 (이미 되어있다면 스킵)
```bash
firebase init hosting
```
- `build/web`을 public 디렉토리로 설정
- SPA 설정: Yes

### 4. 배포
```bash
flutter build web
firebase deploy --only hosting
```

## 커스터마이징

### 링크 수정
`lib/widgets/link_buttons.dart` 파일에서 URL을 수정하세요:

```dart
onPressed: () => onLaunch('https://YOUR_BLOGSPOT_URL.blogspot.com'),
```

### 색상 변경
`lib/constants/app_colors.dart`에서 색상을 변경할 수 있습니다.

### 콘텐츠 수정
각 섹션의 파일에서 텍스트를 수정하세요:
- `lib/widgets/hero_section.dart` - 메인 히어로 섹션
- `lib/widgets/problem_section.dart` - 문제 정의
- `lib/widgets/solution_section.dart` - 솔루션 (계절 메타포)
- `lib/widgets/tech_section.dart` - 기술 및 검증
- `lib/widgets/use_cases_section.dart` - 활용 시나리오
- `lib/widgets/link_buttons.dart` - 링크 버튼

## 프로젝트 구조

```
lib/
├── main.dart                      # 앱 진입점
├── screens/
│   └── home_screen.dart           # 홈 화면
├── widgets/
│   ├── responsive_layout.dart     # 반응형 레이아웃 헬퍼
│   ├── hero_section.dart          # 히어로 섹션
│   ├── problem_section.dart       # 문제 정의 (블랙박스, 과최적화)
│   ├── solution_section.dart      # 솔루션 (계절 메타포, Pre-Alert)
│   ├── tech_section.dart          # 기술 검증 (RL 비교, 작동 원리)
│   ├── use_cases_section.dart     # 활용 시나리오 (B2B/B2C)
│   └── link_buttons.dart          # 기술 문서/데모 링크
└── constants/
    ├── app_colors.dart            # 색상 정의
    └── breakpoints.dart           # 반응형 breakpoint
```

## 페이지 구성

1. **Hero Section**: Pre-Alert 시스템 소개
2. **Problem Section**: 기존 시스템의 문제점 (블랙박스, 과최적화, 사후 대응)
3. **Solution Section**: 계절 메타포 기반 솔루션 (겨울·봄·여름·가을)
4. **Technology Section**: 강화학습과의 비교 검증, 작동 원리
5. **Use Cases Section**: B2B/B2C 활용 시나리오 및 비즈니스 모델
6. **Deep Dive Section**: 기술 문서 및 데모 링크

## 반응형 breakpoint

- 모바일: < 600px
- 태블릿: 600px ~ 1200px
- 데스크톱: >= 1200px

## 라이선스

MIT
