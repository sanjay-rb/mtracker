import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/data/models/account_model.dart';

class AccountController extends GetxController {
  TextEditingController emojiController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController balanceController = TextEditingController(text: "0.0");
  @override
  void onInit() {
    if (Get.arguments != null) {
      Account category = Get.arguments as Account;
      emojiController.text = category.emoji!;
      nameController.text = category.name!;
      balanceController.text = category.balance.toString();
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
    if (balanceController.text.isEmpty) {
      showSnack("Please enter a valid balance.");
      return false;
    }
    if (!balanceController.text.isNum) {
      showSnack(
          "Please enter a valid number for the balance, avoiding any letters or symbols.");
      return false;
    }
    return true;
  }
}
