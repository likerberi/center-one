import 'package:flutter/material.dart';
import '../constants/breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (Breakpoints.isDesktop(width)) {
          return desktop;
        } else if (Breakpoints.isTablet(width)) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

// 반응형 패딩 헬퍼
class ResponsivePadding {
  static EdgeInsets horizontal(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (Breakpoints.isDesktop(width)) {
      return const EdgeInsets.symmetric(horizontal: 120);
    } else if (Breakpoints.isTablet(width)) {
      return const EdgeInsets.symmetric(horizontal: 60);
    } else {
      return const EdgeInsets.symmetric(horizontal: 24);
    }
  }

  static EdgeInsets all(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (Breakpoints.isDesktop(width)) {
      return const EdgeInsets.all(120);
    } else if (Breakpoints.isTablet(width)) {
      return const EdgeInsets.all(60);
    } else {
      return const EdgeInsets.all(24);
    }
  }
}
