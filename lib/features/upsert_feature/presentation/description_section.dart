import 'package:flutter/material.dart';
import 'package:todo_app/extensions.dart';

/// A widget that represents the description section of the upsert todo page.
class DescriptionSection extends StatelessWidget {
  /// Creates a [DescriptionSection] widget.
  const DescriptionSection({
    required this.controller,
    super.key,
  });

  /// The controller for the description text field.
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'Descrizione',
          style: context.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
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
      ],
    );
  }
}
