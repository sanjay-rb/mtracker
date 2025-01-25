import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/data/models/category_model.dart';

class CategoryController extends GetxController {
  TextEditingController emojiController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      Category category = Get.arguments as Category;
      emojiController.text = category.emoji!;
      nameController.text = category.name!;
    }
    super.onInit();
  }

  validateForm() {
    List<String> symbols = [
      "!",
      "@",
      "#",
      "\$",
      "%",
      "^",
      "&",
      "*",
      "(",
      ")",
      "-",
      "_",
      "=",
      "+",
      "{",
      "}",
      "[",
      "]",
      "|",
      "\\",
      ";",
      ":",
      "'",
      "\"",
      ",",
      ".",
      "/",
      "<",
      ">",
      "?",
      "~",
      "`",
      "£",
      "€",
      "¥",
      "©",
      "®",
      "™"
    ];
    showSnack(String text) {
      Get.snackbar(
        "Warning",
        text,
        backgroundColor: Colors.amber,
        icon: const Icon(Icons.error),
      );
    }

    if (emojiController.text.isEmpty) {
      showSnack("Please enter a valid emoji.");
      return false;
    }
    if (emojiController.text.isAlphabetOnly) {
      showSnack(
          "Please use emojis for better visual appeal instead of letters.");
      return false;
    }
    if (emojiController.text.isNum) {
      showSnack(
          "Please use emojis for better visual appeal instead of numbers.");
      return false;
    }
    if (symbols.contains(emojiController.text)) {
      showSnack(
          "Please use emojis for better visual appeal instead of symbols.");
      return false;
    }
    if (nameController.text.isEmpty) {
      showSnack("Please enter a valid name.");
      return false;
    }

    return true;
  }
}
