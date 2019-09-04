import 'package:json_annotation/json_annotation.dart';

part 'FlashCard.g.dart';

@JsonSerializable()
class FlashCard {
  @JsonKey(includeIfNull: false)
  int id;
  String word;
  String translation;

  /* static final FlashCard _flashCard = FlashCard._internal();

  FlashCard._internal();

  factory FlashCard() {
    return _flashCard;
  } */

  FlashCard(this.word, this.translation);

  factory FlashCard.fromJson(Map<String, dynamic> json) => _$FlashCardFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardToJson(this);
}
