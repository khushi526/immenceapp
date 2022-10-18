import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immenceapp/src/Model/data.dart';
import 'package:immenceapp/src/Utils/Colors.dart';
import 'package:immenceapp/src/Utils/font_manager.dart';
import 'package:immenceapp/src/Utils/widgets/user_detail.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget buildUser(SignUpData user) {
    final curUser = FirebaseAuth.instance.currentUser!;
    if (user.email == curUser.email) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: ThemeColors.profileBackground,
                foregroundImage: AssetImage("assets/Logo.png"),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              user.name,
              style: const TextStyle(
                color: ThemeColors.primaryColor,
                fontSize: FontSize.s26,
                fontWeight: FontWeight.w700,
                fontFamily: FontConstant.fontFamily,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            userDetail(
              name: 'Email',
              user: user.email,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: ThemeColors.dividerColor,
            ),
            const SizedBox(
              height: 20,
            ),
            userDetail(name: 'Phone No', user: user.phone),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: ThemeColors.dividerColor,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: FontSize.s18,
                    fontWeight: FontWeightManager.medium,
                    color: Colors.black,
                    fontFamily: FontConstant.fontFamily,
                  ),
                ),
                IconButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: const Icon(
                    Icons.logout,
                    size: FontSize.s18,
                    color: ThemeColors.primaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            const Divider(
              color: ThemeColors.dividerColor,
            ),
          ],
        ),
      );
    } else {
      return const Text(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    // SignUpData user;
    Stream<List<SignUpData>> readUsers() => FirebaseFirestore.instance
        .collection('user')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => SignUpData.fromJson(
                doc.data(),
              ),
            )
            .toList());
    return StreamBuilder<List<SignUpData>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
