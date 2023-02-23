import 'dart:convert';

import 'package:foxtrot_app/model/suggestions.dart';
import 'package:http/http.dart' as http;

abstract class SuggestionsProvider {
  Future<void> getSuggestions(String fromList);
}

class SuggestionsProviderImpl implements SuggestionsProvider {
  static const String jsonHttp =
      "https://mobile-json.oneplusone.solutions/api?api_token=cG5UpVdzrs8Lv8lqAqnkhVUbZDlFXylk9PQyxRxfFQdUuP18eRAL7YAt9NsHWsi3";
  @override
  Future getSuggestions(String fromList) async {
    final response = await http.get(
      Uri.parse(jsonHttp),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> list = json.decode(response.body);
      return list[fromList].map((model) => SuggestionsModel.fromJson(model)).toList();
    } else {
      throw Exception('Error fetching suggestions');
    }
  }
}
