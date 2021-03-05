// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return $checkedNew('Company', json, () {
    final val = Company();
    $checkedConvert(json, 'id', (v) => val.id = v as String);
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    $checkedConvert(json, 'founder', (v) => val.founder = v as String);
    $checkedConvert(json, 'employees', (v) => val.employeesNb = v as int);
    $checkedConvert(
        json,
        'headquarters',
        (v) => val.headquarters = v == null
            ? null
            : Headquarters.fromJson(v as Map<String, dynamic>));
    return val;
  }, fieldKeyMap: const {'employeesNb': 'employees'});
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'founder': instance.founder,
      'employees': instance.employeesNb,
      'headquarters': instance.headquarters?.toJson(),
    };
