import 'package:get/get.dart';

class SettingsController extends GetxController{
  static SettingsController to = Get.find<SettingsController>();
  var musicEnabled = true.obs;
  var sfxEnabled = true.obs;
  var signedIn = false.obs;
}