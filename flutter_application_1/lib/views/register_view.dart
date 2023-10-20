import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dialog/showErrorDialog.dart';
import 'package:flutter_application_1/service/auth/auth_exception.dart';
import 'package:flutter_application_1/service/auth/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String routeName = '/register';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => RegisterView());
  }

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _pass;
  String error = "";

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
      appBar: AppBar(title: Text('Register')),
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
                await AuthService.firebase().createUser(
                  email: _email.text,
                  password: _pass.text,
                );
                AuthService.firebase().sendEmailVerify();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/verify',
                  (Route<dynamic> route) =>
                      false, // Xóa tất cả các màn hình khác
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, "Email has been used");
              } on WeakPasswordAuthException {
                await showErrorDialog(context, "Week password.");
              } on InvalidEmailException {
                await showErrorDialog(context, "Invalid Email ");
              } on GenericAuthException {
                await showErrorDialog(context, "Failed to Register ");
              }
              ;
            },
            child: Row(
              children: [
                Text('Register Here'),
                Icon(Icons.developer_mode),
              ],
            ),
          ),
          if (error.isNotEmpty) Text(error),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (Route<dynamic> route) =>
                      false, // Xóa tất cả các màn hình khác
                );
              },
              child: Text('Have account? Login here!!!'))
        ],
      ),
    );
  }
}
