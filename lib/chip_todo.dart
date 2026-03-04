import 'package:flutter/material.dart';
import 'package:test/extensions.dart';

/// A simple widget that represents a chip with a title and an active state.
class ChipTodo extends StatelessWidget {
  /// Creates a [ChipTodo] widget.
  const ChipTodo({
    required this.title,
    required this.isActive,
    super.key,
  });

  /// The title of the chip.
  final String title;

  /// Whether the chip is active or not.
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive
        ? context.colorScheme.primaryContainer
        : context.colorScheme.surfaceContainer;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: .circular(20),
      ),
      child: Padding(
        padding: const .symmetric(horizontal: 16),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
