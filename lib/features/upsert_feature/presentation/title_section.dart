import 'package:flutter/material.dart';
import 'package:todo_app/extensions.dart';

/// A widget that represents the title section of the upsert todo page.
class TitleSection extends StatelessWidget {
  /// Creates a [TitleSection] widget.
  const TitleSection({
    required this.controller,
    super.key,
  });

  /// The controller for the title text field.
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: 8,
      children: [
        Text(
          'Titolo',
          style: context.textTheme.labelLarge,
        ),
        TextFormField(
          controller: controller,
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
      ],
    );
  }
}
