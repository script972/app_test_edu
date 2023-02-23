import 'package:foxtrot_app/model/profile.dart';

abstract class ProfileState {}

class InitState extends ProfileState {}

class LoadingState extends ProfileState {}

class LoadedState extends ProfileState {

  User user;
  LoadedState({required this.user});
}

class ErrorState extends ProfileState {}
