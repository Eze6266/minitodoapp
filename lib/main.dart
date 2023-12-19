// ignore_for_file: prefer_const_constructors

import 'package:datahub/Providers/data_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarBrightness: Brightness.light,
      ),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<DataProvider>(
            create: (context) => DataProvider(),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DATAHUB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NavBar(chosenmyIndex: 0),
    );
  }
}
