// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launchpad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchPad _$LaunchPadFromJson(Map<String, dynamic> json) {
  return $checkedNew('LaunchPad', json, () {
    final val = LaunchPad();
    $checkedConvert(json, 'id', (v) => val.id = v as String);
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    $checkedConvert(json, 'full_name', (v) => val.fullName = v as String);
    $checkedConvert(
        json, 'longitude', (v) => val.longitude = (v as num)?.toDouble());
    $checkedConvert(
        json, 'latitude', (v) => val.latitude = (v as num)?.toDouble());
    $checkedConvert(
        json, 'launch_attempts', (v) => val.launchAttempts = v as int);
    $checkedConvert(
        json, 'launch_successes', (v) => val.launchSuccesses = v as int);
    $checkedConvert(json, 'rockets',
        (v) => val.rocketIds = (v as List)?.map((e) => e as String)?.toList());
    $checkedConvert(json, 'details', (v) => val.details = v as String);
    $checkedConvert(json, 'status', (v) => val.status = v as String);
    return val;
  }, fieldKeyMap: const {
    'fullName': 'full_name',
    'launchAttempts': 'launch_attempts',
    'launchSuccesses': 'launch_successes',
    'rocketIds': 'rockets'
  });
}

Map<String, dynamic> _$LaunchPadToJson(LaunchPad instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'launch_attempts': instance.launchAttempts,
      'launch_successes': instance.launchSuccesses,
      'rockets': instance.rocketIds,
      'details': instance.details,
      'status': instance.status,
    };
