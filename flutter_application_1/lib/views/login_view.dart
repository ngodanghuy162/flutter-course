// ignore_for_file: use_build_context_synchronously
import 'package:flutter_application_1/service/auth/auth_exception.dart';
import 'package:flutter_application_1/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dialog/showErrorDialog.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => LoginView());
  }

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _pass;
  @override
  void initState() {
    _email = TextEditingController();
    _pass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter email",
            ),
          ),
          TextField(
            controller: _pass,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Enter password',
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                await AuthService.firebase()
                    .logIn(email: _email.text, password: _pass.text);

                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/note',
                    (Route<dynamic> route) =>
                        false, // Xóa tất cả các màn hình khác
                  );
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/verify',
                    (Route<dynamic> route) =>
                        false, // Xóa tất cả các màn hình khác
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(context, "User not found");
              } on WrongPasswordAuthException {
                await showErrorDialog(context, "Wrong pass");
              } on GenericAuthException {
                await showErrorDialog(context, "Athentication Error");
              }
              // devtool.log(userCredential.toString());
              // on FirebaseAuthException catch (e) {
              //   if (e.code == 'user-not-found') {
              //     devtool.log('User not found !!!');
              //   } else if (e.code == 'wrong-password') {
              //     devtool.log('Wrong pass !!!! ');
              //   } else {
              //     devtool.log('Something happen ');
              //     devtool.log(e.code);
              //   }
              // }
            },
            child: Row(
              children: [Text('Login Here'), Icon(Icons.developer_mode)],
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/register',
                  (Route<dynamic> route) =>
                      false, // Xóa tất cả các màn hình khác
                );
              },
              child: Text("Don't have an account? Register Here!!!!"))
        ],
      ),
    );
  }
}
