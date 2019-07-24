// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DsResponse _$DsResponseFromJson(Map<String, dynamic> json) {
  return DsResponse(json['startRow'] as int, json['endRow'] as int,
      json['data'] as List, json['totalRows'] as int)
    ..status = json['status'] as int;
}

Map<String, dynamic> _$DsResponseToJson(DsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'startRow': instance.startRow,
      'endRow': instance.endRow,
      'totalRows': instance.totalRows,
      'data': instance.data
    };
