import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';


@JsonSerializable()
class Task {
  const Task({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  final String? id;
  final String? name;
  final String? avatar;
  final String? createdAt;

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
