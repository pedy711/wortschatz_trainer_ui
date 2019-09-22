import 'package:json_annotation/json_annotation.dart';

part 'FlashCard.g.dart';

@JsonSerializable()
class FlashCard {
  @JsonKey(includeIfNull: false)
  int id;
  String word;
  String translation;

  FlashCard (this.word, this.translation);
  FlashCard.withId(this.id, this.word, this.translation);

  factory FlashCard.fromJson(Map<String, dynamic> json) => _$FlashCardFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardToJson(this);
}
