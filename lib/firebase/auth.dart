import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String username, String email, String phone, String password,
      Function onSuccess, Function(String) onRegisterError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
      _createUser(username, email, phone, onSuccess, onRegisterError);
    }).catchError((err) {
      print("err: " + err.toString());
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onSignInError("Sign in fail, please try again !");
    });
  }

  _createUser(String username, String email, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = <String, String>{};
    user["name"] = username;
    user["phone"] = phone;
    // ignore: deprecated_member_use
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(username).set(user).then((user) {
      print("on value: SUCCESSED");
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onRegisterError("Sign up fail, please try again !");
    }).whenComplete(() => print("completed"));
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("Sign up fail, please try again");
        break;
    }
  }

  Future<void> signOut() async {
    print("signOut");
    return _firebaseAuth.signOut();
  }
}
