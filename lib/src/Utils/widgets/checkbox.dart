import 'package:flutter/material.dart';
import 'package:immenceapp/src/Utils/colors.dart';
import 'package:immenceapp/src/Utils/font_manager.dart';

class CheckBox extends StatelessWidget {
  bool? value;
  void Function(bool?)? onTap;

  CheckBox({this.value, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Expanded(
          child: Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 0, 0),
              child: Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.white,
                ),
                child: CheckboxListTile(
                  value: value,
                  onChanged: onTap,
                  tileColor: Colors.white,
                  activeColor: ThemeColors.primaryColor,
                  dense: false,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding:
                      const EdgeInsetsDirectional.fromSTEB(0, 0, 320, 0),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 220, 0),
          child: Text(
            'Remember Me',
            style: TextStyle(
              fontFamily: FontConstant.fontFamily,
            ),
          ),
        ),
      ]),
    );
  }
}
