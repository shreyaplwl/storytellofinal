import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:storify/authentication/auth_helper.dart';
import 'package:storify/authentication/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storify/languages/languages.dart';
import 'package:storify/notifier/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            //title: 'Storytello',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: MainScreen(),
          );
        },
      );
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc.data();
                  if (user['role'] == 'admin') {
                    return Languages();
                  } else {
                    return Languages();
                  }
                } else {
                  return Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
          return SignInScreen();
        });
  }
}
