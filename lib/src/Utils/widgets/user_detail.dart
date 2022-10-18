import 'package:flutter/material.dart';
import 'package:immenceapp/src/Utils/Colors.dart';
import 'package:immenceapp/src/Utils/font_manager.dart';

class userDetail extends StatelessWidget {
  String name;
  String user;
  userDetail({
    required this.name,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: FontSize.s18,
            fontWeight: FontWeightManager.medium,
            color: Colors.black,
            fontFamily: FontConstant.fontFamily,
          ),
        ),
        Text(
          user,
          style: const TextStyle(
            color: ThemeColors.primaryColor,
            fontFamily: FontConstant.fontFamily,
            fontWeight: FontWeightManager.regular,
          ),
        ),
      ],
    );
  }
}
