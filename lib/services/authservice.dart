import 'package:firebase_auth/firebase_auth.dart';
import 'package:thaimeet/services/databaseservice.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
  bool isLoading = false;

  //sign up user
  Future signUp(
      {required String email,
      required String password,
      required int number,
      required String name}) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        DatabaseService(uid: user.uid).saveUserData(name, email, number);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //sign in user
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //sign out
  Future signOut() async {
    await _auth.signOut();
  }
}
