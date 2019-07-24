// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as int
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..gender = json['gender'] as int
    ..email = json['email'] as String
    ..password = json['password'] as String
    ..enabled = json['enabled'] as bool
    ..age = json['age'] as int
    ..location = json['location'] == null
        ? null
        : CustomLocation.fromJson(json['location'] as Map<String, dynamic>)
    ..birthday = json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String)
    ..summary = json['summary'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['firstName'] = instance.firstName;
  val['lastName'] = instance.lastName;
  val['gender'] = instance.gender;
  val['email'] = instance.email;
  val['password'] = instance.password;
  val['enabled'] = instance.enabled;
  val['age'] = instance.age;
  val['location'] = instance.location;
  val['birthday'] = instance.birthday?.toIso8601String();
  val['summary'] = instance.summary;
  return val;
}
