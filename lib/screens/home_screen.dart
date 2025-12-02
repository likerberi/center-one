import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/problem_section.dart';
import '../widgets/solution_section.dart';
import '../widgets/tech_section.dart';
import '../widgets/use_cases_section.dart';
import '../widgets/link_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            HeroSection(),
            ProblemSection(),
            SolutionSection(),
            TechSection(),
            UseCasesSection(),
            LinkButtons(),
          ],
        ),
      ),
    );
  }
}
