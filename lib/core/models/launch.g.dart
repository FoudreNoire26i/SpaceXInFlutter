// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) {
  return $checkedNew('Launch', json, () {
    final val = Launch();
    $checkedConvert(json, 'id', (v) => val.id = v as String);
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    $checkedConvert(json, 'success', (v) => val.success = v as bool);
    $checkedConvert(json, 'date_unix', (v) => val.date = v as int);
    $checkedConvert(json, 'details', (v) => val.description = v as String);
    $checkedConvert(
        json,
        'links',
        (v) => val.links =
            v == null ? null : Links.fromJson(v as Map<String, dynamic>));
    return val;
  }, fieldKeyMap: const {'date': 'date_unix', 'description': 'details'});
}

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'success': instance.success,
      'date_unix': instance.date,
      'details': instance.description,
      'links': instance.links?.toJson(),
    };
