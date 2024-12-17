import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import '../constants/validator.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final bool isRequired;
  final TextInputType inputType;
  final String? validationType;
  final String? validationMessage;
  final bool readOnly;
  final bool? enable;
  final bool? isDense;
  bool isPassword = false;
  final Function(String)? onChange;
  final int? maxLine;
  final Function()? onEditingComplete;
  final String? Function(String?)? validation;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? formatters;
  final Widget? suffixIcon;

  CustomTextFormField(
      {super.key,
      required this.controller,
      this.isPassword = false,
      this.hintText = '',
      this.labelText,
      this.isRequired = false,
      this.inputType = TextInputType.text,
      this.validationType,
      this.validationMessage = '',
      this.maxLine = 1,
      this.readOnly = false,
      this.enable = true,
      this.onChange,
      this.validation,
      this.textDirection,
      this.onEditingComplete,
      this.isDense = true,
      this.suffixIcon,
      this.formatters});

  @override
  State<CustomTextFormField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
            textDirection: widget.textDirection,
            enabled: widget.enable,
            readOnly: widget.readOnly,
            maxLines: widget.maxLine,
            obscureText: _obscureText,
            keyboardType: widget.inputType,
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodySmall,
            onChanged: widget.onChange,
            inputFormatters: widget.formatters,
            onEditingComplete: widget.onEditingComplete,
            decoration: formFieldDecoration(
              context,
              widget.hintText,
              widget.labelText,
              isRequired: widget.isRequired,
              suffix: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: suffixIconColor(context),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon,
              isDense: widget.isDense,
            ),
            validator:
                ((widget.isRequired == true) && (widget.validation == null))
                    ? (value) {
                        if (widget.isRequired == true) {
                          if (value?.isEmpty ?? false) {
                            return (widget.validationMessage != '')
                                ? widget.validationMessage
                                : "Field is required"; //---Generic message
                          } else if (widget.validationType ==
                              ConstantValues.email) {
                            return Validator.isEmailValid(value ?? '');
                          } else if (widget.validationType ==
                              ConstantValues.password) {
                            return Validator.isValidPassword(value ?? '');
                          } else {
                            return null;
                          }
                        } else {
                          return null;
                        }
                      }
                    : widget.validation),
      ],
    );
  }
}

///hintText will be visible when field is not focused
///label will be visible when field is focused
///suffix icon will show at the end of field
InputDecoration formFieldDecoration(
  BuildContext context,
  String? hintText,
  String? labelText, {
  bool? isDense = true,
  bool? isRequired,
  Widget? suffix,
}) {
  return InputDecoration(
    errorMaxLines: 2,
    isDense: isDense,
    alignLabelWithHint: true,
    hintText: hintText,
    labelText: labelText,
    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.normal,
        ),
    labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.normal,
        ),
    suffixIcon: suffix,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    border: inputBorder(),
    focusedBorder: inputBorder(),
    enabledBorder: inputBorder(),
  );
}

InputBorder inputBorder({Color? underLineColor}) {
  underLineColor = underLineColor ?? const Color.fromRGBO(215, 215, 215, 1);
  return OutlineInputBorder(
      borderSide: BorderSide(color: underLineColor, width: 2.0),
      borderRadius: BorderRadius.circular(30));
}

Color suffixIconColor(BuildContext context) {
  switch (Theme.of(context).brightness) {
    case Brightness.light:
      return Colors.grey.shade700;
    case Brightness.dark:
      return Colors.white70;
  }
}
