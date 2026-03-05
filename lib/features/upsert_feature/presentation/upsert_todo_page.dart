import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/common/models/todo_model.dart';
import 'package:todo_app/extensions.dart';
import 'package:todo_app/features/home_feature/data/todo_provider.dart';
import 'package:todo_app/features/upsert_feature/presentation/category_section.dart';
import 'package:todo_app/features/upsert_feature/presentation/description_section.dart';
import 'package:todo_app/features/upsert_feature/presentation/expiration_section.dart';
import 'package:todo_app/features/upsert_feature/presentation/title_section.dart';

/// A page that allows the user to create a new todo or edit an existing one.
class UpsertTodoPage extends ConsumerStatefulWidget {
  /// Creates an [UpsertTodoPage] widget.
  const UpsertTodoPage({
    super.key,
    this.todo,
  });

  /// The todo to edit, or null if creating a new one.
  final TodoModel? todo;

  @override
  ConsumerState<UpsertTodoPage> createState() => _UpsertTodoPageState();
}

class _UpsertTodoPageState extends ConsumerState<UpsertTodoPage> {
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
        id: -1,
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
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    final model = _todo.copyWith(
      title: _titleController.text,
      description: _descriptionController.text,
      category: _category,
    );

    ref.read(upsertTodoProvider(model));

    Navigator.of(context).pop();
  }

  Future<void> _deleteTodo() async {
    if (!isEdit) {
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conferma eliminazione'),
        content: const Text('Sei sicuro di voler eliminare questo todo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) {
      return;
    }

    ref.read(deleteTodoProvider(widget.todo!.id));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle = isEdit ? 'Modifica Todo' : 'Aggiungi Todo';

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
                    spacing: 16,
                    children: [
                      TitleSection(controller: _titleController),
                      DescriptionSection(controller: _descriptionController),
                      CategorySection(
                        category: _category,
                        onChange: (category) {
                          setState(() {
                            _category = category;
                          });
                        },
                      ),
                      ExpirationSection(
                        todo: _todo,
                        onChange: (todo) {
                          setState(() {
                            _todo = todo;
                          });
                        },
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
                        spacing: 8,
                        children: [
                          Icon(Icons.delete, color: context.colorScheme.error),
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
