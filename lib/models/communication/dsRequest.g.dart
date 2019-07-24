// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dsRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DsRequest _$DsRequestFromJson(Map<String, dynamic> json) {
  return DsRequest(json['startRow'] as int, json['endRow'] as int)
    ..dataSource = json['dataSource'] as String
    ..operationType = json['operationType'] as String
    ..textMatchStyle = json['textMatchStyle'] as String
    ..componentId = json['componentId'] as String
    ..data = json['data'] as Map<String, dynamic>
    ..oldValues = json['oldValues'] as String
    ..sortBy = json['sortBy'] as List;
}

Map<String, dynamic> _$DsRequestToJson(DsRequest instance) => <String, dynamic>{
      'dataSource': instance.dataSource,
      'operationType': instance.operationType,
      'startRow': instance.startRow,
      'endRow': instance.endRow,
      'textMatchStyle': instance.textMatchStyle,
      'componentId': instance.componentId,
      'data': instance.data,
      'oldValues': instance.oldValues,
      'sortBy': instance.sortBy
    };
