// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:datahub/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUp2Screen extends StatefulWidget {
  SignUp2Screen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phone,
  });
  var username, firstName, lastName, phone;
  @override
  State<SignUp2Screen> createState() => _SignUp2ScreenState();
}

class _SignUp2ScreenState extends State<SignUp2Screen> {
  String _validationResult = '';

  bool _validateEmail(String email) {
    // Basic email format validation using a regular expression
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  void _validateAndShowResult() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _validationResult = 'Email cannot be empty';
      });
    } else if (!_validateEmail(email)) {
      setState(() {
        _validationResult = 'Invalid email format';
      });
    } else {
      setState(() {
        _validationResult = 'Email is valid';
      });
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isconfirmpasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;
  var confirmtext = 'false';
  String checkPasswordsMatch() {
    String text1 = passwordController.text;
    String text2 = confirmpasswordController.text;

    if (text1 == text2) {
      confirmtext = 'true';

      setState(() {});
      return confirmtext;
    } else {
      confirmtext = 'false';

      setState(() {});
      return confirmtext;
    }
  }

  bool emailError = false;
  bool pwdError = false;
  bool pwdConfrmErroe = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var regUserApi = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).regUserIsLoading;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 30, top: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 10, right: 10, top: 1 * size.height / 100),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 3 * size.height / 100),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                  child: TitleTextFieldTile(
                    size: size,
                    whichController: emailController,
                    hint: 'Enter email',
                    title: 'Email',
                    keyboardtype: TextInputType.emailAddress,
                    isloading: isLoading,
                    onChanged: (value) {
                      _validateAndShowResult();
                      if (_validationResult == 'Email is valid') {
                        setState(() {
                          emailError = false;
                        });
                      } else {
                        setState(() {
                          emailError = true;
                        });
                      }
                    },
                  ),
                ),
                emailError
                    ? Padding(
                        padding: EdgeInsets.only(left: 3 * size.width / 100),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'enter a valid email',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 3 * size.height / 100),
                PasswordTitleTextFieldTile(
                  hint: 'Type your password',
                  isPasswordVisible: isPasswordVisible,
                  size: size,
                  whichController: passwordController,
                  title: 'Password',
                  keyboardtype: TextInputType.text,
                  onChanged: (value) {
                    if (value.length < 6) {
                      setState(() {
                        pwdError = true;
                      });
                    } else {
                      setState(() {
                        pwdError = false;
                        checkPasswordsMatch();
                      });
                    }
                  },
                ),
                pwdError
                    ? Padding(
                        padding: EdgeInsets.only(left: 3 * size.width / 100),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'password must be greater than 6',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 3 * size.height / 100),
                PasswordTitleTextFieldTile(
                  hint: 'Confirm your password',
                  isPasswordVisible: isConfirmPasswordVisible,
                  size: size,
                  whichController: confirmpasswordController,
                  title: 'Confirm Password',
                  keyboardtype: TextInputType.text,
                  onChanged: (value) {
                    if (value.length < 6) {
                      setState(() {
                        pwdConfrmErroe = true;
                      });
                    } else {
                      setState(() {
                        pwdConfrmErroe = false;
                        checkPasswordsMatch();
                      });
                    }
                  },
                ),
                pwdConfrmErroe
                    ? Padding(
                        padding: EdgeInsets.only(left: 3 * size.width / 100),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'password must be greater than 6',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 6 * size.height / 100),
                GeneralButton(
                  size: size,
                  buttonColor: pwdError ||
                          pwdConfrmErroe ||
                          passwordController.text.isEmpty ||
                          confirmpasswordController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          emailError
                      ? Colors.grey
                      : AppColors.primaryColor,
                  height: 7,
                  text: 'Sign Up',
                  width: 90,
                  onPressed:
                      pwdError || pwdConfrmErroe || emailController.text.isEmpty
                          ? () {}
                          : () async {
                              if (confirmtext == 'true') {
                                await regUserApi
                                    .registerUser(
                                  username: widget.firstName,
                                  firstName: widget.firstName,
                                  lastName: widget.lastName,
                                  phone: widget.phone,
                                  email: emailController.text,
                                  password: passwordController.text,
                                )
                                    .then((value) {
                                  if (value == 'success') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NavBar(chosenmyIndex: 0),
                                      ),
                                    );
                                  } else {
                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.error(
                                        message: regUserApi.regUserMessage,
                                      ),
                                      dismissType: DismissType.onSwipe,
                                    );
                                  }
                                });
                              } else {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: 'Passwords don\'t match',
                                  ),
                                  dismissType: DismissType.onSwipe,
                                );
                              }
                            },
                  isLoading: isLoading,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
