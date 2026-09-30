import 'package:flutter/material.dart';

class BodyView extends StatefulWidget {
  const BodyView({super.key});

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {
  bool _trainingStarted = false;
  int _completedSets = 0;

  final int _totalSets = 18;

  final List<_ExerciseData> _todayExercises = [
    _ExerciseData(
      name: 'Dominadas',
      sets: 4,
      reps: '6–10',
      rest: '120 s',
      completed: 0,
    ),
    _ExerciseData(
      name: 'Fondos',
      sets: 4,
      reps: '8–12',
      rest: '90 s',
      completed: 0,
    ),
    _ExerciseData(
      name: 'Remo invertido',
      sets: 3,
      reps: '10–12',
      rest: '90 s',
      completed: 0,
    ),
    _ExerciseData(
      name: 'Flexiones',
      sets: 4,
      reps: '12–15',
      rest: '60 s',
      completed: 0,
    ),
    _ExerciseData(
      name: 'Plancha',
      sets: 3,
      reps: '40 s',
      rest: '60 s',
      completed: 0,
    ),
  ];

  void _startTraining() {
    setState(() {
      _trainingStarted = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TrainingSheet(
        exercises: _todayExercises,
        onSetCompleted: () {
          if (_completedSets < _totalSets) {
            setState(() {
              _completedSets++;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = _completedSets / _totalSets;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 30, 22, 140),
        children: [
          const Text(
            'Cuerpo',
            style: TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'Entrena. Registra. Progresa.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 28),

          // ------------------------------------------------------------
          // ESTADO FÍSICO
          // ------------------------------------------------------------
          const _SectionTitle(
            title: 'TU ESTADO',
            subtitle: 'Información utilizada para adaptar tu entrenamiento',
          ),

          const SizedBox(height: 12),

          _PhysicalStateCard(),

          const SizedBox(height: 30),

          // ------------------------------------------------------------
          // ENTRENAMIENTO DE HOY
          // ------------------------------------------------------------
          const _SectionTitle(
            title: 'HOY',
            subtitle: 'Tu siguiente compromiso físico',
          ),

          const SizedBox(height: 12),

          _TodayWorkoutCard(
            started: _trainingStarted,
            progress: progress,
            completedSets: _completedSets,
            totalSets: _totalSets,
            onStart: _startTraining,
          ),

          const SizedBox(height: 30),

          // ------------------------------------------------------------
          // PROGRESO
          // ------------------------------------------------------------
          const _SectionTitle(
            title: 'TU PROGRESO',
            subtitle: 'Lo que has construido hasta ahora',
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  value: '18',
                  label: 'ENTRENAMIENTOS',
                  icon: Icons.fitness_center_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  value: '4',
                  label: 'ESTA SEMANA',
                  icon: Icons.calendar_today_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  value: '6',
                  label: 'DÍAS SEGUIDOS',
                  icon: Icons.local_fire_department_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  value: '+12%',
                  label: 'VOLUMEN',
                  icon: Icons.trending_up_rounded,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ------------------------------------------------------------
          // PRÓXIMO OBJETIVO
          // ------------------------------------------------------------
          const _SectionTitle(
            title: 'PRÓXIMO OBJETIVO',
            subtitle: 'Una progresión concreta',
          ),

          const SizedBox(height: 12),

          _GoalCard(),

          const SizedBox(height: 30),

          // ------------------------------------------------------------
          // RUTINAS
          // ------------------------------------------------------------
          const _SectionTitle(
            title: 'MIS RUTINAS',
            subtitle: 'Entrenamientos que tienes configurados',
          ),

          const SizedBox(height: 12),

          _RoutineCard(
            title: 'PULL',
            subtitle: 'Espalda · Bíceps · Agarre',
            duration: '45 min',
            exercises: '5 ejercicios',
          ),

          const SizedBox(height: 10),

          _RoutineCard(
            title: 'PUSH',
            subtitle: 'Pecho · Hombros · Tríceps',
            duration: '45 min',
            exercises: '6 ejercicios',
          ),

          const SizedBox(height: 10),

          _RoutineCard(
            title: 'LEGS',
            subtitle: 'Piernas · Glúteos · Core',
            duration: '50 min',
            exercises: '6 ejercicios',
          ),

          const SizedBox(height: 10),

          _RoutineCard(
            title: 'FULL BODY',
            subtitle: 'Cuerpo completo',
            duration: '60 min',
            exercises: '7 ejercicios',
          ),

          const SizedBox(height: 30),

          // ------------------------------------------------------------
          // RECUPERACIÓN
          // ------------------------------------------------------------
          const _SectionTitle(
            title: 'RECUPERACIÓN',
            subtitle: 'Antes de aumentar la carga',
          ),

          const SizedBox(height: 12),

          _RecoveryCard(),

          const SizedBox(height: 30),

          // ------------------------------------------------------------
          // RECOMENDACIÓN IA
          // ------------------------------------------------------------
          const _SectionTitle(
            title: 'ASISTENTE',
            subtitle: 'Análisis de tu entrenamiento',
          ),

          const SizedBox(height: 12),

          _AssistantCard(),
        ],
      ),
    );
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
// PHYSICAL STATE
// ============================================================================

class _PhysicalStateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF11161D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _StateItem(
                label: 'OBJETIVO',
                value: 'Fuerza',
              ),
              _VerticalDivider(),
              _StateItem(
                label: 'NIVEL',
                value: 'Intermedio',
              ),
              _VerticalDivider(),
              _StateItem(
                label: 'EQUIPO',
                value: 'Casa',
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: Colors.white.withValues(alpha: 0.35),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tu entrenamiento se adapta a tu objetivo y al equipo disponible.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.white.withValues(alpha: 0.38),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StateItem extends StatelessWidget {
  final String label;
  final String value;

  const _StateItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 35,
      color: Colors.white.withValues(alpha: 0.07),
    );
  }
}

// ============================================================================
// TODAY WORKOUT
// ============================================================================

class _TodayWorkoutCard extends StatelessWidget {
  final bool started;
  final double progress;
  final int completedSets;
  final int totalSets;
  final VoidCallback onStart;

  const _TodayWorkoutCard({
    required this.started,
    required this.progress,
    required this.completedSets,
    required this.totalSets,
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
                  color: Colors.white.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.fitness_center_rounded,
                  color: Colors.white.withValues(alpha: 0.75),
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
                  'HOY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            'Tren superior · Fuerza',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            '45 minutos · 5 ejercicios · 18 series',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.42),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 22),

          if (started) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SESIÓN EN PROGRESO',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                Text(
                  '$completedSets / $totalSets series',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 9),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                backgroundColor: Colors.white.withValues(alpha: 0.07),
              ),
            ),

            const SizedBox(height: 18),
          ],

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
                started ? 'CONTINUAR ENTRENAMIENTO' : 'EMPEZAR ENTRENAMIENTO',
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
// GOAL
// ============================================================================

class _GoalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF11161D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.arrow_upward_rounded,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'DOMINADAS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Text(
                '10 / 12',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 10 / 12,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.07),
            ),
          ),

          const SizedBox(height: 13),

          Text(
            'Tu objetivo es alcanzar 12 repeticiones limpias.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ROUTINES
// ============================================================================

class _RoutineCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String duration;
  final String exercises;

  const _RoutineCard({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 17,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF11161D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                title[0],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                duration,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                exercises,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withValues(alpha: 0.28),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// RECOVERY
// ============================================================================

class _RecoveryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF11161D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _RecoveryItem(
                value: '7h 40m',
                label: 'SUEÑO',
              ),
              _VerticalDivider(),
              _RecoveryItem(
                value: '6h',
                label: 'DESDE SESIÓN',
              ),
              _VerticalDivider(),
              _RecoveryItem(
                value: 'BAJA',
                label: 'FATIGA',
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 17,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Las condiciones registradas permiten mantener la sesión planificada.',
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: Colors.white.withValues(alpha: 0.42),
                    ),
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

class _RecoveryItem extends StatelessWidget {
  final String value;
  final String label;

  const _RecoveryItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              letterSpacing: 0.8,
              color: Colors.white.withValues(alpha: 0.28),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// AI ASSISTANT
// ============================================================================

class _AssistantCard extends StatelessWidget {
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
              color: Colors.white.withValues(alpha: 0.07),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 18,
              color: Colors.white.withValues(alpha: 0.65),
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
                  'Hoy puedes mantener la carga planificada. '
                  'Prioriza una ejecución limpia y registra las repeticiones reales.',
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
// TRAINING SHEET
// ============================================================================

class _TrainingSheet extends StatefulWidget {
  final List<_ExerciseData> exercises;
  final VoidCallback onSetCompleted;

  const _TrainingSheet({
    required this.exercises,
    required this.onSetCompleted,
  });

  @override
  State<_TrainingSheet> createState() => _TrainingSheetState();
}

class _TrainingSheetState extends State<_TrainingSheet> {
  int _currentExercise = 0;
  int _currentSet = 0;

  void _completeSet() {
    final exercise = widget.exercises[_currentExercise];

    if (_currentSet < exercise.sets) {
      setState(() {
        _currentSet++;
      });

      widget.onSetCompleted();
    }

    if (_currentSet >= exercise.sets) {
      if (_currentExercise < widget.exercises.length - 1) {
        setState(() {
          _currentExercise++;
          _currentSet = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercises[_currentExercise];

    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
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

              const SizedBox(height: 25),

              Text(
                'EJERCICIO ${_currentExercise + 1} / ${widget.exercises.length}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),

              const SizedBox(height: 9),

              Text(
                exercise.name,
                style: const TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                '${exercise.sets} series · ${exercise.reps} reps · descanso ${exercise.rest}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF11161D),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  children: [
                    Text(
                      'SERIE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '${_currentSet + 1}',
                      style: const TextStyle(
                        fontSize: 58,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'de ${exercise.sets}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _TrainingInfo(
                      title: 'OBJETIVO',
                      value: exercise.reps,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _TrainingInfo(
                      title: 'DESCANSO',
                      value: exercise.rest,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _completeSet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: Text(
                    _currentSet + 1 >= exercise.sets &&
                            _currentExercise + 1 >= widget.exercises.length
                        ? 'FINALIZAR ENTRENAMIENTO'
                        : 'COMPLETAR SERIE',
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
}

class _TrainingInfo extends StatelessWidget {
  final String title;
  final String value;

  const _TrainingInfo({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 8,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.27),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
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

class _ExerciseData {
  final String name;
  final int sets;
  final String reps;
  final String rest;
  final int completed;

  const _ExerciseData({
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.completed,
  });
}