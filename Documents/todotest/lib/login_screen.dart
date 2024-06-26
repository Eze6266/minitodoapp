// ignore_for_file: prefer_const_constructors

import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/auth.dart';
import 'package:todotest/nav_bar.dart';
import 'package:todotest/register_screen.dart';
import 'package:todotest/reusables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DateTime currentTime = DateTime.now();
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  String errorMessage = '';

  Future<void> signInWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      await Auth().signInWithEmailAndPassword(
          email: emailController.text, password: pwdController.text);
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      setState(() {
        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Error!",
          message: "${e.message}",
          duration: 5,
          onCloseEvent: () {},
        );
        errorMessage = e.message!;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      await Auth().signInWithGoogle();
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      setState(() {
        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Error!",
          message: "${e.message}",
          duration: 5,
          onCloseEvent: () {},
        );
        errorMessage = e.message!;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> signInWithFacebook() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      await Auth().signInWithFacebook();
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      setState(() {
        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.error,
          title: "Error!",
          message: "${e.message}",
          duration: 5,
          onCloseEvent: () {},
        );
        errorMessage = e.message!;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(currentTime);
        final isExitWarning = difference >= Duration(seconds: 2);
        currentTime = DateTime.now();
        if (isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 14);
          return false;
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return Future.value(false);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
              child: Column(
                children: [
                  Height(h: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: kText(
                      txt: 'Let\'s Login',
                      size: 30,
                      weight: FontWeight.w700,
                      txtColor: Colors.black,
                    ),
                  ),
                  Height(h: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: kText(
                      txt: 'And notes your idea',
                      size: 18,
                      weight: FontWeight.w400,
                      txtColor: Colors.grey,
                    ),
                  ),
                  Height(h: 5),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
                    child: TitleTextFieldTile(
                      size: size,
                      whichController: emailController,
                      hint: 'Example: johndoe@gmail.com',
                      title: 'Email Address',
                      keyboardtype: TextInputType.text,
                      isloading: isLoading,
                    ),
                  ),
                  Height(h: 5),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
                    child: TitleTextFieldTile(
                      size: size,
                      whichController: pwdController,
                      hint: '*********',
                      title: 'Password',
                      keyboardtype: TextInputType.text,
                      isloading: isLoading,
                    ),
                  ),
                  Height(h: 2),
                  Padding(
                    padding: EdgeInsets.only(left: 3 * size.width / 100),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Height(h: 5),
                  GenAuthBtn(
                    txt: 'Login',
                    btnColor: AppColors.primaryColor,
                    w: 90 * size.width / 100,
                    radius: 30,
                    isLoading: isLoading,
                    txtColor: Colors.white,
                    txtWidth: 9 * size.width / 100,
                    txtBtnW: 7 * size.width / 100,
                    onTap: () {
                      signInWithEmailAndPassword().then((value) {
                        if (errorMessage == '') {
                          goTo(context, NavBar(chosenmyIndex: 0));
                        } else {
                          print('erororororororor $errorMessage');
                        }
                      });
                    },
                  ),
                  Height(h: 2),
                  Row(
                    children: [
                      Container(
                        height: 0.5,
                        width: 43 * size.width / 100,
                        color: Colors.grey,
                      ),
                      kText(
                        txt: 'Or',
                        txtColor: Colors.grey,
                        weight: FontWeight.w400,
                        size: 16,
                      ),
                      Container(
                        height: 0.5,
                        width: 43 * size.width / 100,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Height(h: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          signInWithGoogle();
                        },
                        child: GoogleFbChip(imgUrl: 'googlebtn'),
                      ),
                      Width(w: 6),
                      GestureDetector(
                        onTap: () {
                          signInWithFacebook();
                        },
                        child: GoogleFbChip(imgUrl: 'facebookbtn'),
                      ),
                    ],
                  ),
                  Height(h: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kText(
                        txt: 'Don\'t have any account?',
                        txtColor: Colors.grey,
                        weight: FontWeight.w500,
                        size: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          goTo(context, RegisterScreen());
                        },
                        child: kText(
                          txt: ' Register here',
                          txtColor: AppColors.primaryColor,
                          weight: FontWeight.w500,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
