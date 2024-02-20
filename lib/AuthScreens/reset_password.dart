// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmnewPasswordController = TextEditingController();
  bool isPasswordVisible = false;

  bool isConfirmPasswordVisible = false;
  var confirmtext = 'false';
  bool isLoading = false;

  String checkPasswordsMatch() {
    String text1 = newPasswordController.text;
    String text2 = confirmnewPasswordController.text;

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * size.width / 100),
          child: Column(
            children: [
              HeightWidget(height: 3),
              AuthMessageTitle(
                size: size,
                title: 'Set up your new password',
                subtext: 'Please create a new password that you can remember',
                lastText: '',
              ),
              SizedBox(height: 3 * size.height / 100),
              PasswordTitleTextFieldTile(
                hint: 'Type your password',
                isPasswordVisible: isPasswordVisible,
                size: size,
                whichController: newPasswordController,
                title: 'New password',
                keyboardtype: TextInputType.text,
                onChanged: (value) {
                  checkPasswordsMatch();
                },
              ),
              SizedBox(height: 3 * size.height / 100),
              PasswordTitleTextFieldTile(
                hint: 'Confirm your password',
                isPasswordVisible: isConfirmPasswordVisible,
                size: size,
                whichController: confirmnewPasswordController,
                title: 'Confirm new Password',
                keyboardtype: TextInputType.text,
                onChanged: (value) {
                  checkPasswordsMatch();
                },
              ),
              HeightWidget(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OTPBoxes(size: size, pinController: pin1),
                  SizedBox(width: 1.5 * size.width / 100),
                  OTPBoxes(size: size, pinController: pin2),
                  SizedBox(width: 1.5 * size.width / 100),
                  OTPBoxes(size: size, pinController: pin3),
                  SizedBox(width: 1.5 * size.width / 100),
                  OTPBoxes(size: size, pinController: pin4),
                  SizedBox(width: 1.5 * size.width / 100),
                ],
              ),
              HeightWidget(height: 8),
              GeneralButton(
                isLoading: isLoading,
                size: size,
                buttonColor: AppColors.primaryColor,
                height: 7,
                text: 'Proceed',
                width: 90,
                onPressed: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
