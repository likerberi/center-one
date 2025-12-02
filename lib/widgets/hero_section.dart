import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/breakpoints.dart';
import 'responsive_layout.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _HeroMobile(),
      desktop: _HeroDesktop(),
    );
  }
}

class _HeroDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
      ),
      child: Padding(
        padding: ResponsivePadding.all(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              "Parallel Memory",
              style: GoogleFonts.poppins(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Market Cycle Pre-Alert System',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.95),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                '시장 사이클을 계절로 시각화하여\n위기와 기회를 사전에 경보하는 금융 엔진',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 40,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _KeyFeature('Explainable', 'AI'),
                _KeyFeature('Pre-Alert', 'System'),
                _KeyFeature('Backtested', 'vs RL'),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _HeroMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
      ),
      child: Padding(
        padding: ResponsivePadding.all(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Text(
              "Parallel\nMemory",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Market Cycle\nPre-Alert System',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.95),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '시장 사이클을 계절로 시각화하여\n위기와 기회를 사전에 경보하는\n금융 엔진',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                _KeyFeature('Explainable', 'AI'),
                const SizedBox(height: 12),
                _KeyFeature('Pre-Alert', 'System'),
                const SizedBox(height: 12),
                _KeyFeature('Backtested', 'vs RL'),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class _KeyFeature extends StatelessWidget {
  final String main;
  final String sub;

  const _KeyFeature(this.main, this.sub);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        '$main $sub',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
