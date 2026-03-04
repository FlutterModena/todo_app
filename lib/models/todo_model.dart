import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';

@freezed
abstract class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    required String title,
    required String description,
    required String category,
    required bool isCompleted,
    required DateTime createdAt,
    required DateTime expireAt,
  }) = _TodoModel;
}