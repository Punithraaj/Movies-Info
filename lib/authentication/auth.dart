
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // register with email and password
  Future<String> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return result.user.uid;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<String> currentUser() async {
    User user = await _firebaseAuth.currentUser;
    return user != null ? user.uid : null;
  }

  Future<String> signIn(String email, String password) async {
    UserCredential result = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password));
    return result.user.uid;
  }

  // sign out
  Future<void> signOut() async {
    try {
    return _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }

  }
}

