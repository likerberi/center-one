import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/breakpoints.dart';
import 'responsive_layout.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: Padding(
        padding: ResponsivePadding.all(context),
        child: ResponsiveLayout(
          mobile: _AboutMobile(),
          desktop: _AboutDesktop(),
        ),
      ),
    );
  }
}

class _AboutDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        Text(
          'Economic Engine Innovation',
          style: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 60),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FeatureCard(
                icon: Icons.insights,
                title: 'Data-Driven Insights',
                description: '데이터 기반의 인사이트로 최적의 경제 모델을 설계합니다',
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FeatureCard(
                icon: Icons.rocket_launch,
                title: 'Scalable Solutions',
                description: '확장 가능한 솔루션으로 지속적인 성장을 지원합니다',
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              child: _FeatureCard(
                icon: Icons.auto_awesome,
                title: 'Innovation First',
                description: '혁신을 최우선으로 새로운 가치를 창출합니다',
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class _AboutMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Text(
          'Economic Engine\nInnovation',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 40),
        _FeatureCard(
          icon: Icons.insights,
          title: 'Data-Driven Insights',
          description: '데이터 기반의 인사이트로 최적의 경제 모델을 설계합니다',
        ),
        const SizedBox(height: 24),
        _FeatureCard(
          icon: Icons.rocket_launch,
          title: 'Scalable Solutions',
          description: '확장 가능한 솔루션으로 지속적인 성장을 지원합니다',
        ),
        const SizedBox(height: 24),
        _FeatureCard(
          icon: Icons.auto_awesome,
          title: 'Innovation First',
          description: '혁신을 최우선으로 새로운 가치를 창출합니다',
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.heroGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
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
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
