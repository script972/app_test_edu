import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxtrot_app/pages/profile_page/profile_layout.dart';
import 'package:foxtrot_app/pages/profile_page/profile_state.dart';
import 'package:foxtrot_app/services/profile_date.dart';
import 'package:foxtrot_app/services/profile_repository.dart';
import 'package:foxtrot_app/model/profile.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(InitState());
  User user = User();

  Future<void> set(String surname, String name,
      String dateOfBirth, Sex sex, File image) async {
    await ProfileRepository().setUsersData(
        surname, name, dateOfBirth, sex, image);
  }

  Future<void> dataFromStorage() async {
    try {
      emit(LoadingState());
      user = await ProfileRepository().getUsersData(user);
      emit(LoadedState(user: user));
    } catch (_) {
      emit(ErrorState());
    }
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController dateInput) async {
    try {
      emit(LoadingState());
      user = user.copyWith(dateOfBirth: await ProfileData().chooseDate(context, dateInput));
      emit(LoadedState(user: user));
    } catch (_) {
      emit(ErrorState());
    }
  }

  Future<void> getFromGallery(File? image) async {
    try {
      emit(LoadingState());
      user = user.copyWith(avatar: await ProfileData().imagePick(image));
      emit(LoadedState(user: user));
    } catch (_) {
      emit(ErrorState());
    }
  }

  void changeOption(Sex? newOption) {
    try {
      emit(LoadingState());
      user = user.copyWith(sex: newOption);
      emit(LoadedState(user: user));
    } catch (_) {
    emit(ErrorState());
    }
  }
}
