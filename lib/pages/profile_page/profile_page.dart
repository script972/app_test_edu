import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxtrot_app/pages/profile_page/profile_cubit.dart';
import 'package:foxtrot_app/pages/profile_page/profile_layout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return ProfileCubit();
      },
      child: const ProfileLayout(),
    );
  }
}
