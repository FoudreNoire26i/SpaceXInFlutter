// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landpad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandPad _$LandPadFromJson(Map<String, dynamic> json) {
  return $checkedNew('LandPad', json, () {
    final val = LandPad();
    $checkedConvert(json, 'id', (v) => val.id = v as String);
    $checkedConvert(json, 'name', (v) => val.name = v as String);
    $checkedConvert(json, 'full_name', (v) => val.fullName = v as String);
    $checkedConvert(
        json, 'longitude', (v) => val.longitude = (v as num)?.toDouble());
    $checkedConvert(
        json, 'latitude', (v) => val.latitude = (v as num)?.toDouble());
    $checkedConvert(
        json, 'landing_attempts', (v) => val.landingAttempts = v as int);
    $checkedConvert(
        json, 'landing_successes', (v) => val.landingSuccesses = v as int);
    $checkedConvert(
        json,
        'launches',
        (v) =>
            val.launchesIds = (v as List)?.map((e) => e as String)?.toList());
    $checkedConvert(json, 'details', (v) => val.details = v as String);
    $checkedConvert(json, 'status', (v) => val.status = v as String);
    return val;
  }, fieldKeyMap: const {
    'fullName': 'full_name',
    'landingAttempts': 'landing_attempts',
    'landingSuccesses': 'landing_successes',
    'launchesIds': 'launches'
  });
}

Map<String, dynamic> _$LandPadToJson(LandPad instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'landing_attempts': instance.landingAttempts,
      'landing_successes': instance.landingSuccesses,
      'launches': instance.launchesIds,
      'details': instance.details,
      'status': instance.status,
    };
