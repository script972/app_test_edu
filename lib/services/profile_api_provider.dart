import 'dart:io';
import 'package:foxtrot_app/pages/profile_page/profile_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foxtrot_app/model/profile.dart';

abstract class ProfileProvider {
  static const String _keySurname = "surname";
  static const String _keyName = "name";
  static const String _keyDOB = "dateOfBirth";
  static const String _keySex = "sex";
  static const String _keyImage = "image";
  Future<void> set(
    String surnameController,
    String nameController,
    String dateOfBirth,
    Sex sex,
    File image,
  );
  Future<User> get(User user);
}

class ProfileProviderData implements ProfileProvider {
  @override
  Future<void> set(
    String surnameController,
    String nameController,
    String dateOfBirth,
    Sex sex,
    File image,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ProfileProvider._keySurname, surnameController);
    prefs.setString(ProfileProvider._keyName, nameController);
    prefs.setString(ProfileProvider._keyDOB, dateOfBirth);
    prefs.setString(ProfileProvider._keySex, sex.toString());
    prefs.setString(ProfileProvider._keyImage, image.path);
  }

  @override
  Future<User> get(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return user.copyWith(
      name: prefs.getString(ProfileProvider._keyName),
      surname: prefs.getString(ProfileProvider._keySurname),
      dateOfBirth: prefs.getString(ProfileProvider._keyDOB),
      sex: prefs.getString(ProfileProvider._keySex) == Sex.male.toString() ? Sex.male : Sex.female,
      avatar: File(prefs.getString(ProfileProvider._keyImage)!),
    );
  }
}
