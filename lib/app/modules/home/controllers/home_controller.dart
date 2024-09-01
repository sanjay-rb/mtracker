import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var bottomNavBarIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  updateBottomNavBarIndex(value) {
    bottomNavBarIndex.value = value;
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
  }
}
