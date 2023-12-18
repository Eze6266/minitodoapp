// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/home_reusables.dart';
import 'package:datahub/Providers/data_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();
  bool mtn = false;
  bool airtel = false;
  bool glo = false;
  bool etisalat = false;
  bool isLoading = false;
  bool _showShimmer = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        _showShimmer = !_showShimmer;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dataType = Provider.of<DataProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            WidthWidget(width: 26),
            Text(
              'Buy Data Bundle',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              HeightWidget(height: 2),
              SizedBox(
                height: 10 * size.height / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DataProvidersBox(
                      size: size,
                      colorType: Colors.yellow,
                      provider: 'MTN',
                      imgUrl: 'tn.jpg',
                      clicked: () {
                        setState(() {
                          mtn = true;
                          airtel = false;
                          glo = false;
                          etisalat = false;
                        });
                      },
                      selected: mtn,
                    ),
                    DataProvidersBox(
                      size: size,
                      colorType: Colors.red,
                      provider: 'Airtel',
                      imgUrl: 'tel.jpg',
                      clicked: () {
                        setState(() {
                          mtn = false;
                          airtel = true;
                          glo = false;
                          etisalat = false;
                        });
                      },
                      selected: airtel,
                    ),
                    DataProvidersBox(
                      size: size,
                      colorType: Colors.green,
                      provider: 'Glo',
                      imgUrl: 'lo.png',
                      clicked: () {
                        setState(() {
                          mtn = false;
                          airtel = false;
                          glo = true;
                          etisalat = false;
                        });
                      },
                      selected: glo,
                    ),
                    DataProvidersBox(
                      size: size,
                      colorType: Colors.green,
                      provider: 'Etisalat',
                      imgUrl: 'etisalat.png',
                      clicked: () {
                        setState(() {
                          mtn = false;
                          airtel = false;
                          glo = false;
                          etisalat = true;
                        });
                      },
                      selected: etisalat,
                    ),
                  ],
                ),
              ),
              HeightWidget(height: 2),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2 * size.width / 100,
                ),
                child: TitleTextFieldTile(
                  size: size,
                  whichController: phoneController,
                  hint: 'Enter phone number',
                  title: 'Phone Number',
                  keyboardtype: TextInputType.number,
                  isloading: isLoading,
                ),
              ),
              HeightWidget(height: 2),
              DropdownAndTitle(
                size: size,
                text: dataType.seldataType == 1
                    ? 'SME'
                    : dataType.seldataType == 2
                        ? 'Normal Data'
                        : dataType.seldataType == 3
                            ? 'Enterprise Data'
                            : 'Select Data Type',
                title: 'Choose Data Type',
                onTap: () {
                  ChooseDataType().showBottomSheet(context);
                },
              ),
              HeightWidget(height: 3),
              DropdownAndTitle(
                size: size,
                text: dataType.seldataPlan == 1
                    ? 'N200 200MB - 3 days'
                    : dataType.seldataPlan == 2
                        ? 'N2,000 4GB - 30 days'
                        : dataType.seldataPlan == 3
                            ? 'N2,500 6GB - 30 days'
                            : 'Select Data Plan',
                title: 'Choose Data Plan',
                onTap: () {
                  ChooseDataPlan().showBottomSheet(context);
                },
              ),
              HeightWidget(height: 4),
              Center(
                child: PoppinsCustText(
                  color: Colors.black,
                  size: 14.0,
                  text: 'TOTAL AMOUNT ',
                  weight: FontWeight.w500,
                ),
              ),
              HeightWidget(height: 0.5),
              Container(
                height: 7 * size.height / 100,
                width: 90 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 216, 215, 215),
                ),
                child: Center(
                  child: PoppinsCustText(
                    color: Colors.black,
                    size: 20.0,
                    text: 'N2,500',
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              HeightWidget(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: GeneralButton(
        size: size,
        buttonColor: AppColors.primaryColor,
        height: 7,
        text: 'Continue',
        width: 90,
        onPressed: () {
          ShowDataSummary().showBottomSheet(context);
        },
        isLoading: isLoading,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
