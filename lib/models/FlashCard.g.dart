// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FlashCard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashCard _$FlashCardFromJson(Map<String, dynamic> json) {
  return FlashCard(json['word'] as String, json['translation'] as String)
    ..id = json['id'] as int;
}

Map<String, dynamic> _$FlashCardToJson(FlashCard instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['word'] = instance.word;
  val['translation'] = instance.translation;
  return val;
}
