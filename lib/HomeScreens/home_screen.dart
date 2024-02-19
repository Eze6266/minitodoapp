// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:datahub/HomeScreens/BuyAirtimeScreens/airtime_screen.dart';
import 'package:datahub/HomeScreens/CableTvScreens/cable_tv_screen.dart';
import 'package:datahub/HomeScreens/DataScreens/data_screens.dart';
import 'package:datahub/HomeScreens/ElectrictyScreens/electricity_screen.dart';
import 'package:datahub/HomeScreens/NotificationScreens/notification_screen.dart';
import 'package:datahub/HomeScreens/home_reusables.dart';
import 'package:datahub/HomeScreens/top_up_screen.dart';
import 'package:datahub/TransactionsScreens/transactions_screen.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:datahub/navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_scroll/text_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool eye = false;
  String greeting = 'Good Day';
  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      setState(() {});
      return greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      setState(() {});
      return greeting = 'Good Afternoon';
    } else {
      setState(() {});
      return greeting = 'Good Evening';
    }
  }

// 🙀😱😲
  List types = [
    'Joseph',
    'Manuel',
    'Premium',
    'Glo',
  ];
  List subs = [
    'Electricity',
    'Topup',
    'DSTV',
    'Data',
  ];
  List amount = [
    '-10,000',
    '+25,000',
    '-3,000',
    '-1,800',
  ];
  List imgs = [
    'assets/images/elek.png',
    'assets/images/pig.png',
    'assets/images/pig.png',
    'assets/images/tv.png',
  ];
  List color = [
    Colors.red,
    Colors.green,
    Colors.green,
    Colors.red,
  ];
  List dates = [
    '10:30am, 05 Dec 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
  ];
  @override
  Widget build(BuildContext context) {
    getGreeting();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              HeightWidget(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xfffbbc05),
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      WidthWidget(width: 1),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PoppinsCustText(
                            color: Colors.black,
                            size: 14.0,
                            text: '$greeting Manuel',
                            weight: FontWeight.w400,
                          ),
                          HeightWidget(height: 0.3),
                          PoppinsCustText(
                            color: Color(0xff8c8b90),
                            size: 10.0,
                            text: 'What do you want to do today?',
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ),
                      );
                    },
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              HeightWidget(height: 2),
              HomeWalletCard(
                size: size,
                eye: eye,
                balance: '450,000',
                onTap: () {
                  setState(() {
                    eye = !eye;
                  });
                },
                topup: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpAccountScreen(),
                    ),
                  );
                },
                transClick: () {
                  NavBar(chosenmyIndex: 2);
                },
              ),
              HeightWidget(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Services',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              HeightWidget(height: 0.1),
              Container(
                padding: EdgeInsets.all(8),
                height: 24 * size.height / 100,
                width: 95 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 9, 90, 155),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ServicesBoxes(
                          size: size,
                          service: 'Airtime Top-up',
                          iconType: Icons.phone_outlined,
                          boxColor: Color.fromARGB(255, 127, 181, 226),
                          iconColor: Colors.pink,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AirtimeScreens(),
                              ),
                            );
                          },
                        ),
                        ServicesBoxes(
                          size: size,
                          service: 'Data Bundle',
                          iconType: Icons.wifi,
                          boxColor: Colors.green.shade100,
                          iconColor: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataScreen(),
                              ),
                            );
                          },
                        ),
                        ServicesBoxes(
                          size: size,
                          service: 'Cable TV',
                          iconType: Icons.live_tv_outlined,
                          boxColor: Colors.orange.shade100,
                          iconColor: Colors.orange,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CableTvScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    HeightWidget(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ServicesBoxes(
                          size: size,
                          service: 'Electricity',
                          iconType: Icons.tips_and_updates_outlined,
                          boxColor: Colors.purple.shade100,
                          iconColor: Colors.purple,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ElectricityScreen(),
                              ),
                            );
                          },
                        ),
                        ServicesBoxes(
                          size: size,
                          service: 'Bulk SMS',
                          iconType: Icons.contact_mail_outlined,
                          boxColor: Colors.indigo.shade100,
                          iconColor: Colors.indigo,
                          onTap: () {},
                        ),
                        ServicesBoxes(
                          size: size,
                          service: 'Gift Cards',
                          iconType: Icons.request_quote_outlined,
                          boxColor: Colors.brown.shade100,
                          iconColor: Colors.brown,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              HeightWidget(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavBar(chosenmyIndex: 2),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'See more',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              HeightWidget(height: 0.2),
              Expanded(
                child: ListView.separated(
                  itemCount: types.length,
                  itemBuilder: (context, index) {
                    return TransactionsTile(
                      amount: amount[index],
                      date: dates[index],
                      img: imgs[index],
                      subs: subs[index],
                      title: types[index],
                      coloType: color[index],
                      size: size,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.grey);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
