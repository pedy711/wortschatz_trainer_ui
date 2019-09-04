import 'package:wortschatz_trainer/models/basic/customLocation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
// useful commands to generate a file like  'user.g.dart':

// flutter pub run build_runner build --delete-conflicting-outputs


@JsonSerializable()
class User{
  @JsonKey(includeIfNull: false)
  int               id;
  String            firstName;
  String            lastName;
  int               gender;   // male = 1, female = 0
  String            email;
  String            password;
  bool              enabled;
  int               age;
  CustomLocation    location;
  DateTime          birthday;
  String            summary;

  static final User _user = User._internal();

  User._internal();

  factory User(){
    return _user;
  }


  User.withAll (this.firstName, this.lastName, this.email, this.password, this.enabled, this.age, this.birthday);
  User.withId (this.id, this.firstName, this.lastName, this.email, this.password, this.enabled, this.age);
  User.withEmailPassword (this.email, this.password);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

/*  int get id => _id; // fat operator '=>' means return
  String get email => _email;
  String get password => _password;

  set email (String email) {
    _email = email;
  }

  set password (String password) {
    _password = password;
  }*/

/*  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);*/
  /*Map <String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["email"] = _email;
    map["password"] = _password;
    if(_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  User.fromObject(dynamic o){
    this._id = o["id"];
    this._email = o["email"];
    this._password = o["password"];
  }*/

}