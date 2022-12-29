// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employeeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
      name: json['name'] as String?,
      contact: json['contact'] as String?,
      isChecked: json['isChecked'] as bool?,
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contact': instance.contact,
      'isChecked': instance.isChecked,
    };
