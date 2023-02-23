import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foxtrot_app/utils/date_util.dart';
import 'package:image_picker/image_picker.dart';

class ProfileData {
  Future<String> chooseDate(BuildContext context, TextEditingController dateInput) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return dateInput.text = '${DateUtil.globalAppDateFormat.format(selectedDate)} year';
    }
    return '';
  }

  Future imagePick(File? image) async {
    final XFile? imagePicker = await ImagePicker().pickImage(
      maxWidth: 1800,
      maxHeight: 1800,
      source: ImageSource.gallery,
    );
    imagePicker == null ? '' : File(imagePicker.path);
    if (imagePicker != null) {
      return image = File(imagePicker.path);
    }
  }
}
