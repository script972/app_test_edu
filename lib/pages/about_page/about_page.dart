import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxtrot_app/pages/about_page/users_data.dart';
import 'about_cubit.dart';
import 'about_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return AboutCubit(userDataList);
      },
      child: const AboutLayout(),
    );
  }
}
