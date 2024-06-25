// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/login_screen.dart';
import 'package:todotest/reusables.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            Height(h: 12),
            Center(
              child: Image.asset('assets/authman.png'),
            ),
            Height(h: 5),
            Text(
              'Jot Down anything you want to\nachieve, today or in the future.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        floatingActionButton: GenAuthBtn(
          txtColor: AppColors.primaryColor,
          txt: 'Let\'s Get Started',
          radius: 40,
          w: 90 * size.width / 100,
          onTap: () {
            goTo(context, LoginScreen());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
