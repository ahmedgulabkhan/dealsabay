import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');

  // update user data
  Future updateUserData(String fullName, String email, String mobileNumber) async {
    return await userCollection.doc(uid).set({
      'userId': uid,
      'fullName': fullName,
      'email': email,
      'mobile': mobileNumber
    });
  }

  // get user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }
}