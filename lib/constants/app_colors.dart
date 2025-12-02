import 'package:flutter/material.dart';

class AppColors {
  // 메인 컬러 - 깔끔하고 모던한 느낌
  static const Color primary = Color(0xFF2563EB); // 블루
  static const Color secondary = Color(0xFF10B981); // 그린
  static const Color accent = Color(0xFF8B5CF6); // 퍼플

  // 배경색
  static const Color background = Color(0xFFF8FAFC);
  static const Color cardBackground = Colors.white;

  // 텍스트 컬러
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);

  // 그라데이션
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2563EB), Color(0xFF8B5CF6)],
  );
}
