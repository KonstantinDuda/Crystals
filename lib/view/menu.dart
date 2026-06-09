// menu_overlay.dart
import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  final VoidCallback onTwoPlayers;
  final VoidCallback onVsAi;

  const HomeMenu({
    required this.onTwoPlayers,
    required this.onVsAi,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton("2 гравці", onTwoPlayers),
          const SizedBox(height: 20),
          _buildButton("Проти ШІ", onVsAi),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 60, 60, 80),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}