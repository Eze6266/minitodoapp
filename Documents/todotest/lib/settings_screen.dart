// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/reusables.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                Center(
                  child: kText(
                    txt: 'Settings',
                    size: 17,
                    weight: FontWeight.w500,
                    txtColor: Colors.black,
                  ),
                ),
                Height(h: 1.5),
                Divider(),
                Height(h: 1.5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: kText(
                    txt: 'Michael Antonio',
                    size: 20,
                    weight: FontWeight.w700,
                    txtColor: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.mail_outline,
                      color: Colors.grey,
                      size: 22,
                    ),
                    Width(w: 2),
                    kText(
                      txt: 'eze6266@gmail.com',
                      size: 12,
                      weight: FontWeight.w500,
                      txtColor: Colors.grey,
                    ),
                  ],
                ),
                Height(h: 2),
                Divider(),
                Height(h: 2),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog();
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 24,
                      ),
                      Width(w: 3),
                      kText(
                        txt: 'Log Out',
                        txtColor: Colors.red,
                        size: 18,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
