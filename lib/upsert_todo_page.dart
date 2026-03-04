import 'package:flutter/material.dart';
import 'package:test/extensions.dart';
import 'package:test/todo_model.dart';

/// A page that allows the user to create a new todo or edit an existing one.
class UpsertTodoPage extends StatefulWidget {
  /// Creates an [UpsertTodoPage] widget.
  const UpsertTodoPage({
    super.key,
    this.todo,
  });

  /// The todo to edit, or null if creating a new one.
  final TodoModel? todo;

  @override
  State<UpsertTodoPage> createState() => _UpsertTodoPageState();
}

class _UpsertTodoPageState extends State<UpsertTodoPage> {
  late final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(
    text: widget.todo?.title,
  );
  late final _descriptionController = TextEditingController(
    text: widget.todo?.description,
  );
  late TodoCategory _category = widget.todo?.category ?? TodoCategory.personal;

  late TodoModel _todo =
      widget.todo ??
      TodoModel(
        id: 0,
        title: _titleController.text,
        description: _descriptionController.text,
        isCompleted: false,
        createdAt: .now(),
        expireAt: .now().add(const Duration(days: 1)),
      );

  bool get isEdit => widget.todo != null;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTodo() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO(dariowskii): save the new todo in the list
      Navigator.of(context).pop();
    }
  }

  void _deleteTodo() {
    // TODO(dariowskii): delete the todo from the list
    Navigator.of(context).pop();
  }

  Future<void> _changeExpireAt() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _todo.expireAt,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (selectedDate == null || !mounted) {
      return;
    }

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        _todo.expireAt,
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

    setState(() {
      _todo = _todo.copyWith(expireAt: newExpireAt);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle = isEdit ? 'Modifica Todo' : 'Aggiungi Todo';
    final todoExpireAt = _todo.expireAt.isToday
        ? "Oggi, ${_todo.expireAt.format('HH:mm')}"
        : _todo.expireAt.isTomorrow
        ? "Domani, ${_todo.expireAt.format('HH:mm')}"
        : _todo.expireAt.format('EEEE, HH:mm');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          pageTitle,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: .bold,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const .all(16),
              sliver: SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        'Titolo',
                        style: context.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: .all(.circular(8)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Il titolo è obbligatorio';
                          }
                          return null;
                        },
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Descrizione',
                        style: context.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: .all(.circular(8)),
                          ),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La descrizione è obbligatoria';
                          }
                          return null;
                        },
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Categoria',
                        style: context.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 48,
                        child: ListView.separated(
                          scrollDirection: .horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemCount: TodoCategory.values.length,
                          itemBuilder: (context, index) {
                            final category = TodoCategory.values[index];
                            return ChoiceChip(
                              label: Text(category.label),
                              avatar: Icon(category.icon, size: 16),
                              selected: _category == category,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _category = category;
                                  });
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Scadenza',
                        style: context.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
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
                              onPressed: _changeExpireAt,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: .end,
                children: [
                  SizedBox(
                    width: .infinity,
                    child: Padding(
                      padding: const .only(
                        top: 8,
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      child: FilledButton(
                        onPressed: _saveTodo,
                        child: Text(isEdit ? 'Modifica' : 'Aggiungi'),
                      ),
                    ),
                  ),
                  if (isEdit) ...[
                    TextButton(
                      onPressed: _deleteTodo,
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Icon(Icons.delete, color: context.colorScheme.error),
                          const SizedBox(width: 8),
                          Text(
                            'Elimina',
                            style: TextStyle(color: context.colorScheme.error),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
