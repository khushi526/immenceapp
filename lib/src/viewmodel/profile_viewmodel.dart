import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final curUser = FirebaseAuth.instance.currentUser!;
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
