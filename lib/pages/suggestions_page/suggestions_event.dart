abstract class SuggestionsEvent {}

class SuggestionsLoadEvent extends SuggestionsEvent {
  String fromList;
  SuggestionsLoadEvent({
    required this.fromList,
  });
}

class SuggestionsClearEvent extends SuggestionsEvent {}
