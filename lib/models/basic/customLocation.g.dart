// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customLocation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomLocation _$CustomLocationFromJson(Map<String, dynamic> json) {
  return CustomLocation((json['latitude'] as num)?.toDouble(),
      (json['longitude'] as num)?.toDouble())
    ..id = json['id'] as int;
}

Map<String, dynamic> _$CustomLocationToJson(CustomLocation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['latitude'] = instance.latitude;
  val['longitude'] = instance.longitude;
  return val;
}
