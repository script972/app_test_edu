import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxtrot_app/pages/suggestions_page/suggestions_state.dart';
import 'package:foxtrot_app/services/suggestions_repository.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  final SuggestionsRepository suggestionRepository;

  SuggestionsCubit(this.suggestionRepository) : super(EmptyState());

  Future<void> fetchSuggestions(String fromList) async {
    try {
      emit(LoadingState());
      final List<dynamic> loadedSuggestionsList =
          await suggestionRepository.getAllUsers(fromList);
      emit(LoadedState(loadedSuggestions: loadedSuggestionsList));
    } catch (_) {
      emit(ErrorState());
    }
  }

  Future<void> clearSuggestions() async {
    emit(EmptyState());
  }
}
