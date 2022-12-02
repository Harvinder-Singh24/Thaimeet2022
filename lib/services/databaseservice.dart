import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  late final String? uid;
  DatabaseService({required this.uid});

  //refrence collection
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  //saving the user data_
  Future saveUserData(String name, String email, int number) async {
    return await usersCollection.doc(uid).set({
      "name": name,
      "email": email,
      "number": number,
      "uid": uid,
    });
  }
}
