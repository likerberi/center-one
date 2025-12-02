import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'responsive_layout.dart';

class TechSection extends StatelessWidget {
  const TechSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: ResponsivePadding.all(context),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              'Technology & Validation',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Text(
                '강화학습 알고리즘과의 비교 검증을 통해 실전 투자 성능을 입증했습니다.',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  height: 1.8,
                ),
              ),
            ),
            const SizedBox(height: 80),
            _ComparisonSection(),
            const SizedBox(height: 80),
            _HowItWorksSection(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _ComparisonSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Parallel Memory vs Reinforcement Learning',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'AAPL, MT 2000~2018년 일별 데이터 백테스트',
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 48),
          ResponsiveLayout(
            mobile: Column(
              children: [
                _ComparisonCard(
                  title: 'Reinforcement Learning',
                  subtitle: '강화학습 알고리즘',
                  metrics: [
                    _Metric('수익률', '높음'),
                    _Metric('설명 가능성', '낮음 (블랙박스)'),
                    _Metric('큰 손실 회피', '중간'),
                    _Metric('과최적화 위험', '높음'),
                  ],
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                _ComparisonCard(
                  title: 'Parallel Memory',
                  subtitle: 'Vivaldi 금융엔진',
                  metrics: [
                    _Metric('수익률', '중상위 (특정 종목에서 우위)'),
                    _Metric('설명 가능성', '높음 (계절 기반)'),
                    _Metric('큰 손실 회피', '높음 (위기 사전 감지)'),
                    _Metric('과최적화 위험', '낮음 (일반화된 패턴)'),
                  ],
                  color: AppColors.primary,
                  highlighted: true,
                ),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _ComparisonCard(
                    title: 'Reinforcement Learning',
                    subtitle: '강화학습 알고리즘',
                    metrics: [
                      _Metric('수익률', '높음'),
                      _Metric('설명 가능성', '낮음 (블랙박스)'),
                      _Metric('큰 손실 회피', '중간'),
                      _Metric('과최적화 위험', '높음'),
                    ],
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: _ComparisonCard(
                    title: 'Parallel Memory',
                    subtitle: 'Vivaldi 금융엔진',
                    metrics: [
                      _Metric('수익률', '중상위 (특정 종목에서 우위)'),
                      _Metric('설명 가능성', '높음 (계절 기반)'),
                      _Metric('큰 손실 회피', '높음 (위기 사전 감지)'),
                      _Metric('과최적화 위험', '낮음 (일반화된 패턴)'),
                    ],
                    color: AppColors.primary,
                    highlighted: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<_Metric> metrics;
  final Color color;
  final bool highlighted;

  const _ComparisonCard({
    required this.title,
    required this.subtitle,
    required this.metrics,
    required this.color,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: highlighted ? color.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(highlighted ? 0.5 : 0.2),
          width: highlighted ? 3 : 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          ...metrics.map((metric) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metric.label,
                    style: GoogleFonts.notoSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    metric.value,
                    style: GoogleFonts.notoSans(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _Metric {
  final String label;
  final String value;

  _Metric(this.label, this.value);
}

class _HowItWorksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'How It Works',
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 48),
        ResponsiveLayout(
          mobile: Column(
            children: [
              _WorkflowStep(
                number: '1',
                title: '데이터 수집',
                description: '주식, 채권, 원자재, 환율 등 자산의 일별 가격·거래량 데이터 수집\n필요 시 거시지표(금리, 물가, 유동성) 연동',
              ),
              const SizedBox(height: 24),
              _WorkflowStep(
                number: '2',
                title: '사이클 분석',
                description: '변동성, 추세, 드로우다운, 회복 속도를 바탕으로\n가격 흐름을 계절 구간(겨울→봄→여름→가을)으로 분류',
              ),
              const SizedBox(height: 24),
              _WorkflowStep(
                number: '3',
                title: 'Pre-Alert 생성',
                description: '현재 구간이 과거 위기/기회 패턴과 유사한지 계산\n임계치를 넘으면 위기 경보 또는 기회 경보 발송',
              ),
              const SizedBox(height: 24),
              _WorkflowStep(
                number: '4',
                title: '시각화 대시보드',
                description: '시간축 위에 계절 구간을 색깔로 표시\n포지션(매수/매도/현금비중) 변화를 직관적으로 제공',
              ),
            ],
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _WorkflowStep(
                  number: '1',
                  title: '데이터 수집',
                  description: '주식, 채권, 원자재, 환율 등 자산의 일별 가격·거래량 데이터 수집\n필요 시 거시지표 연동',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _WorkflowStep(
                  number: '2',
                  title: '사이클 분석',
                  description: '변동성, 추세, 드로우다운을 바탕으로 가격 흐름을 계절 구간으로 분류',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _WorkflowStep(
                  number: '3',
                  title: 'Pre-Alert 생성',
                  description: '과거 패턴과 비교하여 위기/기회 경보 발송',
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _WorkflowStep(
                  number: '4',
                  title: '시각화',
                  description: '계절 구간과 포지션 변화를 직관적으로 제공',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WorkflowStep extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _WorkflowStep({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: AppColors.heroGradient,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
