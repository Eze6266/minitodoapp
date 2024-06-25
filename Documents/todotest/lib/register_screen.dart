// ignore_for_file: prefer_const_constructors

import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

import 'package:flutter/material.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/auth.dart';
import 'package:todotest/nav_bar.dart';
import 'package:todotest/reusables.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();
  String errorMessage = '';

  Future<void> createUserWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });
      await Auth().createUserWithEmailAndPassword(
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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
            child: Column(
              children: [
                Height(h: 2),
                GestureDetector(
                  onTap: () {
                    goBack(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      Width(w: 2),
                      kText(
                        txt: 'Back to Login',
                        size: 16,
                        weight: FontWeight.w500,
                        txtColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                Height(h: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: kText(
                    txt: 'Register',
                    size: 30,
                    weight: FontWeight.w700,
                    txtColor: Colors.black,
                  ),
                ),
                Height(h: 2),
                Align(
                  alignment: Alignment.centerLeft,
                  child: kText(
                    txt: 'And start taking notes',
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
                    whichController: nameController,
                    hint: 'Example: John Doe',
                    title: 'Full Name',
                    keyboardtype: TextInputType.text,
                    isloading: isLoading,
                  ),
                ),
                Height(h: 3),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
                  child: TitleTextFieldTile(
                    size: size,
                    whichController: emailController,
                    hint: 'Example: johndoe@gmail.com',
                    title: 'Email Address',
                    keyboardtype: TextInputType.emailAddress,
                    isloading: isLoading,
                  ),
                ),
                Height(h: 3),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
                  child: TitleTextFieldTile(
                    size: size,
                    whichController: pwdController,
                    hint: '**********',
                    title: 'Password',
                    keyboardtype: TextInputType.visiblePassword,
                    isloading: isLoading,
                  ),
                ),
                Height(h: 3),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
                  child: TitleTextFieldTile(
                    size: size,
                    whichController: confirmPwdController,
                    hint: '**********',
                    title: 'Retype Password',
                    keyboardtype: TextInputType.visiblePassword,
                    isloading: isLoading,
                  ),
                ),
                Height(h: 5),
                GenAuthBtn(
                  txt: 'Register',
                  btnColor: AppColors.primaryColor,
                  w: 90 * size.width / 100,
                  radius: 30,
                  txtColor: Colors.white,
                  txtWidth: 8 * size.width / 100,
                  txtBtnW: 6 * size.width / 100,
                  isLoading: isLoading,
                  onTap: () {
                    // goTo(context, NavBar(chosenmyIndex: 0));
                    createUserWithEmailAndPassword().then((value) {
                      if (errorMessage == '') {
                        FancySnackbar.showSnackbar(
                          context,
                          snackBarType: FancySnackBarType.success,
                          title: "Successs!",
                          message: "Registered succesfully",
                          duration: 5,
                          onCloseEvent: () {},
                        );
                        goTo(context, NavBar(chosenmyIndex: 0));
                      }
                      {}
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
                    GoogleFbChip(imgUrl: 'googlebtn'),
                    Width(w: 6),
                    GoogleFbChip(imgUrl: 'facebookbtn'),
                  ],
                ),
                Height(h: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kText(
                      txt: 'Already have an account?',
                      txtColor: Colors.grey,
                      weight: FontWeight.w500,
                      size: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        goBack(context);
                      },
                      child: kText(
                        txt: ' Login here',
                        txtColor: AppColors.primaryColor,
                        weight: FontWeight.w500,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                Height(h: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
