// ignore_for_file: prefer_const_constructors

import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/transaction_pin.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utilities/reusables.dart';

class PrepaidPostpaidChip extends StatelessWidget {
  PrepaidPostpaidChip({
    super.key,
    required this.size,
    required this.onTap,
    required this.type,
    required this.chipColor,
    required this.textColor,
  });

  final Size size;
  String type;
  Function() onTap;
  Color chipColor, textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5 * size.height / 100,
        width: 40 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: chipColor,
        ),
        child: Center(
          child: PoppinsCustText(
            color: textColor,
            size: 16.0,
            text: type,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ChooseElectricType {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet(BuildContext context) {
    // var dataType = Provider.of<DataProvider>(context, listen: false);

    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              // height: 80 * size.height / 100,
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: 70 * size.height / 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 0.5 * size.height / 100,
                        width: 15 * size.width / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey,
                        ),
                      ),
                      HeightWidget(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PoppinsCustText(
                            color: Colors.black,
                            size: 16.0,
                            text: 'Choose Electricity Provider',
                            weight: FontWeight.w600,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      HeightWidget(height: 1.5),
                      Divider(),
                      HeightWidget(height: 2),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Ikeja Electric Payment - IKEDC',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Eko Electric Payment - EKEDC',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Abuja Electricity Distribution - AEDC',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Kano Electric - KEDC',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'PortHarcourt Electric - PHED',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Jos Electric - JED',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Kaduna Electric - KAEDCO',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Enugu Electric - EEDC',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Ibadan Electricity Distribution Company - IBEDC',
                      ),
                      HeightWidget(height: 1),
                      SheetTiles(
                        size: size,
                        onTap: () {
                          print('pressed');
                          Navigator.pop(context);
                          // dataType.seldataType = 1;
                          // dataType.callDataNotifier();
                          setState(() {});
                        },
                        selected: true,
                        type: 'Benin Electricity - BEDC',
                      ),
                      HeightWidget(height: 2),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ShowElectricSummary {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet(BuildContext context, String which) {
    // var dataType = Provider.of<DataProvider>(context, listen: false);
    bool isLoading = false;
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              // height: 80 * size.height / 100,
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: 56 * size.height / 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 0.5 * size.height / 100,
                        width: 15 * size.width / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey,
                        ),
                      ),
                      HeightWidget(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PoppinsCustText(
                            color: Colors.black,
                            size: 16.0,
                            text: 'Transaction Summary',
                            weight: FontWeight.w600,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      HeightWidget(height: 1.5),
                      Divider(),
                      HeightWidget(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service Provider',
                            style: GoogleFonts.acme(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color.fromARGB(255, 103, 102, 102),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 4 * size.height / 100,
                                width: 9 * size.width / 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/kaed.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                'KAED',
                                style: GoogleFonts.abel(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Phone Number',
                        valueText: '07067581951',
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Meter type',
                        valueText: 'Prepaid',
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Meter number',
                        valueText: '998373635627',
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Verified name',
                        valueText: 'Emmanuel Eze',
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Amount To Pay',
                        valueText: 'N3,000',
                      ),
                      HeightWidget(height: 8),
                      GeneralButton(
                        size: size,
                        buttonColor: AppColors.primaryColor,
                        height: 7,
                        text: 'Proceed',
                        width: 90,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TransactionPinScreen(which: which),
                            ),
                          );
                          // ShowDataSummary().showBottomSheet(context);
                        },
                        isLoading: isLoading,
                      ),
                      HeightWidget(height: 2),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
