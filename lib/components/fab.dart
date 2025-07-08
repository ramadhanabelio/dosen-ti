import 'package:flutter/material.dart';
import '../constants/theme.dart';
import '../pages/login.dart';

class FAB extends StatelessWidget {
  const FAB({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppGradients.greenGradient,
        ),
        child: const Icon(Icons.admin_panel_settings, color: Colors.white),
      ),
    );
  }
}
