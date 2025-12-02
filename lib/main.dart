import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const PareLlelMemoryApp());
}

class PareLlelMemoryApp extends StatelessWidget {
  const PareLlelMemoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Parallel Memory - Market Cycle Pre-Alert System",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
