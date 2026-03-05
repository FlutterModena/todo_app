import 'package:flutter/material.dart';
import 'package:todo_app/common/models/todo_model.dart';
import 'package:todo_app/extensions.dart';

/// A widget that represents the category section of the upsert todo page.
class CategorySection extends StatelessWidget {
  /// Creates a [CategorySection] widget.
  const CategorySection({
    super.key,
    this.category,
    this.onChange,
  });

  /// The selected category, or null if none is selected.
  final TodoCategory? category;
  /// The callback to call when the user selects a category.
  final void Function(TodoCategory category)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 4,
      children: [
        Text(
          'Categoria',
          style: context.textTheme.labelLarge,
        ),
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: .horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: TodoCategory.values.length,
            itemBuilder: (context, index) {
              final cat = TodoCategory.values[index];
              return ChoiceChip(
                label: Text(cat.label),
                avatar: Icon(cat.icon, size: 16),
                selected: category == cat,
                onSelected: (selected) {
                  if (selected) {
                    onChange?.call(cat);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
