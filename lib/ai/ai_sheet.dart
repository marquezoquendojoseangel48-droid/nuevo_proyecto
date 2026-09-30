import 'package:flutter/material.dart';

class AICommandSheet extends StatelessWidget {
  const AICommandSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        22,
        12,
        22,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0C1016),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 28),
            const Icon(
              Icons.auto_awesome_rounded,
              size: 32,
              color: Color(0xFF64D8FF),
            ),
            const SizedBox(height: 14),
            const Text(
              '¿Qué necesitas?',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Tu acompañante está aquí.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.42),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Escribe o habla...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.045),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(
                  Icons.mic_none_rounded,
                  color: Color(0xFF64D8FF),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
