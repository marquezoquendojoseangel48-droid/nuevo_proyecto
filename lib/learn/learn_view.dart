import 'package:flutter/material.dart';

class LearnView extends StatefulWidget {
  const LearnView({super.key});

  @override
  State<LearnView> createState() => _LearnViewState();
}

class _LearnViewState extends State<LearnView> {
  bool _sessionStarted = false;
  int _completedSessions = 12;
  int _weeklyMinutes = 270;
  int _studyStreak = 6;

  final List<_LearningTopic> _topics = [
    _LearningTopic(
      icon: Icons.psychology_rounded,
      title: 'Pensamiento crítico',
      subtitle: 'Analizar · Cuestionar · Argumentar',
      progress: 0.64,
      level: 'Intermedio',
    ),
    _LearningTopic(
      icon: Icons.code_rounded,
      title: 'Tecnología',
      subtitle: 'Programación · Sistemas · IA',
      progress: 0.42,
      level: 'En progreso',
    ),
    _LearningTopic(
      icon: Icons.auto_stories_rounded,
      title: 'Lectura',
      subtitle: 'Comprensión · Análisis · Síntesis',
      progress: 0.78,
      level: 'Avanzado',
    ),
  ];

  void _startLearningSession() {
    setState(() {
      _sessionStarted = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LearningSessionSheet(
        onSessionCompleted: (minutes) {
          setState(() {
            _completedSessions++;
            _weeklyMinutes += minutes;
            _sessionStarted = false;
          });
        },
      ),
    );
  }

  void _openReview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _ReviewSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 30, 22, 140),
        children: [
          const Text(
            'Aprender',
            style: TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'El conocimiento también se entrena.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 28),

          // ============================================================
          // APRENDIZAJE DE HOY
          // ============================================================

          const _SectionTitle(
            title: 'HOY',
            subtitle: 'Tu siguiente sesión de aprendizaje',
          ),

          const SizedBox(height: 12),

          _TodayLearningCard(
            started: _sessionStarted,
            onStart: _startLearningSession,
          ),

          const SizedBox(height: 30),

          // ============================================================
          // RUTA DE APRENDIZAJE
          // ============================================================

          const _SectionTitle(
            title: 'TU RUTA',
            subtitle: 'Áreas que estás desarrollando',
          ),

          const SizedBox(height: 12),

          ..._topics.asMap().entries.map(
            (entry) {
              final topic = entry.value;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key == _topics.length - 1 ? 0 : 10,
                ),
                child: _LearningTopicCard(
                  topic: topic,
                  onTap: () {
                    _openTopic(topic);
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 30),

          // ============================================================
          // APRENDER HACIENDO
          // ============================================================

          const _SectionTitle(
            title: 'APRENDER HACIENDO',
            subtitle: 'No solo consumas información',
          ),

          const SizedBox(height: 12),

          _LearningMethodCard(),

          const SizedBox(height: 30),

          // ============================================================
          // REPASO
          // ============================================================

          const _SectionTitle(
            title: 'REPASO',
            subtitle: 'Mantén activo lo que ya aprendiste',
          ),

          const SizedBox(height: 12),

          _ReviewCard(
            onTap: _openReview,
          ),

          const SizedBox(height: 30),

          // ============================================================
          // PROGRESO
          // ============================================================

          const _SectionTitle(
            title: 'TU PROGRESO',
            subtitle: 'La constancia también cuenta',
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  value: '$_completedSessions',
                  label: 'SESIONES',
                  icon: Icons.school_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  value: _formatMinutes(_weeklyMinutes),
                  label: 'ESTA SEMANA',
                  icon: Icons.schedule_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  value: '$_studyStreak',
                  label: 'DÍAS SEGUIDOS',
                  icon: Icons.local_fire_department_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  value: '83%',
                  label: 'RETENCIÓN',
                  icon: Icons.memory_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ============================================================
          // ASISTENTE
          // ============================================================

          const _SectionTitle(
            title: 'ASISTENTE',
            subtitle: 'Una recomendación basada en tu progreso',
          ),

          const SizedBox(height: 12),

          _AssistantLearningCard(),
        ],
      ),
    );
  }

  void _openTopic(_LearningTopic topic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _TopicSheet(topic: topic),
    );
  }

  String _formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final remaining = minutes % 60;

    if (hours == 0) {
      return '${remaining}m';
    }

    if (remaining == 0) {
      return '${hours}h';
    }

    return '${hours}h ${remaining}m';
  }
}

// ============================================================================
// SECTION TITLE
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: Colors.white.withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.32),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// TODAY
// ============================================================================

class _TodayLearningCard extends StatelessWidget {
  final bool started;
  final VoidCallback onStart;

  const _TodayLearningCard({
    required this.started,
    required this.onStart,
  });

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
            Color(0xFF182331),
            Color(0xFF0D1218),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF64D8FF).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  color: Color(0xFF64D8FF),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  started ? 'EN CURSO' : 'HOY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            'Arquitectura de software',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'Tecnología · Fundamentos',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.42),
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              _InfoChip(
                icon: Icons.schedule_rounded,
                text: '25 min',
              ),
              const SizedBox(width: 8),
              _InfoChip(
                icon: Icons.lightbulb_outline_rounded,
                text: '3 conceptos',
              ),
              const SizedBox(width: 8),
              _InfoChip(
                icon: Icons.quiz_outlined,
                text: '5 preguntas',
              ),
            ],
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                started
                    ? 'CONTINUAR APRENDIENDO'
                    : 'COMENZAR SESIÓN',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// INFO CHIP
// ============================================================================

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.045),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: Colors.white.withValues(alpha: 0.4),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// TOPIC CARD
// ============================================================================

class _LearningTopicCard extends StatelessWidget {
  final _LearningTopic topic;
  final VoidCallback onTap;

  const _LearningTopicCard({
    required this.topic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(23),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF10141A),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.055),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.045),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    topic.icon,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 20,
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        topic.subtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${(topic.progress * 100).round()}%',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      topic.level,
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 15),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: topic.progress,
                minHeight: 5,
                backgroundColor: Colors.white.withValues(alpha: 0.06),
                valueColor: const AlwaysStoppedAnimation(
                  Color(0xFF64D8FF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// LEARNING METHOD
// ============================================================================

class _LearningMethodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = [
      ('01', 'Explicación', Icons.menu_book_rounded),
      ('02', 'Pregunta', Icons.help_outline_rounded),
      ('03', 'Ejercicio', Icons.edit_note_rounded),
      ('04', 'Evaluación', Icons.fact_check_outlined),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF10141A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.055),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              children: [
                Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.045),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    steps[i].$3,
                    size: 17,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),

                const SizedBox(width: 13),

                Text(
                  steps[i].$1,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  steps[i].$2,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            if (i < steps.length - 1)
              Container(
                margin: const EdgeInsets.only(
                  left: 19,
                  top: 5,
                  bottom: 5,
                ),
                height: 13,
                width: 1,
                color: Colors.white.withValues(alpha: 0.08),
              ),
          ],
        ],
      ),
    );
  }
}

// ============================================================================
// REVIEW
// ============================================================================

class _ReviewCard extends StatelessWidget {
  final VoidCallback onTap;

  const _ReviewCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF10141A),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.055),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.replay_rounded,
                color: Colors.white.withValues(alpha: 0.65),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '8 conceptos pendientes',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Repasa lo aprendido para reforzar la memoria.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.32),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// METRICS
// ============================================================================

class _MetricCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _MetricCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF11161D),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: Colors.white.withValues(alpha: 0.38),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ASSISTANT
// ============================================================================

class _AssistantLearningCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF161D27),
            Color(0xFF10151C),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF64D8FF).withValues(alpha: 0.08),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 18,
              color: Color(0xFF64D8FF),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RECOMENDACIÓN',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Has avanzado bien en lectura. '
                  'Hoy conviene reforzar arquitectura de software '
                  'antes de pasar al siguiente tema.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.white.withValues(alpha: 0.5),
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

// ============================================================================
// LEARNING SESSION
// ============================================================================

class _LearningSessionSheet extends StatefulWidget {
  final void Function(int minutes) onSessionCompleted;

  const _LearningSessionSheet({
    required this.onSessionCompleted,
  });

  @override
  State<_LearningSessionSheet> createState() =>
      _LearningSessionSheetState();
}

class _LearningSessionSheetState extends State<_LearningSessionSheet> {
  int _step = 0;
  int _selectedAnswer = -1;
  bool _answerChecked = false;

  final List<String> _steps = [
    'EXPLICACIÓN',
    'PREGUNTA',
    'EJERCICIO',
    'EVALUACIÓN',
  ];

  void _next() {
    if (_step < _steps.length - 1) {
      setState(() {
        _step++;
        _selectedAnswer = -1;
        _answerChecked = false;
      });
    } else {
      widget.onSessionCompleted(25);

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sesión completada. Tu progreso ha sido actualizado.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.84,
      decoration: const BoxDecoration(
        color: Color(0xFF0B0F14),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Text(
                    'TECNOLOGÍA',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_step + 1} / ${_steps.length}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                _steps[_step],
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: List.generate(
                  _steps.length,
                  (index) {
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: index == _steps.length - 1 ? 0 : 5,
                        ),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= _step
                              ? const Color(0xFF64D8FF)
                              : Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  child: _buildStepContent(),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canContinue() ? _next : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.white.withValues(
                      alpha: 0.08,
                    ),
                    foregroundColor: Colors.black,
                    disabledForegroundColor: Colors.white.withValues(
                      alpha: 0.2,
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: Text(
                    _step == _steps.length - 1
                        ? 'FINALIZAR SESIÓN'
                        : 'CONTINUAR',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canContinue() {
    if (_step == 1) {
      return _answerChecked;
    }

    return true;
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return _ExplanationStep();

      case 1:
        return _QuestionStep(
          selectedAnswer: _selectedAnswer,
          answerChecked: _answerChecked,
          onSelect: (index) {
            setState(() {
              _selectedAnswer = index;
            });
          },
          onCheck: () {
            if (_selectedAnswer != -1) {
              setState(() {
                _answerChecked = true;
              });
            }
          },
        );

      case 2:
        return _ExerciseStep();

      case 3:
        return _EvaluationStep();

      default:
        return const SizedBox();
    }
  }
}

// ============================================================================
// EXPLANATION
// ============================================================================

class _ExplanationStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContentTag(
          icon: Icons.lightbulb_outline_rounded,
          text: 'CONCEPTO PRINCIPAL',
        ),

        const SizedBox(height: 18),

        const Text(
          '¿Qué es la arquitectura de software?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'La arquitectura de software define cómo se organizan '
          'los componentes de un sistema, cómo se comunican y '
          'qué responsabilidades tiene cada parte.',
          style: TextStyle(
            fontSize: 15,
            height: 1.65,
            color: Colors.white.withValues(alpha: 0.58),
          ),
        ),

        const SizedBox(height: 18),

        _DefinitionCard(
          title: 'EN POCAS PALABRAS',
          text:
              'La arquitectura es la estructura que permite que '
              'un sistema crezca sin convertirse en un conjunto '
              'difícil de mantener.',
        ),

        const SizedBox(height: 18),

        _BulletPoint(
          title: 'Separación',
          text: 'Cada componente tiene una responsabilidad clara.',
        ),

        _BulletPoint(
          title: 'Comunicación',
          text: 'Los componentes intercambian información de forma definida.',
        ),

        _BulletPoint(
          title: 'Escalabilidad',
          text: 'El sistema puede crecer sin romper toda su estructura.',
        ),
      ],
    );
  }
}

// ============================================================================
// QUESTION
// ============================================================================

class _QuestionStep extends StatelessWidget {
  final int selectedAnswer;
  final bool answerChecked;
  final ValueChanged<int> onSelect;
  final VoidCallback onCheck;

  const _QuestionStep({
    required this.selectedAnswer,
    required this.answerChecked,
    required this.onSelect,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    const answers = [
      'El diseño visual de una aplicación.',
      'La estructura y organización de un sistema.',
      'El lenguaje de programación utilizado.',
      'La velocidad de ejecución del sistema.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContentTag(
          icon: Icons.help_outline_rounded,
          text: 'COMPRUEBA LO QUE APRENDISTE',
        ),

        const SizedBox(height: 20),

        const Text(
          '¿Cuál describe mejor la arquitectura de software?',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),

        const SizedBox(height: 24),

        ...List.generate(
          answers.length,
          (index) {
            final selected = selectedAnswer == index;
            final correct = index == 1;

            Color borderColor =
                Colors.white.withValues(alpha: 0.07);

            if (answerChecked && selected && correct) {
              borderColor = Colors.greenAccent.withValues(alpha: 0.6);
            } else if (answerChecked && selected && !correct) {
              borderColor = Colors.redAccent.withValues(alpha: 0.6);
            } else if (selected) {
              borderColor = const Color(0xFF64D8FF);
            }

            return GestureDetector(
              onTap: answerChecked
                  ? null
                  : () {
                      onSelect(index);
                    },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.white.withValues(alpha: 0.06)
                      : const Color(0xFF10141A),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: borderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + index),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        answers[index],
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.35,
                          color: Colors.white.withValues(alpha: 0.62),
                        ),
                      ),
                    ),

                    if (answerChecked && selected)
                      Icon(
                        correct
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        size: 18,
                        color: correct
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        if (!answerChecked)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: selectedAnswer == -1 ? null : onCheck,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(
                  color: selectedAnswer == -1
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.white.withValues(alpha: 0.15),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'COMPROBAR RESPUESTA',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        else
          _FeedbackCard(
            correct: selectedAnswer == 1,
          ),
      ],
    );
  }
}

// ============================================================================
// EXERCISE
// ============================================================================

class _ExerciseStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContentTag(
          icon: Icons.edit_note_rounded,
          text: 'APLICA EL CONCEPTO',
        ),

        const SizedBox(height: 20),

        const Text(
          'Piensa en una aplicación de música.',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 14),

        Text(
          'Si tuvieras que dividirla en componentes, '
          '¿qué responsabilidades separarías?',
          style: TextStyle(
            fontSize: 15,
            height: 1.55,
            color: Colors.white.withValues(alpha: 0.55),
          ),
        ),

        const SizedBox(height: 22),

        _ExerciseOption(
          icon: Icons.library_music_rounded,
          title: 'Biblioteca',
          subtitle: 'Gestiona canciones y álbumes.',
        ),

        const SizedBox(height: 10),

        _ExerciseOption(
          icon: Icons.play_circle_outline_rounded,
          title: 'Reproductor',
          subtitle: 'Controla la reproducción.',
        ),

        const SizedBox(height: 10),

        _ExerciseOption(
          icon: Icons.download_rounded,
          title: 'Descargas',
          subtitle: 'Gestiona archivos descargados.',
        ),

        const SizedBox(height: 20),

        _DefinitionCard(
          title: 'PISTA',
          text:
              'Busca separar responsabilidades. Si una parte '
              'cambia, no debería obligarte a modificar todo el sistema.',
        ),
      ],
    );
  }
}

// ============================================================================
// EVALUATION
// ============================================================================

class _EvaluationStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContentTag(
          icon: Icons.fact_check_outlined,
          text: 'EVALUACIÓN',
        ),

        const SizedBox(height: 20),

        const Text(
          'Sesión casi completada.',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Has recorrido los cuatro pasos de la sesión. '
          'Este resultado se utilizará para determinar '
          'qué deberías repasar posteriormente.',
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),

        const SizedBox(height: 25),

        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFF10161D),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              const Text(
                'PROGRESO DE LA SESIÓN',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                '100%',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Sesión completada',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        _FeedbackCard(
          correct: true,
          text:
              'Buen trabajo. El siguiente paso será reforzar '
              'este concepto mediante repaso espaciado.',
        ),
      ],
    );
  }
}

// ============================================================================
// TOPIC SHEET
// ============================================================================

class _TopicSheet extends StatelessWidget {
  final _LearningTopic topic;

  const _TopicSheet({
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 25),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0F14),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Icon(
                    topic.icon,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        topic.level,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            Text(
              'PROGRESO',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.3,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),

            const SizedBox(height: 10),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: topic.progress,
                minHeight: 7,
                backgroundColor: Colors.white.withValues(alpha: 0.07),
                valueColor: const AlwaysStoppedAnimation(
                  Color(0xFF64D8FF),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '${(topic.progress * 100).round()}% completado',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: const Text(
                  'VER RUTA DE APRENDIZAJE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// REVIEW SHEET
// ============================================================================

class _ReviewSheet extends StatelessWidget {
  const _ReviewSheet();

  @override
  Widget build(BuildContext context) {
    final concepts = [
      'Arquitectura de software',
      'Separación de responsabilidades',
      'Abstracción',
      'Encapsulamiento',
      'Modularidad',
      'APIs',
      'Estado de una aplicación',
      'Persistencia',
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 25),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0F14),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Repaso',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              '8 conceptos esperando ser reforzados.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),

            const SizedBox(height: 22),

            Expanded(
              child: ListView.separated(
                itemCount: concepts.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10141A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withValues(alpha: 0.4),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            concepts[index],
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SMALL COMPONENTS
// ============================================================================

class _ContentTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContentTag({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: const Color(0xFF64D8FF).withValues(alpha: 0.8),
        ),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: Color(0xFF64D8FF),
          ),
        ),
      ],
    );
  }
}

class _DefinitionCard extends StatelessWidget {
  final String title;
  final String text;

  const _DefinitionCard({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF151B22),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String title;
  final String text;

  const _BulletPoint({
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF64D8FF),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: Colors.white.withValues(alpha: 0.42),
                ),
                children: [
                  TextSpan(
                    text: '$title. ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(text: text),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final bool correct;
  final String? text;

  const _FeedbackCard({
    required this.correct,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final message = text ??
        (correct
            ? 'Correcto. La arquitectura define la estructura y organización del sistema.'
            : 'La respuesta no es correcta. Revisa nuevamente el concepto.');

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: correct
            ? Colors.greenAccent.withValues(alpha: 0.05)
            : Colors.redAccent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: correct
              ? Colors.greenAccent.withValues(alpha: 0.12)
              : Colors.redAccent.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            correct
                ? Icons.check_circle_outline_rounded
                : Icons.info_outline_rounded,
            size: 18,
            color: correct ? Colors.greenAccent : Colors.redAccent,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 12,
                height: 1.45,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ExerciseOption({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF10141A),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: Colors.white.withValues(alpha: 0.55),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.3),
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

// ============================================================================
// DATA
// ============================================================================

class _LearningTopic {
  final IconData icon;
  final String title;
  final String subtitle;
  final double progress;
  final String level;

  const _LearningTopic({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.level,
  });
}