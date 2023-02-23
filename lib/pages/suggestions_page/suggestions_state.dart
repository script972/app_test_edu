abstract class SuggestionsState {}

class EmptyState extends SuggestionsState {}

class LoadingState extends SuggestionsState {}

class LoadedState extends SuggestionsState {
  List<dynamic> loadedSuggestions;
  LoadedState({required this.loadedSuggestions});
}

class ErrorState extends SuggestionsState {}
