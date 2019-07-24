import 'package:json_annotation/json_annotation.dart';

part 'customLocation.g.dart';

@JsonSerializable()
class CustomLocation{
  @JsonKey(includeIfNull: false)
  int           id;
  double        latitude;
  double        longitude;

  CustomLocation (this.latitude, this.longitude);

  factory CustomLocation.fromJson(Map<String, dynamic> json) => _$CustomLocationFromJson(json);

  Map<String, dynamic> toJson() => _$CustomLocationToJson(this);
}