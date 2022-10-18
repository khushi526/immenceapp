import 'package:flutter/material.dart';
import 'package:immenceapp/src/Utils/Colors.dart';
import 'package:immenceapp/src/Utils/font_manager.dart';

class TextFields extends StatefulWidget {
  String name;
  TextEditingController controller;
  String hintText;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? padding1;
  VoidCallback? onTap;
  Icon? icon;

  TextFields({
    required this.name,
    required this.controller,
    required this.hintText,
    this.padding,
    this.padding1,
    this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 25, 0, 0),
          child: Text(
            widget.name,
            style: const TextStyle(
              fontFamily: FontConstant.fontFamily,
              color: ThemeColors.textField,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 25, 0),
          child: TextFormField(
            controller: widget.controller,
            obscureText: false,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontFamily: FontConstant.fontFamily,
                color: ThemeColors.textColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ThemeColors.borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ThemeColors.borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: GestureDetector(
                onTap: widget.onTap,
                child: widget.icon,
              ),
              contentPadding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            ),
            style: const TextStyle(
              fontFamily: FontConstant.fontFamily,
              color: Colors.black,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
