import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'responsive_layout.dart';

class UseCasesSection extends StatelessWidget {
  const UseCasesSection({super.key});

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
              'Use Cases',
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
                '자산운용사부터 개인 투자자까지, 다양한 시나리오에 적용 가능합니다.',
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
              mobile: Column(
                children: [
                  _UseCaseCard(
                    icon: Icons.business,
                    title: '자산운용사 / 헤지펀드',
                    description: '위기 국면 사전 감지로 레버리지 축소, 헤지 강화\n회복 초입(겨울→봄)에서 공격적 배분',
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 24),
                  _UseCaseCard(
                    icon: Icons.smart_toy,
                    title: '리테일 로보어드바이저',
                    description: '고객에게 "시장 온도계"로 현재 시장 위치를 직관적으로 설명\n위험 선호도에 따른 포트폴리오 조정 제안',
                    color: AppColors.secondary,
                  ),
                  const SizedBox(height: 24),
                  _UseCaseCard(
                    icon: Icons.account_balance,
                    title: '기업 재무/자금운용',
                    description: '외화·원자재·금리 등 기업 리스크에 대해\n헤지 비율 조정 타이밍을 판단하는 보조지표',
                    color: AppColors.accent,
                  ),
                  const SizedBox(height: 24),
                  _UseCaseCard(
                    icon: Icons.school,
                    title: '투자 교육/리포트 서비스',
                    description: '특정 국가/산업/자산군의 "지금 계절"을 시각화\n프리미엄 리포트 제작 및 제공',
                    color: Colors.orange.shade700,
                  ),
                ],
              ),
              desktop: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _UseCaseCard(
                          icon: Icons.business,
                          title: '자산운용사 / 헤지펀드',
                          description: '위기 국면 사전 감지로 레버리지 축소, 헤지 강화\n회복 초입(겨울→봄)에서 공격적 배분',
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: _UseCaseCard(
                          icon: Icons.smart_toy,
                          title: '리테일 로보어드바이저',
                          description: '고객에게 "시장 온도계"로 현재 시장 위치를 직관적으로 설명\n위험 선호도에 따른 포트폴리오 조정 제안',
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _UseCaseCard(
                          icon: Icons.account_balance,
                          title: '기업 재무/자금운용',
                          description: '외화·원자재·금리 등 기업 리스크에 대해\n헤지 비율 조정 타이밍을 판단하는 보조지표',
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: _UseCaseCard(
                          icon: Icons.school,
                          title: '투자 교육/리포트 서비스',
                          description: '특정 국가/산업/자산군의 "지금 계절"을 시각화\n프리미엄 리포트 제작 및 제공',
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            _BusinessModelSection(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _UseCaseCard({
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
        color: Colors.white,
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
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(height: 20),
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
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessModelSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Business Model',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          ResponsiveLayout(
            mobile: Column(
              children: [
                _BusinessModelItem(
                  title: 'B2B 라이선스',
                  description: '자산운용사, 증권사, 보험사, 기업 대상\n엔진 사용료 + 커스터마이징',
                ),
                const SizedBox(height: 24),
                _BusinessModelItem(
                  title: 'B2C 구독 서비스',
                  description: '개인 투자자 대상\n글로벌 자산 온도계 + 프리-얼럿 리포트',
                ),
                const SizedBox(height: 24),
                _BusinessModelItem(
                  title: 'White-label',
                  description: '기존 금융플랫폼 내장\n수수료·사용량 기반 정산',
                ),
              ],
            ),
            desktop: Row(
              children: [
                Expanded(
                  child: _BusinessModelItem(
                    title: 'B2B 라이선스',
                    description: '자산운용사, 증권사, 보험사, 기업 대상\n엔진 사용료 + 커스터마이징',
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _BusinessModelItem(
                    title: 'B2C 구독 서비스',
                    description: '개인 투자자 대상\n글로벌 자산 온도계 + 프리-얼럿 리포트',
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _BusinessModelItem(
                    title: 'White-label',
                    description: '기존 금융플랫폼 내장\n수수료·사용량 기반 정산',
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

class _BusinessModelItem extends StatelessWidget {
  final String title;
  final String description;

  const _BusinessModelItem({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
