import 'dart:io';
import 'package:foxtrot_app/pages/profile_page/profile_layout.dart';
import 'package:foxtrot_app/services/profile_api_provider.dart';
import 'package:foxtrot_app/model/profile.dart';

class ProfileRepository {
  final ProfileProvider _profileProvider = ProfileProviderData();
  Future<dynamic> setUsersData(String surnameController, String nameController, String dateOfBirth, Sex sex, File image) =>
      _profileProvider.set(surnameController, nameController, dateOfBirth, sex, image);
  Future<User> getUsersData (User user)  =>
       _profileProvider.get( user);
}
