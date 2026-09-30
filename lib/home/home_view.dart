import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(22, 30, 22, 140),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _Greeting(),

                const SizedBox(height: 28),

                const _ProgressCard(),

                const SizedBox(height: 24),

                const _NextStepCard(),

                const SizedBox(height: 30),

                const Text(
                  'Hoy',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Tus compromisos para avanzar.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),

                const SizedBox(height: 14),

                const _TodayAction(
                  icon: Icons.fitness_center_rounded,
                  title: 'Entrenamiento',
                  subtitle: '45 min · pendiente',
                  progress: 0,
                ),

                const SizedBox(height: 10),

                const _TodayAction(
                  icon: Icons.menu_book_rounded,
                  title: 'Aprendizaje',
                  subtitle: '30 min · pendiente',
                  progress: 0,
                ),

                const SizedBox(height: 10),

                const _TodayAction(
                  icon: Icons.auto_awesome_rounded,
                  title: 'Hábito',
                  subtitle: 'Leer 10 páginas · pendiente',
                  progress: 0,
                ),

                const SizedBox(height: 10),

                const _TodayAction(
                  icon: Icons.self_improvement_rounded,
                  title: 'Reflexión',
                  subtitle: '10 min · completado',
                  progress: 1,
                  completed: true,
                ),

                const SizedBox(height: 10),

                const _TodayAction(
                  icon: Icons.rocket_launch_rounded,
                  title: 'Proyecto personal',
                  subtitle: '60 min · pendiente',
                  progress: 0,
                ),

                const SizedBox(height: 30),

                const _AssistantInsight(),

                const SizedBox(height: 30),

                const Text(
                  'Tu progreso',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 14),

                const _GrowthCard(),

                const SizedBox(height: 30),

                const _ReflectionCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BUENOS DÍAS',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 2.5,
            color: Colors.white.withValues(alpha: 0.4),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Construye tu día.',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Una acción a la vez.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withValues(alpha: 0.48),
          ),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF161D27),
            Color(0xFF0D1118),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'TU DÍA',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  color: Colors.white.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '2 / 5',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.4,
              minHeight: 7,
              backgroundColor: Color(0xFF242B35),
              valueColor: AlwaysStoppedAnimation(
                Color(0xFF64D8FF),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Text(
            'Dos compromisos completados. Todavía queda trabajo por hacer.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }
}

class _NextStepCard extends StatelessWidget {
  const _NextStepCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: const Color(0xFF101820),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF64D8FF).withValues(alpha: 0.14),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.near_me_rounded,
                size: 16,
                color: const Color(0xFF64D8FF).withValues(alpha: 0.85),
              ),
              const SizedBox(width: 7),
              Text(
                'TU SIGUIENTE PASO',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.8,
                  color: Colors.white.withValues(alpha: 0.42),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            'Entrenamiento',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            '45 minutos',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.45),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Es tu siguiente compromiso. Empieza ahora y deja libre el resto del día.',
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Colors.white.withValues(alpha: 0.58),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double progress;
  final bool completed;

  const _TodayAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.progress,
    this.completed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF10141A),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.055),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: completed
                  ? const Color(0xFF7DFFB2).withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              completed ? Icons.check_rounded : icon,
              color: completed
                  ? const Color(0xFF7DFFB2)
                  : Colors.white.withValues(alpha: 0.7),
              size: 21,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),

          Icon(
            completed
                ? Icons.check_circle_rounded
                : Icons.chevron_right_rounded,
            color: completed
                ? const Color(0xFF7DFFB2)
                : Colors.white.withValues(alpha: 0.25),
          ),
        ],
      ),
    );
  }
}

class _AssistantInsight extends StatelessWidget {
  const _AssistantInsight();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF12121A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF9D82FF).withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF9D82FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Color(0xFFB9A5FF),
              size: 20,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TU ASISTENTE',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.7,
                    color: Colors.white.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 9),

                const Text(
                  'Tienes entrenamiento pendiente.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'No necesitas completar todo ahora. Solo empieza con los primeros minutos.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.48),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GrowthCard extends StatelessWidget {
  const _GrowthCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GrowthItem(
            value: '6',
            title: 'DÍAS',
            subtitle: 'de consistencia',
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _GrowthItem(
            value: '82%',
            title: 'HÁBITOS',
            subtitle: 'cumplidos',
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _GrowthItem(
            value: '4',
            title: 'SEMANAS',
            subtitle: 'en progreso',
          ),
        ),
      ],
    );
  }
}

class _GrowthItem extends StatelessWidget {
  final String value;
  final String title;
  final String subtitle;

  const _GrowthItem({
    required this.value,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 17, 14, 17),
      decoration: BoxDecoration(
        color: const Color(0xFF10141A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              letterSpacing: 1.2,
              color: Color(0xFF64D8FF),
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  const _ReflectionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: const Color(0xFF10141A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.self_improvement_rounded,
                size: 18,
                color: Color(0xFFB9A5FF),
              ),
              const SizedBox(width: 8),
              const Text(
                'Reflexión',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            '¿Qué pequeña decisión de hoy te acerca más a la persona que quieres llegar a ser?',
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.white.withValues(alpha: 0.68),
            ),
          ),
        ],
      ),
    );
  }
}
