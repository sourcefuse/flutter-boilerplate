import 'package:json_annotation/json_annotation.dart';
part 'login_req_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  // Factory methods for serialization and deserialization
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
