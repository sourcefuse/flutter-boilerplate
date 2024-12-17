import 'package:json_annotation/json_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class DashboardResponse {
  int? userId;
  int? id;
  String? title;
  String? body;

  DashboardResponse({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  // Factory methods for serialization and deserialization
  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}
