// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'headquarters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Headquarters _$HeadquartersFromJson(Map<String, dynamic> json) {
  return $checkedNew('Headquarters', json, () {
    final val = Headquarters();
    $checkedConvert(json, 'address', (v) => val.address = v as String);
    $checkedConvert(json, 'city', (v) => val.city = v as String);
    $checkedConvert(json, 'state', (v) => val.state = v as String);
    return val;
  });
}

Map<String, dynamic> _$HeadquartersToJson(Headquarters instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
    };
