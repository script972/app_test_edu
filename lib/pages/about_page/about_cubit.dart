import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxtrot_app/model/usersComment.dart';
import 'package:foxtrot_app/pages/about_page/about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  List<UserComment> users = [];
  AboutCubit(this.users) : super(AboutEmptyState());
  Future<void> fetchSuggestions(String text, double rating) async {
    try {
      emit(AboutLoadingState());
      users.insert(
          0,
          UserComment(
              name: 'Volodymyr Kadomtsev',
              text: text,
              star: rating,
              avatar: '',
              thisMy: true));
      emit(AboutLoadedState(users: users));
    } catch (_) {
      emit(AboutErrorState());
    }
  }
}
