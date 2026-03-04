import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';

enum TodoCategory {
  work,
  personal,
  shopping;

  String get label => switch (this) {
        TodoCategory.work => "Lavoro",
        TodoCategory.personal => "Personale",
        TodoCategory.shopping => "Spesa",
      };

  IconData get icon => switch (this) {
        TodoCategory.work => Icons.work,
        TodoCategory.personal => Icons.person,
        TodoCategory.shopping => Icons.shopping_cart,
      };
}

@freezed
abstract class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required DateTime createdAt,
    required DateTime expireAt,
    @Default(TodoCategory.personal)
    @JsonKey(unknownEnumValue: TodoCategory.personal)
    TodoCategory category,
  }) = _TodoModel;
}
