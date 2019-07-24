// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataSourceResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSourceResponse _$DataSourceResponseFromJson(Map<String, dynamic> json) {
  return DataSourceResponse(json['response'] == null
      ? null
      : DsResponse.fromJson(json['response'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DataSourceResponseToJson(DataSourceResponse instance) =>
    <String, dynamic>{'response': instance.response};
