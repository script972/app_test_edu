import 'package:foxtrot_app/model/usersComment.dart';

abstract class AboutState {}

class AboutEmptyState extends AboutState {}

class AboutLoadingState extends AboutState {}

class AboutLoadedState extends AboutState {
  List<UserComment> users;
  AboutLoadedState({required this.users});
}

class AboutErrorState extends AboutState {}
