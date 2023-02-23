import 'dart:io';
import 'package:foxtrot_app/pages/profile_page/profile_layout.dart';

class User {
  final String? name;
  final String? surname;
  final String? dateOfBirth;
  final File? avatar;
  final Sex? sex;
  User(
      { this.name,
         this.surname,
         this.dateOfBirth,
         this.avatar,
         this.sex});
  User copyWith({String? name, String? surname, String? dateOfBirth, File? avatar, Sex? sex}) {
    return User(
    name: name ?? this.name,
    surname: surname ?? this.surname,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    avatar: avatar ?? this.avatar,
    sex: sex ?? this.sex,
  );}

}
