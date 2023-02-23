import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxtrot_app/pages/suggestions_page/suggestions_cubit.dart';
import 'package:foxtrot_app/services/suggestions_repository.dart';
import 'suggestions_layout.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final suggestionRepository = SuggestionsRepository();
    return BlocProvider(
        create: (BuildContext context) {
          return SuggestionsCubit(suggestionRepository);
        },
        child: const SuggestionsLayout(),
    );
  }
}
