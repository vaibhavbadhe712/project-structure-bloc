import 'package:json_annotation/json_annotation.dart';

part 'jwt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class JwtTokeResponseModel {
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'emailId')
  String? emailId;
  @JsonKey(name: 'groupId')
  int? groupId;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'role')
  Role? role;
  @JsonKey(name: 'iat')
  int? iat;
  @JsonKey(name: 'exp')
  int? exp;

  JwtTokeResponseModel({
    this.userId,
    this.name,
    this.emailId,
    this.groupId,
    this.phoneNumber,
    this.role,
    this.iat,
    this.exp,
  });

  factory JwtTokeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JwtTokeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$JwtTokeResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Role {
  @JsonKey(name: 'roleId')
  int? roleId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'permissions')
  List<String>? permissions;

  Role({
    this.roleId,
    this.name,
    this.code,
    this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
