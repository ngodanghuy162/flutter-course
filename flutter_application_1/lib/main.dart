import 'package:flutter_application_1/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/app_router.dart';
import 'views/allviews.dart';
// import 'dart:developer' as devtool show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BeginPage(),
      onGenerateRoute: AppRoute.onGenerateRoutes,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BeginPage();
  }
}

class BeginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthService.firebase().initalize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // if (user != null) {
              //   if (user.emailVerified) {
              //     print("Ok ban da verify");
              //     return NotesView();
              //   } else {
              //     return VerifyView();
              //   }
              // } else {
              //   return RegisterView();
              // }
              return RegisterView();
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
