import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxBool isDrawerOpen = false.obs;

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }
}
