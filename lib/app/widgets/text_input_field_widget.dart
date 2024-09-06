import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtracker/app/modules/account/controllers/account_controller.dart';

class TextInputFieldWidget extends GetWidget<AccountController> {
  const TextInputFieldWidget({
    super.key,
    required this.textEditingController,
    required this.hint,
    required this.type,
    this.align = TextAlign.start,
  });

  final TextEditingController textEditingController;
  final String hint;
  final TextInputType type;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autofocus: true,
        controller: textEditingController,
        keyboardType: type,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(hintText: hint),
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: align,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}
