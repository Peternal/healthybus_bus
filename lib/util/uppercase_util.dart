import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class UppercaseTextInputFormatter extends TextInputFormatter{

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate

    String newvalueText=newValue.text;

    newvalueText = newvalueText.toUpperCase();

    return TextEditingValue(
      text: newvalueText,
      selection: new TextSelection.collapsed(offset: newvalueText.length),
    );
  }

}
