import 'package:dealsabay/model/custom_user.dart';
import 'package:dealsabay/util/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignInInstance = GoogleSignIn();

  // create user object based on FirebaseUser
  CustomUser? userFromFirebaseUser(User user) {
    return (user != null) ? CustomUser(uid: user.uid) : null;
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return userFromFirebaseUser(user!);
    } catch(e) {
      return null;
    }
  }

  // sign in with google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignInInstance.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = result.user;

      await DatabaseService().updateUserData(user!.uid, user.displayName!, user.email!, (user.phoneNumber == null) ? "" : user.phoneNumber!);
      return user;
    } catch(e) {
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String fullName, String email, String password, String mobileNumber) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Create a new document for the user with uid
      await DatabaseService().updateUserData(user!.uid, fullName, email, mobileNumber);
      return userFromFirebaseUser(user);
    } catch(e) {
      if (e.toString().contains("email-already-in-use")) {
        return "Error: " + e.toString().substring(e.toString().indexOf('] ') + 2);
      }
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInSharedPreference(false);
      await HelperFunctions.saveUserEmailSharedPreference('');
      await HelperFunctions.saveUserFullNameSharedPreference('');

      await _auth.signOut().whenComplete(() async {});
      await _googleSignInInstance.signOut();
      return null;
    } catch(e) {
      return null;
    }
  }
}