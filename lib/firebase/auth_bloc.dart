import 'dart:async';
import 'package:smart_parking/firebase/auth.dart';

class AuthBloc {
  final _firAuth = Authentication();

  final StreamController _usernameController = StreamController();
  final StreamController _emailController = StreamController();
  final StreamController _phoneController = StreamController();
  final StreamController _passController = StreamController();

  Stream get nameStream => _usernameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get phoneStream => _phoneController.stream;
  Stream get passStream => _passController.stream;

  bool isValid(String username, String email, String phone, String password) {
    if (username.isEmpty) {
      _usernameController.sink.addError("Enter username!");
      return false;
    }
    _usernameController.sink.add("");

    if (phone.isEmpty) {
      _phoneController.sink.addError("Enter phone number!");
      return false;
    }
    _phoneController.sink.add("");

    if (email.isEmpty) {
      _emailController.sink.addError("Enter email address!");
      return false;
    }
    _emailController.sink.add("");

    if (password.isEmpty || password.length <= 6) {
      _passController.sink.addError("Password must have at least 6 characters");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void signUp(String username, String email, String phone, String pass,
      Function onSuccess, Function(String) onError) {
    _firAuth.signUp(username, email, phone, pass, onSuccess, onError);
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose() {
    _usernameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}
