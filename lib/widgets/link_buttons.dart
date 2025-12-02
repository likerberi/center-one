import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/breakpoints.dart';
import 'responsive_layout.dart';

class LinkButtons extends StatelessWidget {
  const LinkButtons({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: ResponsivePadding.all(context),
        child: ResponsiveLayout(
          mobile: _LinkButtonsMobile(onLaunch: _launchUrl),
          desktop: _LinkButtonsDesktop(onLaunch: _launchUrl),
        ),
      ),
    );
  }
}

class _LinkButtonsDesktop extends StatelessWidget {
  final Future<void> Function(String) onLaunch;

  const _LinkButtonsDesktop({required this.onLaunch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Text(
          'Deep Dive',
          style: GoogleFonts.poppins(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '기술 문서와 데모를 확인하세요',
          style: GoogleFonts.notoSans(
            fontSize: 18,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LinkButton(
              title: 'Technical Blog',
              subtitle: '알고리즘 상세 설계 문서',
              icon: Icons.article,
              color: AppColors.primary,
              onPressed: () => onLaunch('https://YOUR_BLOGSPOT_URL.blogspot.com'),
            ),
            const SizedBox(width: 40),
            _LinkButton(
              title: 'Demo & Reports',
              subtitle: '백테스트 결과 및 데모',
              icon: Icons.analytics,
              color: AppColors.accent,
              onPressed: () => onLaunch('https://YOUR_STRIKINGLY_SITE.mystrikingly.com'),
            ),
          ],
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _LinkButtonsMobile extends StatelessWidget {
  final Future<void> Function(String) onLaunch;

  const _LinkButtonsMobile({required this.onLaunch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        Text(
          'Deep Dive',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '기술 문서와 데모를 확인하세요',
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSans(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 40),
        _LinkButton(
          title: 'Technical Blog',
          subtitle: '알고리즘 상세 설계 문서',
          icon: Icons.article,
          color: AppColors.primary,
          onPressed: () => onLaunch('https://YOUR_BLOGSPOT_URL.blogspot.com'),
        ),
        const SizedBox(height: 24),
        _LinkButton(
          title: 'Demo & Reports',
          subtitle: '백테스트 결과 및 데모',
          icon: Icons.analytics,
          color: AppColors.accent,
          onPressed: () => onLaunch('https://YOUR_STRIKINGLY_SITE.mystrikingly.com'),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class _LinkButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _LinkButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered ? widget.color : Colors.grey.shade200,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.color.withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: _isHovered ? 30 : 20,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 48,
                    color: widget.color,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Visit',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: widget.color,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      color: widget.color,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
