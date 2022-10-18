import 'package:flutter/material.dart';
import 'package:immenceapp/src/Utils/colors.dart';
import 'package:immenceapp/src/Utils/font_manager.dart';

class Button extends StatelessWidget {
  String name;
  VoidCallback onTap;
  Button({
    required this.name,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
      child: SizedBox(
        width: 130,
        height: 40,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ThemeColors.primaryColor,
              side: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                  //to set border radius to button
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: onTap,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: FontConstant.fontFamily,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
