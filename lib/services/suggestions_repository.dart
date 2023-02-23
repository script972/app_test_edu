import 'package:foxtrot_app/services/suggestions_api_provider.dart';

class SuggestionsRepository {
  final SuggestionsProvider _suggestionsProvider = SuggestionsProviderImpl();
  Future<dynamic> getAllUsers(String fromList) =>
      _suggestionsProvider.getSuggestions(fromList);
}
