import 'package:flutter/material.dart';
import 'package:test/extensions.dart';
import 'package:test/todo_model.dart';

class UpsertTodoPage extends StatefulWidget {
  const UpsertTodoPage({
    super.key,
    this.todo,
  });

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
  late var _category = widget.todo?.category ?? TodoCategory.personal;

  late var _todo =
      widget.todo ??
      TodoModel(
        id: 0,
        title: _titleController.text,
        description: _descriptionController.text,
        isCompleted: false,
        createdAt: .now(),
        expireAt: .now().add(Duration(days: 1)),
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

  @override
  Widget build(BuildContext context) {
    final pageTitle = isEdit ? "Modifica Todo" : "Aggiungi Todo";
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
              padding: .all(16),
              sliver: SliverToBoxAdapter(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "Titolo",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: .all(.circular(8)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Il titolo è obbligatorio";
                          }
                          return null;
                        },
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Descrizione",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: .all(.circular(8)),
                          ),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "La descrizione è obbligatoria";
                          }
                          return null;
                        },
                        onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Categoria",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 4),
                      SizedBox(
                        height: 48,
                        child: ListView.separated(
                          scrollDirection: .horizontal,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16),
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
                      SizedBox(height: 16),
                      Text(
                        'Scadenza',
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: .only(left: 12, top: 4, bottom: 4, right: 4),
                        decoration: BoxDecoration(
                          border: .all(color: Colors.grey),
                          borderRadius: .all(.circular(8)),
                        ),
                        child: Row(
                          children: [
                            Row(
                              mainAxisSize: .min,
                              children: [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 8),
                                Text(todoExpireAt),
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: _todo.expireAt,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    Duration(days: 365),
                                  ),
                                ).then((selectedDate) {
                                  if (selectedDate != null && context.mounted) {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                        _todo.expireAt,
                                      ),
                                    ).then((selectedTime) {
                                      if (selectedTime != null) {
                                        final newExpireAt = DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime.hour,
                                          selectedTime.minute,
                                        );
                                        setState(() {
                                          _todo = _todo.copyWith(
                                            expireAt: newExpireAt,
                                          );
                                        });
                                      }
                                    });
                                  }
                                });
                              },
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
                      padding: .only(
                        top: 8,
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      child: FilledButton(
                        onPressed: _saveTodo,
                        child: Text(isEdit ? "Modifica" : "Aggiungi"),
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
                          SizedBox(width: 8),
                          Text("Elimina", style: TextStyle(color: context.colorScheme.error)),
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
