// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/enter_todo_title.dart';
import 'package:todotest/home_screen.dart';
import 'package:todotest/settings_screen.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key, required this.chosenmyIndex});
  final int chosenmyIndex;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int myIndex = 0;
  bool isLoggedIn = false;
  DateTime currentTime = DateTime.now();
  List<Task> tasks = [];
  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();
    myIndex = widget.chosenmyIndex;
    widgetList = [
      HomeScreen(),
      SettingsScreen(),
    ];
  }

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
      widgetList[0] = HomeScreen(); // Update the HomeScreen with the new tasks
    });
  }

  void navigateToEnterTodoTitle() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnterTodoTitle(),
      ),
    );
    if (result != null) {
      addTask(result);
    }
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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
          statusBarBrightness: Brightness.light,
        ),
        child: Scaffold(
          bottomNavigationBar: Container(
            child: BottomAppBar(
              padding: EdgeInsets.zero,
              elevation: 0, // remove elevation
              notchMargin: 1.0,
              child: BottomNavigationBar(
                selectedLabelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: Color(0xff626d7d),
                unselectedLabelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Color(0xff626d7d),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                onTap: (index) {
                  setState(() {
                    myIndex = index;
                  });
                },
                currentIndex: myIndex,
                items: [
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.home,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                    label: 'Home',
                    icon: Icon(
                      Icons.home,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.settings,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                    label: 'Settings',
                    icon: Icon(
                      Icons.settings_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: navigateToEnterTodoTitle,
            child: Container(
              height: 7 * size.height / 100,
              width: 15 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.primaryColor,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: widgetList[myIndex],
        ),
      ),
    );
  }
}
