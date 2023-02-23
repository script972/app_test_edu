import 'package:flutter/material.dart';
import 'package:foxtrot_app/pages/suggestions_page/suggestions_page.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SuggestionsPage(),
    );
    //);
  }
}
