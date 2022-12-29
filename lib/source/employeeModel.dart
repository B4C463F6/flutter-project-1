import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'employeeModel.g.dart';

@JsonSerializable()
class EmployeeModel {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'contact')
  String? contact;

  @JsonKey(name: 'isChecked')
  bool isChecked = false;

  EmployeeModel({
    this.name,
    this.contact,
    required this.isChecked,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  @override
  String toString() {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(this);
  }
}
