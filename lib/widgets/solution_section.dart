import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'responsive_layout.dart';

class SolutionSection extends StatelessWidget {
  const SolutionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: Padding(
        padding: ResponsivePadding.all(context),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              'Our Solution',
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
                'Parallel Memory는 시장 데이터를 계절로 번역하여, 누구나 이해할 수 있는 방식으로 위기와 기회를 사전에 경보합니다.',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  height: 1.8,
                ),
              ),
            ),
            const SizedBox(height: 80),
            ResponsiveLayout(
              mobile: _SeasonsMobile(),
              desktop: _SeasonsDesktop(),
            ),
            const SizedBox(height: 80),
            _CoreFeaturesSection(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _SeasonsDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SeasonCard(
            season: '겨울 Winter',
            icon: '❄️',
            description: '위기 국면\n최대 낙폭 구간',
            color: Colors.blue.shade700,
            alert: '장기 투자자에게 기회',
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _SeasonCard(
            season: '봄 Spring',
            icon: '🌱',
            description: '회복·초기 상승\n저점 탈출',
            color: Colors.green.shade600,
            alert: '적극적 배분 시작',
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _SeasonCard(
            season: '여름 Summer',
            icon: '☀️',
            description: '과열·고점 형성\n변동성 증가',
            color: Colors.orange.shade700,
            alert: '레버리지 조심',
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _SeasonCard(
            season: '가을 Autumn',
            icon: '🍂',
            description: '피크 이후 둔화\n조정 시작',
            color: Colors.brown.shade600,
            alert: '위험 축소 타이밍',
          ),
        ),
      ],
    );
  }
}

class _SeasonsMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SeasonCard(
          season: '겨울 Winter',
          icon: '❄️',
          description: '위기 국면 · 최대 낙폭 구간',
          color: Colors.blue.shade700,
          alert: '장기 투자자에게 기회',
        ),
        const SizedBox(height: 16),
        _SeasonCard(
          season: '봄 Spring',
          icon: '🌱',
          description: '회복·초기 상승 · 저점 탈출',
          color: Colors.green.shade600,
          alert: '적극적 배분 시작',
        ),
        const SizedBox(height: 16),
        _SeasonCard(
          season: '여름 Summer',
          icon: '☀️',
          description: '과열·고점 형성 · 변동성 증가',
          color: Colors.orange.shade700,
          alert: '레버리지 조심',
        ),
        const SizedBox(height: 16),
        _SeasonCard(
          season: '가을 Autumn',
          icon: '🍂',
          description: '피크 이후 둔화 · 조정 시작',
          color: Colors.brown.shade600,
          alert: '위험 축소 타이밍',
        ),
      ],
    );
  }
}

class _SeasonCard extends StatelessWidget {
  final String season;
  final String icon;
  final String description;
  final Color color;
  final String alert;

  const _SeasonCard({
    required this.season,
    required this.icon,
    required this.description,
    required this.color,
    required this.alert,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(height: 12),
          Text(
            season,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
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
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              alert,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoreFeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.05),
            AppColors.accent.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Core Features',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 40),
          ResponsiveLayout(
            mobile: Column(
              children: [
                _FeatureItem(
                  number: '01',
                  title: 'Pre-Alert System',
                  description: '위기 경보(Risk Alert)와 기회 경보(Opportunity Alert)를 사전에 발송',
                ),
                const SizedBox(height: 24),
                _FeatureItem(
                  number: '02',
                  title: 'Parallel Memory',
                  description: '여러 국가·산업·자산군의 위기/기회 패턴을 데이터베이스화하여 과거 유사 패턴과 비교',
                ),
                const SizedBox(height: 24),
                _FeatureItem(
                  number: '03',
                  title: 'Explainable Algorithm',
                  description: '"지금은 겨울→봄 구간이기 때문에 매수 비중을 늘려야 합니다"처럼 사람 언어로 설명 가능',
                ),
              ],
            ),
            desktop: Column(
              children: [
                _FeatureItem(
                  number: '01',
                  title: 'Pre-Alert System',
                  description: '위기 경보(Risk Alert)와 기회 경보(Opportunity Alert)를 사전에 발송',
                ),
                const SizedBox(height: 20),
                _FeatureItem(
                  number: '02',
                  title: 'Parallel Memory',
                  description: '여러 국가·산업·자산군의 위기/기회 패턴을 데이터베이스화하여 과거 유사 패턴과 비교',
                ),
                const SizedBox(height: 20),
                _FeatureItem(
                  number: '03',
                  title: 'Explainable Algorithm',
                  description: '"지금은 겨울→봄 구간이기 때문에 매수 비중을 늘려야 합니다"처럼 사람 언어로 설명 가능',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _FeatureItem({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: AppColors.heroGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.notoSans(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
