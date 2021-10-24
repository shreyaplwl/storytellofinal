import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storify/authentication/auth_helper.dart';
import 'package:storify/authentication/custom_colors.dart';
import 'package:storify/authentication/sign_in_screen.dart';
import 'package:storify/authentication/authentication.dart';
import 'package:storify/languages/languages.dart';
import 'package:storify/authentication/app_bar_title.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key key, @required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool _isEmailVerified;
  User _user;

  bool _verificationEmailBeingSent = false;
  bool _isSigningOut = false;
  TextEditingController username = new TextEditingController();

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    _isEmailVerified = _user.emailVerified;

    UserHelper.saveUser(_user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: AppBarTitle(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          bottom: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            ClipOval(
              child: Material(
                color: CustomColors.firebaseGrey.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: CustomColors.firebaseGrey,
                  ),
                ),
              ),
            ),
            Text(
              'Profile',
              style: TextStyle(
                color: CustomColors.firebaseAmber,
                fontSize: 26,
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Name:  ",
                        style: TextStyle(
                          color: CustomColors.firebaseYellow,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget._user.displayName,
                        style: TextStyle(
                          color: CustomColors.firebaseYellow,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        "Email:  ",
                        style: TextStyle(
                          color: CustomColors.firebaseYellow,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget._user.email,
                        style: TextStyle(
                          color: CustomColors.firebaseYellow,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            SizedBox(height: 30.0),
            _isEmailVerified
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.greenAccent.withOpacity(0.6),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.check,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Email is verified',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.redAccent.withOpacity(0.8),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Email is not verified',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 8.0),
            Visibility(
              visible: !_isEmailVerified,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _verificationEmailBeingSent
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            CustomColors.firebaseGrey,
                          ),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              CustomColors.firebaseGrey,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _verificationEmailBeingSent = true;
                            });
                            await _user.sendEmailVerification();
                            setState(() {
                              _verificationEmailBeingSent = false;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.firebaseNavy,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(width: 16.0),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      User user = await Authentication.refreshUser(_user);

                      if (user != null) {
                        setState(() {
                          _user = user;
                          _isEmailVerified = user.emailVerified;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'You are now signed in',
              style: TextStyle(
                  color: CustomColors.firebaseGrey.withOpacity(0.8),
                  fontSize: 14,
                  letterSpacing: 0.2),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xFFD3B5E5),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Languages(),
              )),
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  'Home Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            _isSigningOut
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.redAccent,
                    ),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.redAccent,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _isSigningOut = false;
                      });
                      Navigator.of(context)
                          .pushReplacement(_routeToSignInScreen());
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
