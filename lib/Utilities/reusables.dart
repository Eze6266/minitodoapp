// ignore_for_file: prefer_const_constructors

import 'package:datahub/Utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeightWidget extends StatelessWidget {
  HeightWidget({
    super.key,
    required this.height,
  });
  var height;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: height * size.height / 100);
  }
}

class WidthWidget extends StatelessWidget {
  WidthWidget({
    super.key,
    required this.width,
  });
  var width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(width: width * size.width / 100);
  }
}

class PoppinsCustText extends StatelessWidget {
  PoppinsCustText({
    super.key,
    required this.color,
    required this.size,
    required this.text,
    required this.weight,
  });
  String text;
  Color color;
  var size;
  FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

class CustomPopAppBar extends StatelessWidget {
  CustomPopAppBar({
    super.key,
    required this.pad,
    required this.text,
  });
  String text;
  var pad;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        WidthWidget(width: pad),
        Text(
          '$text',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class TitleTextFieldTile extends StatelessWidget {
  TitleTextFieldTile({
    super.key,
    required this.size,
    required this.whichController,
    required this.hint,
    required this.title,
    required this.keyboardtype,
    this.onChanged,
    required this.isloading,
  });

  final Size size;
  final TextEditingController whichController;
  String hint;
  String title;
  TextInputType keyboardtype;
  void Function(String)? onChanged;
  bool isloading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1 * size.width / 100),
            child: Align(
              alignment: Alignment.centerLeft,
              child: PoppinsCustText(
                color: Colors.black,
                size: 12.0,
                text: title,
                weight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 0.5 * size.height / 100),
          SizedBox(
            width: 90 * size.width / 100,
            height: 7 * size.height / 100,
            child: TextFormField(
              onChanged: onChanged,
              enabled: isloading ? false : true,
              showCursor: true,
              cursorColor: Colors.grey,
              controller: whichController,
              keyboardType: keyboardtype,
              decoration: InputDecoration(
                fillColor: Color(0xfff8f8f8),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff92a4b5),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(),
                ),
                hintText: '$hint',
                hintStyle: TextStyle(
                  color: Color(0xffc2c4cf),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff92a4b5),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FundingTipTag extends StatelessWidget {
  const FundingTipTag({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
        height: 7 * size.height / 100,
        width: 90 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 148, 205, 251),
              radius: 18,
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
            WidthWidget(width: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PoppinsCustText(
                  color: Colors.white,
                  size: 14.0,
                  text: 'Funding Tip',
                  weight: FontWeight.w500,
                ),
                SizedBox(
                  width: 70 * size.width / 100,
                  child: PoppinsCustText(
                    color: Colors.white,
                    size: 10.0,
                    text:
                        'Transfer to any of the virtual account numbers below to fund your account',
                    weight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountNumberCard extends StatelessWidget {
  AccountNumberCard({
    super.key,
    required this.size,
    required this.accName,
    required this.accNumber,
    required this.bankName,
    required this.gradColor,
    required this.gradColor2,
    required this.onTap,
  });

  final Size size;

  String accNumber, accName, bankName;
  Color gradColor, gradColor2;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 18 * size.height / 100,
      width: 90 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // color: Colors.orange,
        gradient: LinearGradient(
          colors: [gradColor, gradColor2], // Define your gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PoppinsCustText(
                color: Colors.white,
                size: 13.0,
                text: 'Virtual Account',
                weight: FontWeight.w400,
              ),
              PoppinsCustText(
                color: Colors.white,
                size: 14.0,
                text: '$bankName',
                weight: FontWeight.w500,
              ),
            ],
          ),
          HeightWidget(height: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(5),
                height: 4.5 * size.height / 100,
                width: 35 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$accNumber',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WidthWidget(width: 2),
                    SvgPicture.asset(
                      'assets/icons/copy.svg',
                      color: Colors.white,
                      height: 2 * size.height / 100,
                      width: 3 * size.width / 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
          HeightWidget(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PoppinsCustText(
                color: Colors.white,
                size: 13.0,
                text: '$accName',
                weight: FontWeight.w400,
              ),
              PoppinsCustText(
                color: Colors.white,
                size: 14.0,
                text: 'N50 Charge Applied',
                weight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GeneralButton extends StatelessWidget {
  GeneralButton({
    super.key,
    required this.size,
    required this.buttonColor,
    required this.height,
    required this.text,
    required this.width,
    required this.onPressed,
    required this.isLoading,
  });

  final Size size;
  String text;
  Color buttonColor;
  int width;
  int height;
  final VoidCallback? onPressed;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height * size.height / 100,
        width: width * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: buttonColor,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 2 * size.height / 100,
                  width: 4 * size.width / 100,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : PoppinsCustText(
                  color: Colors.white,
                  size: 16.0,
                  text: text,
                  weight: FontWeight.w400,
                ),
        ),
      ),
    );
  }
}
