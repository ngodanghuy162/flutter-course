import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/auth/auth_service.dart';

class VerifyView extends StatefulWidget {
  static const String routeName = '/verify';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => VerifyView());
  }

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  bool isSend = false;
  bool isVerify = false;
  int n = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 10),
      const Text('Verify email pls'),
      SizedBox(height: 10),
      TextButton(
          onPressed: () async {
            await AuthService.firebase().sendEmailVerify();
          },
          child: Text('Send verify')),
      SizedBox(height: 10),
      TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/verify',
              (Route<dynamic> route) => false, // Xóa tất cả các màn hình khác
            );
            final user = AuthService.firebase().currentUser;
            if (user?.isEmailVerified ?? false) {
              isVerify = true;
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/note',
                (Route<dynamic> route) => false, // Xóa tất cả các màn hình khác
              );
            } else {
              setState(() {
                n++;
              });
            }
          },
          child: Text('Da xac nhan xong?')),
      SizedBox(height: 10),
      TextButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (Route<dynamic> route) => false, // Xóa tất cả các màn hình khác
          );
        },
        child: Text("Da xac nhan,Go to login"),
      ),
      SizedBox(height: 10),
    ]);
  }
}
