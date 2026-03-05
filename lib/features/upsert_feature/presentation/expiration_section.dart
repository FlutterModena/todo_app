import 'package:flutter/material.dart';
import 'package:todo_app/common/models/todo_model.dart';
import 'package:todo_app/extensions.dart';

/// A widget that represents the expiration section of the upsert todo page.
class ExpirationSection extends StatelessWidget {
  /// Creates an [ExpirationSection] widget.
  const ExpirationSection({
    required this.todo,
    required this.onChange,
    super.key,
  });

  /// The todo model to display and edit.
  final TodoModel todo;

  /// The callback to call when the user changes the expiration date.
  final void Function(TodoModel todo) onChange;

  /// Returns a human-readable string representing
  /// the expiration date of the todo.
  String get todoExpireAt {
    if (todo.expireAt.isToday) {
      return "Oggi, ${todo.expireAt.format('HH:mm')}";
    }

    if (todo.expireAt.isTomorrow) {
      return "Domani, ${todo.expireAt.format('HH:mm')}";
    }

    return todo.expireAt.format('EEEE, HH:mm');
  }

  Future<void> _changeExpireAt(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: todo.expireAt,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (selectedDate == null || !context.mounted) {
      return;
    }

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        todo.expireAt,
      ),
    );

    if (selectedTime == null) {
      return;
    }

    final newExpireAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    onChange(
      todo.copyWith(
        expireAt: newExpireAt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        Text(
          'Scadenza',
          style: context.textTheme.labelLarge,
        ),
        Container(
          padding: const .only(
            left: 12,
            top: 4,
            bottom: 4,
            right: 4,
          ),
          decoration: BoxDecoration(
            border: .all(color: Colors.grey),
            borderRadius: const .all(.circular(8)),
          ),
          child: Row(
            children: [
              Row(
                mainAxisSize: .min,
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 8),
                  Text(todoExpireAt),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => _changeExpireAt(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
