// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/ElectrictyScreens/electricty_reusables.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController meterController = TextEditingController();
  TextEditingController verifiedNameController = TextEditingController();
  bool prepaid = true;
  bool postpaid = false;
  bool isLoading = false;
  bool idVerified = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              child: Container(
                height: 3 * size.height / 100,
                width: 6 * size.width / 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 1 * size.width / 100),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
            WidthWidget(width: 35),
            Text(
              'Electricity',
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
              Center(
                child: Shimmer.fromColors(
                  period: Duration(seconds: 3),
                  baseColor: Colors.red,
                  highlightColor: Color(0xffFFD700),
                  child: Text(
                    'PAY ELECTRICITY BILL',
                    style: GoogleFonts.acme(
                      textStyle: TextStyle(
                        color: Color(0xffFFD700),
                        // color: Color.fromARGB(255, 198, 204, 213),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              HeightWidget(height: 4),
              DropdownAndTitle(
                size: size,
                text: 'Select Electricity Type',
                title: 'Select Provider',
                onTap: () {
                  ChooseElectricType().showBottomSheet(context);
                },
              ),
              HeightWidget(height: 3),
              Padding(
                padding: EdgeInsets.only(left: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PoppinsCustText(
                    color: Colors.black,
                    size: 12.0,
                    text: 'Select Type',
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              HeightWidget(height: 0.6),
              Container(
                height: 7 * size.height / 100,
                width: 90 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PrepaidPostpaidChip(
                      size: size,
                      chipColor: prepaid
                          ? AppColors.primaryColor
                          : Color.fromARGB(255, 205, 202, 202),
                      type: 'PREPAID',
                      textColor: prepaid ? Colors.white : Colors.grey,
                      onTap: () {
                        setState(() {
                          prepaid = true;
                          postpaid = false;
                        });
                      },
                    ),
                    PrepaidPostpaidChip(
                      size: size,
                      chipColor: postpaid
                          ? AppColors.primaryColor
                          : Color.fromARGB(255, 205, 202, 202),
                      type: 'POSTPAID',
                      textColor: postpaid ? Colors.white : Colors.grey,
                      onTap: () {
                        setState(() {
                          prepaid = false;
                          postpaid = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              HeightWidget(height: 3),
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
              HeightWidget(height: 3),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2 * size.width / 100,
                ),
                child: TitleTextFieldTile(
                  size: size,
                  whichController: meterController,
                  hint: 'Enter meter number',
                  title: 'Meter Number',
                  keyboardtype: TextInputType.number,
                  isloading: isLoading,
                ),
              ),
              HeightWidget(height: 0.5),
              VerificationRow(
                size: size,
                idVerified: idVerified,
                onTap: () {
                  setState(() {
                    idVerified = true;
                    verifiedNameController.text = 'Emmanuel Ezejiobi';
                  });
                },
              ),
              HeightWidget(height: 3),
              idVerified
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2 * size.width / 100,
                      ),
                      child: TitleTextFieldTile(
                        size: size,
                        whichController: verifiedNameController,
                        hint: 'Enter phone number',
                        title: 'Verified Name',
                        keyboardtype: TextInputType.number,
                        isloading: true,
                      ),
                    )
                  : SizedBox.shrink(),
              HeightWidget(height: 3),
              idVerified
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2 * size.width / 100,
                      ),
                      child: TitleTextFieldTile(
                        size: size,
                        whichController: amountController,
                        hint: 'Enter amount',
                        title: 'Amount',
                        keyboardtype: TextInputType.number,
                        isloading: isLoading,
                      ),
                    )
                  : SizedBox.shrink(),
              idVerified
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * size.width / 100),
                      child: BalanceAndFundRow(),
                    )
                  : SizedBox.shrink(),
              HeightWidget(height: 20),
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
          ShowElectricSummary().showBottomSheet(context, '4');
        },
        isLoading: isLoading,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
