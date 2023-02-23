import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  await Permission.storage.isGranted;
  await Permission.storage.request();
}