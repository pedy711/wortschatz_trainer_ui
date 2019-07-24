import 'package:json_annotation/json_annotation.dart';

part 'dsResponse.g.dart';

@JsonSerializable()
class DsResponse {
  static int STATUS_FAILURE = -1;
  static int STATUS_LOGIN_INCORRECT = -5;
  static int STATUS_LOGIN_REQUIRED = -7;
  static int STATUS_LOGIN_SUCCESS = -8;
  static int STATUS_MAX_LOGIN_ATTEMPTS_EXCEEDED = -6;
  static int STATUS_SERVER_TIMEOUT = -100;
  static int STATUS_SUCCESS = 0;
  static int STATUS_TRANSPORT_ERROR = -90;
  static int STATUS_VALIDATION_ERROR = -4;

  int status;
  int startRow;
  int endRow;
  int totalRows;
  List<Object> data;

  DsResponse(this.startRow, this.endRow, this.data, this.totalRows);

  factory DsResponse.fromJson(Map<String, dynamic> json) => _$DsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DsResponseToJson(this);
}
