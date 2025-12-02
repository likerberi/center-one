import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'responsive_layout.dart';

class ProblemSection extends StatelessWidget {
  const ProblemSection({super.key});

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
              'The Problem',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                '자산시장은 항상 사이클을 탑니다. 하지만 대부분의 투자자와 기업은 "지금이 어느 구간인지" 직관적으로만 느끼고, 위기 구간에서 과감히 베팅하거나 과열 구간에서 뒤늦게 진입하는 실수를 반복합니다.',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  height: 1.8,
                ),
              ),
            ),
            const SizedBox(height: 60),
            ResponsiveLayout(
              mobile: _ProblemsMobile(),
              desktop: _ProblemsDesktop(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _ProblemsDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _ProblemCard(
            icon: Icons.visibility_off,
            title: '블랙박스 문제',
            description:
                '기존 퀀트/알고리즘 시스템은 모델이 왜 그런 결정을 내렸는지 설명하기 어렵습니다. 투자자는 신뢰하기 어렵고, 규제 당국은 승인하기 어렵습니다.',
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _ProblemCard(
            icon: Icons.warning,
            title: '과최적화 위험',
            description:
                '특정 시기·특정 종목에 과최적화(Overfitting)되기 쉽습니다. 백테스트는 완벽하지만 실전에서는 작동하지 않는 전형적인 함정입니다.',
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: _ProblemCard(
            icon: Icons.crisis_alert,
            title: '사후 대응',
            description:
                '대부분의 시스템은 위기가 발생한 후에 반응합니다. 하지만 진짜 필요한 것은 위기와 기회를 사전에 감지하는 Pre-Alert 시스템입니다.',
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}

class _ProblemsMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProblemCard(
          icon: Icons.visibility_off,
          title: '블랙박스 문제',
          description:
              '기존 퀀트/알고리즘 시스템은 모델이 왜 그런 결정을 내렸는지 설명하기 어렵습니다. 투자자는 신뢰하기 어렵고, 규제 당국은 승인하기 어렵습니다.',
          color: AppColors.primary,
        ),
        const SizedBox(height: 24),
        _ProblemCard(
          icon: Icons.warning,
          title: '과최적화 위험',
          description:
              '특정 시기·특정 종목에 과최적화(Overfitting)되기 쉽습니다. 백테스트는 완벽하지만 실전에서는 작동하지 않는 전형적인 함정입니다.',
          color: AppColors.accent,
        ),
        const SizedBox(height: 24),
        _ProblemCard(
          icon: Icons.crisis_alert,
          title: '사후 대응',
          description:
              '대부분의 시스템은 위기가 발생한 후에 반응합니다. 하지만 진짜 필요한 것은 위기와 기회를 사전에 감지하는 Pre-Alert 시스템입니다.',
          color: AppColors.secondary,
        ),
      ],
    );
  }
}

class _ProblemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _ProblemCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: color,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
