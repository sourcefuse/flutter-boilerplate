import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? label;
  final TextEditingController controller;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          border: const OutlineInputBorder()),
      controller: controller,
    );
  }
}
