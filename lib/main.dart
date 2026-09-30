import 'dart:ui';

import 'package:flutter/material.dart';

import 'home/home_view.dart';
import 'habits/habits_view.dart';
import 'body/body_view.dart';
import 'learn/learn_view.dart';
import 'ai/ai_sheet.dart';

void main() {
  runApp(const GrowthApp());
}

class GrowthApp extends StatelessWidget {
  const GrowthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Growth',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF07090D),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const GrowthHome(),
    );
  }
}

enum AppSection {
  home,
  habits,
  body,
  learn,
}

class GrowthHome extends StatefulWidget {
  const GrowthHome({super.key});

  @override
  State<GrowthHome> createState() => _GrowthHomeState();
}

class _GrowthHomeState extends State<GrowthHome>
    with SingleTickerProviderStateMixin {
  AppSection _section = AppSection.home;
  bool _dockExpanded = false;

  late final AnimationController _dockController;

  @override
  void initState() {
    super.initState();

    _dockController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  @override
  void dispose() {
    _dockController.dispose();
    super.dispose();
  }

  void _selectSection(AppSection section) {
    setState(() {
      _section = section;
      _dockExpanded = false;
    });

    _dockController.reverse();
  }

  void _toggleDock() {
    setState(() {
      _dockExpanded = !_dockExpanded;
    });

    if (_dockExpanded) {
      _dockController.forward();
    } else {
      _dockController.reverse();
    }
  }

  void _openAI() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const AICommandSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _buildSection(),
          ),

          // Degradado inferior para integrar visualmente
          // el contenido con el dock.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 180,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color(0xFF07090D).withValues(alpha: 0.92),
                    ],
                  ),
                ),
              ),
            ),
          ),

          _buildNavigationDock(),
        ],
      ),
    );
  }

  Widget _buildSection() {
    switch (_section) {
      case AppSection.home:
        return const HomeView(
          key: ValueKey('home'),
        );

      case AppSection.habits:
        return const HabitsView(
          key: ValueKey('habits'),
        );

      case AppSection.body:
        return const BodyView(
          key: ValueKey('body'),
        );

      case AppSection.learn:
        return const LearnView(
          key: ValueKey('learn'),
        );
    }
  }

  Widget _buildNavigationDock() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 24,
      child: SafeArea(
        top: false,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            height: _dockExpanded ? 78 : 68,
            constraints: const BoxConstraints(
              maxWidth: 430,
            ),
            child: _GrowthDock(
              expanded: _dockExpanded,
              section: _section,
              onSectionSelected: _selectSection,
              onAI: _openAI,
              onToggleExpanded: _toggleDock,
            ),
          ),
        ),
      ),
    );
  }
}

class _GrowthDock extends StatelessWidget {
  final bool expanded;
  final AppSection section;
  final ValueChanged<AppSection> onSectionSelected;
  final VoidCallback onAI;
  final VoidCallback onToggleExpanded;

  const _GrowthDock({
    required this.expanded,
    required this.section,
    required this.onSectionSelected,
    required this.onAI,
    required this.onToggleExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DockShadowPainter(
        opacity: expanded ? 0.46 : 0.40,
      ),
      child: ClipPath(
        clipper: const _DockCapsuleClipper(),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22,
            sigmaY: 22,
          ),
          child: Stack(
            children: [
              // Fondo del dock.
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF11151C).withValues(
                      alpha: expanded ? 0.86 : 0.82,
                    ),
                  ),
                ),
              ),

              // Borde siguiendo exactamente la misma cápsula.
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _DockBorderPainter(),
                  ),
                ),
              ),

              // Contenido.
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      child: _DockItem(
                        icon: Icons.grid_view_rounded,
                        label: 'Inicio',
                        selected: section == AppSection.home,
                        onTap: () {
                          onSectionSelected(AppSection.home);
                        },
                      ),
                    ),

                    Expanded(
                      child: _DockItem(
                        icon: Icons.track_changes_rounded,
                        label: 'Hábitos',
                        selected: section == AppSection.habits,
                        onTap: () {
                          onSectionSelected(AppSection.habits);
                        },
                      ),
                    ),

                    // Espacio reservado para el botón central.
                    const SizedBox(width: 70),

                    Expanded(
                      child: _DockItem(
                        icon: Icons.fitness_center_rounded,
                        label: 'Cuerpo',
                        selected: section == AppSection.body,
                        onTap: () {
                          onSectionSelected(AppSection.body);
                        },
                      ),
                    ),

                    Expanded(
                      child: _DockItem(
                        icon: Icons.menu_book_rounded,
                        label: 'Aprender',
                        selected: section == AppSection.learn,
                        onTap: () {
                          onSectionSelected(AppSection.learn);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Botón central de IA.
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: onAI,
                    onLongPress: onToggleExpanded,
                    child: const _AIDockButton(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AIDockButton extends StatelessWidget {
  const _AIDockButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFB8F3FF),
            Color(0xFF5AD8FF),
            Color(0xFF278CFF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF39BFFF).withValues(alpha: 0.35),
            blurRadius: 22,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Icon(
        Icons.auto_awesome_rounded,
        color: Colors.black,
        size: 24,
      ),
    );
  }
}

class _DockItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DockItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        splashColor: Colors.white.withValues(alpha: 0.04),
        highlightColor: Colors.white.withValues(alpha: 0.025),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: selected
                ? Colors.white.withValues(alpha: 0.07)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: selected ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                child: Icon(
                  icon,
                  size: 21,
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.42),
                ),
              ),
              const SizedBox(height: 3),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.42),
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// FORMA EXTERIOR DEL DOCK
///
/// No utiliza BorderRadius.
/// Los extremos izquierdo y derecho son semicircunferencias completas.
///

class _DockCapsuleClipper extends CustomClipper<Path> {
  const _DockCapsuleClipper();

  @override
  Path getClip(Size size) {
    final radius = size.height / 2;

    final path = Path();

    path.moveTo(radius, 0);

    path.lineTo(size.width - radius, 0);

    path.arcToPoint(
      Offset(
        size.width - radius,
        size.height,
      ),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    path.lineTo(radius, size.height);

    path.arcToPoint(
      Offset(
        radius,
        0,
      ),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

///
/// SOMBRA
///
/// Importante:
/// La sombra utiliza exactamente la misma geometría de cápsula.
/// No hay BorderRadius antiguo aquí.
///

class _DockShadowPainter extends CustomPainter {
  final double opacity;

  const _DockShadowPainter({
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;

    final path = Path();

    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);

    path.arcToPoint(
      Offset(
        size.width - radius,
        size.height,
      ),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    path.lineTo(radius, size.height);

    path.arcToPoint(
      Offset(
        radius,
        0,
      ),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    path.close();

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: opacity)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        18,
      );

    canvas.drawPath(
      path.shift(const Offset(0, 10)),
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DockShadowPainter oldDelegate) {
    return oldDelegate.opacity != opacity;
  }
}

///
/// BORDE
///
/// También sigue exactamente la cápsula.
///

class _DockBorderPainter extends CustomPainter {
  const _DockBorderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;

    final path = Path();

    path.moveTo(radius, 0.5);

    path.lineTo(
      size.width - radius,
      0.5,
    );

    path.arcToPoint(
      Offset(
        size.width - radius,
        size.height - 0.5,
      ),
      radius: Radius.circular(radius - 0.5),
      clockwise: true,
    );

    path.lineTo(
      radius,
      size.height - 0.5,
    );

    path.arcToPoint(
      Offset(
        radius,
        0.5,
      ),
      radius: Radius.circular(radius - 0.5),
      clockwise: true,
    );

    path.close();

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white.withValues(alpha: 0.08);

    canvas.drawPath(
      path,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}