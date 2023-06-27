import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future deleteUser(String email, String password) async {
    // try {
    //   var user = await _auth.currentUser!;
    //   AuthCredential credentials = EmailAuthProvider.getCredential(email: email, password: password);
    //   print(user);
    //   AuthResult result = await user.reauthenticateWithCredential(credentials);
    //   await DatabaseService(uid: result.user.uid).deleteuser(); // called from database class
    //   await result.user.delete();
    //   return true;
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }
}