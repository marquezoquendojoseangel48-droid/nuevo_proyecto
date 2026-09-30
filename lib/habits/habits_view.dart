import 'dart:math';

import 'package:flutter/material.dart';

class HabitsView extends StatefulWidget {
  const HabitsView({super.key});

  @override
  State<HabitsView> createState() => _HabitsViewState();
}

class _HabitsViewState extends State<HabitsView> {
  final List<_HabitData> _habits = [
    _HabitData(
      icon: Icons.wb_sunny_outlined,
      title: 'Despertar temprano',
      frequency: '5 días / semana',
      start: const TimeOfDay(hour: 6, minute: 0),
      end: const TimeOfDay(hour: 6, minute: 30),
      completed: true,
    ),
    _HabitData(
      icon: Icons.menu_book_rounded,
      title: 'Leer',
      frequency: '20 min / día',
      start: const TimeOfDay(hour: 20, minute: 0),
      end: const TimeOfDay(hour: 20, minute: 20),
      completed: true,
    ),
    _HabitData(
      icon: Icons.fitness_center_rounded,
      title: 'Entrenar',
      frequency: '4 días / semana',
      start: const TimeOfDay(hour: 17, minute: 0),
      end: const TimeOfDay(hour: 17, minute: 45),
      completed: false,
    ),
  ];

  Future<void> _createHabit() async {
    final habit = await showModalBottomSheet<_HabitData>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _CreateHabitSheet(),
    );

    if (habit == null) return;

    setState(() {
      _habits.add(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(22, 30, 22, 140),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hábitos',
                      style: TextStyle(
                        fontSize: 31,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Los compromisos que elegiste mantener.',
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              GestureDetector(
                onTap: _createHabit,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF64D8FF),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF64D8FF)
                            .withValues(alpha: 0.18),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Color(0xFF071016),
                    size: 25,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          ...List.generate(
            _habits.length,
            (index) {
              final habit = _habits[index];

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == _habits.length - 1 ? 0 : 10,
                ),
                child: _HabitCard(
                  habit: habit,
                  onTap: () {
                    setState(() {
                      habit.completed = !habit.completed;
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MODELO
// ============================================================

class _HabitData {
  final IconData icon;
  final String title;
  final String? description;
  final String frequency;
  final TimeOfDay start;
  final TimeOfDay end;
  bool completed;

  _HabitData({
    required this.icon,
    required this.title,
    required this.frequency,
    required this.start,
    required this.end,
    this.description,
    this.completed = false,
  });
}

// ============================================================
// HABIT CARD
// ============================================================

class _HabitCard extends StatelessWidget {
  final _HabitData habit;
  final VoidCallback onTap;

  const _HabitCard({
    required this.habit,
    required this.onTap,
  });

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod;

    final minute = time.minute
        .toString()
        .padLeft(2, '0');

    final period =
        time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF10141A),
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.055),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: habit.completed
                    ? const Color(0xFF7DFFB2)
                        .withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.05),
              ),
              child: Icon(
                habit.completed
                    ? Icons.check_rounded
                    : habit.icon,
                color: habit.completed
                    ? const Color(0xFF7DFFB2)
                    : Colors.white.withValues(alpha: 0.72),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    habit.frequency,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(
                        alpha: 0.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '${_formatTime(habit.start)} → '
                    '${_formatTime(habit.end)}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withValues(
                        alpha: 0.28,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              habit.completed
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: habit.completed
                  ? const Color(0xFF7DFFB2)
                  : Colors.white.withValues(alpha: 0.25),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CREAR HÁBITO
// ============================================================

class _CreateHabitSheet extends StatefulWidget {
  const _CreateHabitSheet();

  @override
  State<_CreateHabitSheet> createState() =>
      _CreateHabitSheetState();
}

class _CreateHabitSheetState
    extends State<_CreateHabitSheet> {
  final _nameController = TextEditingController();
  final _descriptionController =
      TextEditingController();

  TimeOfDay _start =
      const TimeOfDay(hour: 7, minute: 0);

  TimeOfDay _end =
      const TimeOfDay(hour: 7, minute: 30);

  final Set<int> _days = {
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
  };

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod;

    final minute = time.minute
        .toString()
        .padLeft(2, '0');

    final period =
        time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  int _minutesOfDay(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  int _durationMinutes() {
    final start = _minutesOfDay(_start);
    final end = _minutesOfDay(_end);

    if (end >= start) {
      return end - start;
    }

    return (24 * 60 - start) + end;
  }

  String _frequencyText() {
    if (_days.isEmpty) {
      return 'Sin días seleccionados';
    }

    if (_days.length == 7) {
      return 'Todos los días';
    }

    if (_days.length == 5 &&
        _days.contains(DateTime.monday) &&
        _days.contains(DateTime.tuesday) &&
        _days.contains(DateTime.wednesday) &&
        _days.contains(DateTime.thursday) &&
        _days.contains(DateTime.friday)) {
      return 'Lunes a viernes';
    }

    return '${_days.length} días / semana';
  }

  Future<void> _pickStart() async {
    final result = await showDialog<TimeOfDay>(
      context: context,
      builder: (_) {
        return _AnalogTimePicker(
          initialTime: _start,
          title: 'Hora de inicio',
        );
      },
    );

    if (result == null) return;

    setState(() {
      _start = result;

      final newEndMinutes =
          result.hour * 60 +
          result.minute +
          30;

      _end = TimeOfDay(
        hour: (newEndMinutes ~/ 60) % 24,
        minute: newEndMinutes % 60,
      );
    });
  }

  Future<void> _pickEnd() async {
    final result = await showDialog<TimeOfDay>(
      context: context,
      builder: (_) {
        return _AnalogTimePicker(
          initialTime: _end,
          title: 'Hora de finalización',
        );
      },
    );

    if (result == null) return;

    setState(() {
      _end = result;
    });
  }

  void _create() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      return;
    }

    if (_days.isEmpty) {
      return;
    }

    Navigator.pop(
      context,
      _HabitData(
        icon: Icons.track_changes_rounded,
        title: name,
        description:
            _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
        frequency: _frequencyText(),
        start: _start,
        end: _end,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.sizeOf(context).height * 0.92,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0F14),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            22,
            12,
            22,
            25,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.16,
                    ),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Nuevo hábito',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Define algo que quieras convertir '
                'en parte de tu vida.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(
                    alpha: 0.4,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const _InputLabel(
                label: 'NOMBRE',
              ),

              const SizedBox(height: 8),

              _DarkTextField(
                controller: _nameController,
                hintText:
                    'Ej. Leer, meditar, entrenar...',
              ),

              const SizedBox(height: 18),

              const _InputLabel(
                label: 'DESCRIPCIÓN',
              ),

              const SizedBox(height: 8),

              _DarkTextField(
                controller:
                    _descriptionController,
                hintText: 'Opcional',
                maxLines: 3,
              ),

              const SizedBox(height: 24),

              const _InputLabel(
                label: 'HORARIO',
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _TimeSelector(
                      label: 'INICIO',
                      time: _formatTime(_start),
                      icon: Icons.play_arrow_rounded,
                      onTap: _pickStart,
                    ),
                  ),

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(
                      horizontal: 9,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 17,
                      color: Colors.white24,
                    ),
                  ),

                  Expanded(
                    child: _TimeSelector(
                      label: 'FINALIZA',
                      time: _formatTime(_end),
                      icon: Icons.stop_rounded,
                      onTap: _pickEnd,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.025,
                  ),
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 17,
                      color: Color(0xFF64D8FF),
                    ),
                    const SizedBox(width: 9),
                    Text(
                      'Duración: '
                      '${_durationMinutes()} minutos',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                            .withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const _InputLabel(
                label: 'DÍAS',
              ),

              const SizedBox(height: 11),

              _DaysSelector(
                selectedDays: _days,
                onChanged: (day) {
                  setState(() {
                    if (_days.contains(day)) {
                      _days.remove(day);
                    } else {
                      _days.add(day);
                    }
                  });
                },
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _create,
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF64D8FF),
                    foregroundColor:
                        const Color(0xFF071016),
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(17),
                    ),
                  ),
                  child: const Text(
                    'CREAR HÁBITO',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
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

// ============================================================
// TIME SELECTOR
// ============================================================

class _TimeSelector extends StatelessWidget {
  final String label;
  final String time;
  final IconData icon;
  final VoidCallback onTap;

  const _TimeSelector({
    required this.label,
    required this.time,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF11161D),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.06,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: const Color(0xFF64D8FF),
                ),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 1.3,
                    color: Colors.white.withValues(
                      alpha: 0.35,
                    ),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 9),

            Text(
              time,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Cambiar hora',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DAYS
// ============================================================

class _DaysSelector extends StatelessWidget {
  final Set<int> selectedDays;
  final ValueChanged<int> onChanged;

  const _DaysSelector({
    required this.selectedDays,
    required this.onChanged,
  });

  static const days = [
    ('L', DateTime.monday),
    ('M', DateTime.tuesday),
    ('X', DateTime.wednesday),
    ('J', DateTime.thursday),
    ('V', DateTime.friday),
    ('S', DateTime.saturday),
    ('D', DateTime.sunday),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: days.map((day) {
        final selected =
            selectedDays.contains(day.$2);

        return GestureDetector(
          onTap: () => onChanged(day.$2),
          child: AnimatedContainer(
            duration:
                const Duration(milliseconds: 180),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF64D8FF)
                  : Colors.white.withValues(
                      alpha: 0.04,
                    ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.$1,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? const Color(0xFF071016)
                      : Colors.white.withValues(
                          alpha: 0.5,
                        ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ============================================================
// INPUT LABEL
// ============================================================

class _InputLabel extends StatelessWidget {
  final String label;

  const _InputLabel({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        letterSpacing: 1.6,
        color: Colors.white.withValues(
          alpha: 0.38,
        ),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// ============================================================
// TEXT FIELD
// ============================================================

class _DarkTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const _DarkTextField({
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withValues(
            alpha: 0.2,
          ),
        ),
        filled: true,
        fillColor: const Color(0xFF11161D),
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(17),
          borderSide: BorderSide(
            color: Colors.white.withValues(
              alpha: 0.05,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(17),
          borderSide: BorderSide(
            color: Colors.white.withValues(
              alpha: 0.05,
            ),
          ),
        ),
        focusedBorder:
            const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(17),
          ),
          borderSide: BorderSide(
            color: Color(0xFF64D8FF),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// ANALOG TIME PICKER
// ============================================================

class _AnalogTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final String title;

  const _AnalogTimePicker({
    required this.initialTime,
    required this.title,
  });

  @override
  State<_AnalogTimePicker> createState() =>
      _AnalogTimePickerState();
}

class _AnalogTimePickerState
    extends State<_AnalogTimePicker> {
  late int _hour;
  late int _minute;
  late DayPeriod _period;

  @override
  void initState() {
    super.initState();

    _hour =
        widget.initialTime.hourOfPeriod == 0
            ? 12
            : widget.initialTime.hourOfPeriod;

    _minute = widget.initialTime.minute;

    _period = widget.initialTime.period;
  }

  TimeOfDay _result() {
    var hour24 = _hour % 12;

    if (_period == DayPeriod.pm) {
      hour24 += 12;
    }

    return TimeOfDay(
      hour: hour24,
      minute: _minute,
    );
  }

  void _setHour(int hour) {
    setState(() {
      _hour = hour;
    });
  }

  void _setMinute(int minute) {
    setState(() {
      _minute = minute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0D1218),
      insetPadding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 35,
      ),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(30),
      ),
      child: Padding(
        padding:
            const EdgeInsets.fromLTRB(
          20,
          20,
          20,
          18,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ------------------------------------------------
            // DISPLAY
            // ------------------------------------------------

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  _hour
                      .toString()
                      .padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const Text(
                  ':',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white38,
                  ),
                ),

                Text(
                  _minute
                      .toString()
                      .padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF64D8FF),
                  ),
                ),

                const SizedBox(width: 12),

                Container(
                  padding:
                      const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withValues(alpha: 0.04),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _PeriodButton(
                        label: 'AM',
                        selected:
                            _period ==
                                DayPeriod.am,
                        onTap: () {
                          setState(() {
                            _period =
                                DayPeriod.am;
                          });
                        },
                      ),
                      _PeriodButton(
                        label: 'PM',
                        selected:
                            _period ==
                                DayPeriod.pm,
                        onTap: () {
                          setState(() {
                            _period =
                                DayPeriod.pm;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ------------------------------------------------
            // RELOJ
            // ------------------------------------------------

            _AnalogClock(
              hour: _hour,
              minute: _minute,
              onHourChanged: _setHour,
              onMinuteChanged: _setMinute,
            ),

            const SizedBox(height: 10),

            Text(
              'Arrastra la manecilla para ajustar',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withValues(
                  alpha: 0.3,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'CANCELAR',
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      _result(),
                    );
                  },
                  child: const Text(
                    'LISTO',
                    style: TextStyle(
                      color: Color(0xFF64D8FF),
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ANALOG CLOCK
// ============================================================

class _AnalogClock extends StatefulWidget {
  final int hour;
  final int minute;

  final ValueChanged<int> onHourChanged;
  final ValueChanged<int> onMinuteChanged;

  const _AnalogClock({
    required this.hour,
    required this.minute,
    required this.onHourChanged,
    required this.onMinuteChanged,
  });

  @override
  State<_AnalogClock> createState() =>
      _AnalogClockState();
}

class _AnalogClockState
    extends State<_AnalogClock> {
  bool _minuteMode = false;

  // ----------------------------------------------------------
  // POSICIÓN DEL DEDO -> ÁNGULO
  // ----------------------------------------------------------

  void _handlePosition(
    BuildContext context,
    Offset globalPosition,
  ) {
    final renderBox =
        context.findRenderObject()
            as RenderBox;

    final local =
        renderBox.globalToLocal(
      globalPosition,
    );

    final center = Offset(
      renderBox.size.width / 2,
      renderBox.size.height / 2,
    );

    final dx = local.dx - center.dx;
    final dy = local.dy - center.dy;

    if (dx == 0 && dy == 0) {
      return;
    }

    // --------------------------------------------------------
    // ÁNGULO EXACTO
    // --------------------------------------------------------
    //
    // atan2:
    //
    // derecha = 0°
    // abajo   = 90°
    // izquierda = 180°
    // arriba = -90°
    //
    // Sumando 90°:
    //
    // arriba = 0°
    // derecha = 90°
    // abajo = 180°
    // izquierda = 270°
    //
    // EXACTAMENTE como un reloj.
    //

    var angle = atan2(dy, dx) + pi / 2;

    if (angle < 0) {
      angle += 2 * pi;
    }

    if (angle >= 2 * pi) {
      angle -= 2 * pi;
    }

    if (_minuteMode) {
      _selectMinute(angle);
    } else {
      _selectHour(angle);
    }
  }

  // ----------------------------------------------------------
  // HORA
  // ----------------------------------------------------------

  void _selectHour(double angle) {
    // 360° / 12 = 30°
    const sector = 2 * pi / 12;

    // Desplazamos medio sector.
    //
    // Esto hace que:
    //
    // 12 tenga 11:00 -> 1:00
    // 1 tenga 12:00 -> 2:00
    // ...
    // 6 tenga 5:00 -> 7:00
    //
    // Por lo tanto el 6 tiene su propio sector
    // completo y nunca se salta.
    final index =
        ((angle + sector / 2) / sector)
            .floor();

    final hour = index % 12 == 0
        ? 12
        : index % 12;

    widget.onHourChanged(hour);
  }

  // ----------------------------------------------------------
  // MINUTO
  // ----------------------------------------------------------

  void _selectMinute(double angle) {
    // 60 posiciones de minuto.
    const minuteSector = 2 * pi / 60;

    final rawMinute =
        ((angle + minuteSector / 2) /
                minuteSector)
            .floor();

    var minute = rawMinute % 60;

    // Auto-apuntado cada 5 minutos.
    minute = ((minute + 2) ~/ 5) * 5;

    if (minute >= 60) {
      minute = 0;
    }

    widget.onMinuteChanged(minute);
  }

  // ----------------------------------------------------------
  // BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          behavior:
              HitTestBehavior.opaque,

          // Tocar directamente selecciona.
          onTapDown: (details) {
            _handlePosition(
              context,
              details.globalPosition,
            );
          },

          // Empieza a seguir inmediatamente.
          onPanStart: (details) {
            _handlePosition(
              context,
              details.globalPosition,
            );
          },

          // Sigue al dedo continuamente.
          onPanUpdate: (details) {
            _handlePosition(
              context,
              details.globalPosition,
            );
          },

          child: CustomPaint(
            size:
                const Size(280, 280),
            painter: _ClockPainter(
              hour: widget.hour,
              minute: widget.minute,
              minuteMode:
                  _minuteMode,
            ),
          ),
        ),

        const SizedBox(height: 12),

        GestureDetector(
          onTap: () {
            setState(() {
              _minuteMode =
                  !_minuteMode;
            });
          },
          child: AnimatedContainer(
            duration:
                const Duration(
              milliseconds: 180,
            ),
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: const Color(
                0xFF64D8FF,
              ).withValues(
                alpha: 0.08,
              ),
              borderRadius:
                  BorderRadius.circular(
                100,
              ),
            ),
            child: Text(
              _minuteMode
                  ? 'MINUTOS · toca para volver a horas'
                  : 'HORAS · toca para ajustar minutos',
              style: const TextStyle(
                fontSize: 10,
                color:
                    Color(0xFF64D8FF),
                fontWeight:
                    FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// CLOCK PAINTER
// ============================================================

class _ClockPainter
    extends CustomPainter {
  final int hour;
  final int minute;
  final bool minuteMode;

  _ClockPainter({
    required this.hour,
    required this.minute,
    required this.minuteMode,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius =
        size.width / 2;

    // --------------------------------------------------------
    // FONDO
    // --------------------------------------------------------

    final background = Paint()
      ..color =
          const Color(0xFF151C24);

    canvas.drawCircle(
      center,
      radius,
      background,
    );

    // --------------------------------------------------------
    // BORDE
    // --------------------------------------------------------

    final ring = Paint()
      ..color = Colors.white
          .withValues(alpha: 0.06)
      ..style =
          PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(
      center,
      radius - 1,
      ring,
    );

    // --------------------------------------------------------
    // MARCAS DEL RELOJ
    // --------------------------------------------------------

    final tickPaint = Paint()
      ..color = Colors.white
          .withValues(alpha: 0.12)
      ..strokeWidth = 1.5;

    for (int i = 0; i < 60; i++) {
      final angle =
          i * 2 * pi / 60 -
              pi / 2;

      final isHour = i % 5 == 0;

      final outerRadius =
          radius - 13;

      final innerRadius =
          isHour
              ? radius - 22
              : radius - 18;

      final outer = Offset(
        center.dx +
            cos(angle) *
                outerRadius,
        center.dy +
            sin(angle) *
                outerRadius,
      );

      final inner = Offset(
        center.dx +
            cos(angle) *
                innerRadius,
        center.dy +
            sin(angle) *
                innerRadius,
      );

      canvas.drawLine(
        inner,
        outer,
        tickPaint,
      );
    }

    // --------------------------------------------------------
    // NÚMEROS 1 - 12
    // --------------------------------------------------------

    final textPainter =
        TextPainter(
      textDirection:
          TextDirection.ltr,
    );

    for (int i = 1; i <= 12; i++) {
      final angle =
          i * 2 * pi / 12 -
              pi / 2;

      final numberRadius =
          radius - 39;

      final position = Offset(
        center.dx +
            cos(angle) *
                numberRadius,
        center.dy +
            sin(angle) *
                numberRadius,
      );

      final selected =
          !minuteMode &&
          hour == i;

      textPainter.text =
          TextSpan(
        text: '$i',
        style: TextStyle(
          color: selected
              ? const Color(
                  0xFF64D8FF,
                )
              : Colors.white
                  .withValues(
                  alpha: 0.62,
                ),
          fontSize:
              selected ? 15 : 13,
          fontWeight:
              selected
                  ? FontWeight.w800
                  : FontWeight.w600,
        ),
      );

      textPainter.layout();

      textPainter.paint(
        canvas,
        position -
            Offset(
              textPainter.width / 2,
              textPainter.height / 2,
            ),
      );
    }

    // --------------------------------------------------------
    // ÁNGULO DE LA MANECILLA
    // --------------------------------------------------------

    double selectedAngle;

    if (minuteMode) {
      selectedAngle =
          minute / 60 * 2 * pi -
              pi / 2;
    } else {
      selectedAngle =
          (hour % 12) /
                  12 *
                  2 *
                  pi -
              pi / 2;
    }

    // --------------------------------------------------------
    // MANECILLA
    // --------------------------------------------------------

    final handLength =
        radius * 0.55;

    final handEnd = Offset(
      center.dx +
          cos(selectedAngle) *
              handLength,
      center.dy +
          sin(selectedAngle) *
              handLength,
    );

    final handPaint = Paint()
      ..color =
          const Color(0xFF64D8FF)
      ..strokeWidth = 4
      ..strokeCap =
          StrokeCap.round;

    canvas.drawLine(
      center,
      handEnd,
      handPaint,
    );

    // --------------------------------------------------------
    // PUNTO CENTRAL
    // --------------------------------------------------------

    final centerPaint = Paint()
      ..color =
          const Color(0xFF64D8FF);

    canvas.drawCircle(
      center,
      7,
      centerPaint,
    );

    // --------------------------------------------------------
    // PUNTA DE LA MANECILLA
    // --------------------------------------------------------

    canvas.drawCircle(
      handEnd,
      7,
      centerPaint,
    );

    // --------------------------------------------------------
    // PEQUEÑO HALO
    // --------------------------------------------------------

    final halo = Paint()
      ..color =
          const Color(0xFF64D8FF)
              .withValues(
            alpha: 0.12,
          );

    canvas.drawCircle(
      handEnd,
      13,
      halo,
    );
  }

  @override
  bool shouldRepaint(
    covariant _ClockPainter oldDelegate,
  ) {
    return oldDelegate.hour != hour ||
        oldDelegate.minute != minute ||
        oldDelegate.minuteMode !=
            minuteMode;
  }
}

// ============================================================
// PERIOD BUTTON
// ============================================================

class _PeriodButton
    extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PeriodButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 150,
        ),
        padding:
            const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(
                  0xFF64D8FF,
                )
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(
            8,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight:
                FontWeight.w800,
            color: selected
                ? const Color(
                    0xFF071016,
                  )
                : Colors.white38,
          ),
        ),
      ),
    );
  }
}
