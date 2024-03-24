// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:datahub/HomeScreens/home_reusables.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List types = [
    'Joseph',
    'Manuel',
    'Premium',
    'Glo',
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
    '10:30am, 05 Dec 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
  ];
  List getData = [];
  List templist = [];
  void filterItems(String query) {
    // Clear the previous filtered items
    filteredItems.clear();

    // Filter items based on the query
    for (var item in types) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        filteredItems.add(item);
      }
    }

    setState(() {}); // Trigger a rebuild to update the UI
  }

  List<String> filteredItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItems = List.from(types);
  }

  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Transactions',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            HeightWidget(height: 1),
            SizedBox(
              width: 100 * size.width / 100,
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    filterItems(value);
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xffe2e2e2), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xffe2e2e2), width: 1.0),
                  ),
                  hintText: 'Search transaction',
                  hintStyle: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff979797),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            HeightWidget(height: 2),
            Expanded(
              child: ListView.separated(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return TransactionsTile(
                    amount: amount[index],
                    date: dates[index],
                    img: imgs[index],
                    subs: subs[index],
                    title: filteredItems[index],
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
    );
  }
}
