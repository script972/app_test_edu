import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxtrot_app/pages/profile_page/profile_cubit.dart';
import 'package:foxtrot_app/pages/profile_page/profile_state.dart';
import 'package:foxtrot_app/services/profile_request.dart';

enum Sex { male, female }

class ProfileLayout extends StatefulWidget {
  const ProfileLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileLayout> createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Sex? sex = Sex.female;
  File? image;
  @override
  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = context.read<ProfileCubit>();
    profileCubit.dataFromStorage();
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildProfile(profileCubit, nameController, surnameController),
      bottomNavigationBar: _buildSubmitButton(profileCubit),
    );
  }

  Widget _buildSubmitButton(ProfileCubit profileCubit) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffFF473D)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  profileCubit.set(surnameController.text, nameController.text, dateController.text, sex!, image!);
                }
              },
              child: const Text("Сохранить изменения")),
        ),
      ),
    );
  }

  Widget _buildProfile(
      ProfileCubit profileCubit, TextEditingController nameController, TextEditingController surnameController) {
    return SingleChildScrollView(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is LoadedState) {
            if (state.user.surname != null) {
              surnameController.text = state.user.surname!;
            }
            if (state.user.name != null) {
              nameController.text = state.user.name!;
            }
            if (state.user.dateOfBirth != null) {
              dateController.text = state.user.dateOfBirth!;
            }
            if (state.user.avatar != null) {
              image = state.user.avatar;
            }
          }
          return Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildAvatar(profileCubit, state),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Имя",
                        labelStyle: TextStyle(
                          color: Color(0xFFFF473D),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: surnameController,
                      decoration: const InputDecoration(
                        labelText: "Фамилия",
                        labelStyle: TextStyle(
                          color: Color(0xFFFF473D),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
                    child: _buildTextFormDate(profileCubit, context, state),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
                    child: Row(
                      children: const [
                        Text(
                          "Пол",
                          style: TextStyle(
                            color: Color(0xFFFF473D),
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildRadioButton(profileCubit, state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextFormDate(ProfileCubit profileCubit, BuildContext context, ProfileState state) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please choose date';
        }
        return null;
      },
      controller: dateController,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            profileCubit.selectDate(context, dateController);
          },
          icon: const Icon(Icons.date_range),
        ),
        labelText: "Дата рождения",
        labelStyle: const TextStyle(
          color: Color(0xFFFF473D),
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildRadioButton(ProfileCubit profileCubit, ProfileState state) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildRadioBox(state, profileCubit, 'Мужской', Sex.male),
        ),
        Expanded(
          child: _buildRadioBox(state, profileCubit, 'Женский', Sex.female),
        ),
      ],
    );
  }

  Widget _buildRadioBox(ProfileState state, ProfileCubit profileCubit, String textToRadio, Sex defaultSex) {
    return ListTile(
      title: Text(textToRadio),
      leading: Radio<Sex>(
        value: defaultSex,
        groupValue: state is LoadedState && state.user.sex != null ? state.user.sex : defaultSex,
        onChanged: (Sex? value) {
          sex = value;
          profileCubit.changeOption(value);
        },
      ),
    );
  }

  Widget _buildAvatar(ProfileCubit profileCubit, ProfileState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(left: 90, top: 40, right: 40, bottom: 40),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromRGBO(0, 0, 0, 0.12),
              width: 5,
            ),
          ),
          child: state is LoadedState && state.user.avatar != null
              ? CircleAvatar(
                  backgroundImage: FileImage(state.user.avatar!),
                  radius: 45,
                )
              : const SizedBox(),
        ),
        IconButton(
          onPressed: () async {
            requestStoragePermission();
            await profileCubit.getFromGallery(image);
            if (state is LoadedState && state.user.avatar != null) {
              image = state.user.avatar;
              print(image);
              print(state.user.avatar);
            }
          },
          icon: const Icon(
            Icons.camera_alt_outlined,
            color: Color.fromRGBO(0, 0, 0, 0.12),
          ),
        )
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Row(
        children: const [
          Text(
            "Профиль",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF02AD58),
    );
  }
}
