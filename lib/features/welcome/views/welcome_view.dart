import 'package:flutter/material.dart';
import 'package:pharmazon_web/features/welcome/views/widgets/welcome_view_body.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffacf4ff),
      body: WelcomeViewBody(),
    );
  }
}
