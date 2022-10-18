import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:immenceapp/src/Model/data.dart';
import 'package:immenceapp/src/Utils/colors.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  Widget buildUser(SignUpData user) {
    final curUser = FirebaseAuth.instance.currentUser!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 10.0,
        shadowColor: Colors.white,
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: ThemeColors.profileBackground,
              child: Text(
                user.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                    color: ThemeColors.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              user.name,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(user.email),
            trailing: curUser.email == user.email
                ? const Icon(
                    Icons.circle,
                    color: ThemeColors.pureBlue,
                    size: 12,
                  )
                : null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

    return SafeArea(
      child: StreamBuilder<List<SignUpData>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 220, 0),
                  child: Text(
                    'immence',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: ThemeColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 255, 50),
                  child: Text(
                    'Users',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: users.map(buildUser).toList(),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
