import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';

/// The possible categories for a todo item.
enum TodoCategory {
  /// The work category, for todos related to work or professional tasks.
  work,

  /// The personal category, for todos related to personal life or hobbies.
  personal,

  /// The shopping category, for todos related to shopping or errands.
  shopping
  ;

  /// A human-readable label for the category, used in the UI.
  String get label => switch (this) {
    TodoCategory.work => 'Lavoro',
    TodoCategory.personal => 'Personale',
    TodoCategory.shopping => 'Spesa',
  };

  /// An icon that represents the category, used in the UI.
  IconData get icon => switch (this) {
    TodoCategory.work => Icons.work,
    TodoCategory.personal => Icons.person,
    TodoCategory.shopping => Icons.shopping_cart,
  };
}

/// The main model class for a todo item,
/// representing the data and properties of a single todo.
@freezed
abstract class TodoModel with _$TodoModel {
  /// Creates a new [TodoModel] instance with the given properties.
  const factory TodoModel({
    /// A unique [id] identifier for the todo item.
    required int id,

    /// The [title] of the todo item, a short string describing the task.
    required String title,

    /// The [description] of the todo item,
    /// a longer string with details about the task.
    required String description,

    /// A boolean [isCompleted] indicating whether
    /// the todo item is completed or not.
    required bool isCompleted,

    /// The [createdAt] date and time when the todo item was created.
    required DateTime createdAt,

    /// The [expireAt] date and time when the todo item is due or expires.
    required DateTime expireAt,

    /// The [category] of the todo item, indicating its type or context.
    /// The default category is [TodoCategory.personal] if not specified.
    @Default(TodoCategory.personal)
    @JsonKey(unknownEnumValue: TodoCategory.personal)
    TodoCategory category,
  }) = _TodoModel;
}
