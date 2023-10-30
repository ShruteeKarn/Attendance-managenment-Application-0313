// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'icons.dart';

class InputTitleTextFeild extends StatelessWidget {
  const InputTitleTextFeild({
    Key? key,
    required this.myController,
    required this.hint,
    required this.onchanged,
    required this.IconData,
    required this.labeltext,
    this.enable = true,
    this.autoFocus = false,
  }) : super(key: key);

  final TextEditingController myController;
  final FormFieldSetter onchanged;
  final String hint;
  final IconData;
  final String labeltext;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: myController,
        onChanged: onchanged,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: 19,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          hintText: hint,
          enabled: enable,
          prefixIcon: Icon(IconData),
          contentPadding: const EdgeInsets.all(
            20,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
        ),
        validator: (value) {
          RegExp nonWhitespaceRegExp = RegExp(r'\S');
          if (value == null || value.isEmpty) {
            return 'Please enter the title';
          }
          if (!nonWhitespaceRegExp.hasMatch(value)) {
            return 'Not valid format';
          }
          if (value.length > 50) {
            return 'Title should be less than 50 Characters';
          }
          return null;
        },
      ),
    );
  }
}

class InputAmountTextFeild extends StatelessWidget {
  const InputAmountTextFeild({
    Key? key,
    required this.myController,
    required this.hint,
    required this.labeltext,
    this.enable = true,
    this.autoFocus = false,
    required this.onchanged,
  }) : super(key: key);
  final TextEditingController myController;
  final FormFieldSetter onchanged;
  final String hint;
  final String labeltext;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: TextFormField(
        maxLength: 6,
        onChanged: onchanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: myController,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 19,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          hintText: hint,
          enabled: enable,
          prefixIcon: const Icon(
            AppIcons.currency_rupee,
          ),
          contentPadding: const EdgeInsets.all(
            20,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
        ),
        validator: (value) {
          RegExp digitRegExp = RegExp(r'^[1-9]\d*$');
          if (value == null || value.isEmpty) {
            return 'Please enter the amount';
          }
          if (!digitRegExp.hasMatch(value)) {
            return 'Not valid amount';
          }
          return null;
        },
      ),
    );
  }
}

class InputDescTextFeild extends StatelessWidget {
  const InputDescTextFeild({
    Key? key,
    required this.myController,
    required this.hint,
    required this.labeltext,
    this.enable = true,
    this.autoFocus = false,
    required this.onchanged,
  }) : super(key: key);
  final TextEditingController myController;
  final String hint;
  final FormFieldSetter onchanged;
  final String labeltext;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: TextFormField(
        maxLines: 3,
        onChanged: onchanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: myController,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(
          fontSize: 19,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          hintText: hint,
          enabled: enable,
          prefixIcon: const Icon(
            AppIcons.description,
          ),
          contentPadding: const EdgeInsets.all(
            20,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
          ),
        ),
        validator: (value) {
          RegExp nonWhitespaceRegExp = RegExp(r'\S');
          if (value == null || value.isEmpty) {
            return 'Please enter the description';
          }
          if (!nonWhitespaceRegExp.hasMatch(value)) {
            return "Not valid format";
          }
          if (value.length < 10) {
            return 'Description must be minimum 10 Characters';
          }
          if (value.length > 300) {
            return 'Description should be less than 300 Characters';
          }
          return null;
        },
      ),
    );
  }
}
