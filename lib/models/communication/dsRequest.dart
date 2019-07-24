import 'package:json_annotation/json_annotation.dart';

part 'dsRequest.g.dart';

@JsonSerializable()
class DsRequest{
  String dataSource;
  String operationType;
  int startRow;
  int endRow;
  String textMatchStyle;
  String componentId;
  Map<Object, Object> data;
  String oldValues;
  List < Object > sortBy = new List < Object > ();

  DsRequest(this.startRow, this.endRow);
  DsRequest.withData(this.startRow, this.endRow, this.data);

  factory DsRequest.fromJson(Map<String, dynamic> json) => _$DsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DsRequestToJson(this);

}