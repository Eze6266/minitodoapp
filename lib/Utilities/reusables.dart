// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
                  borderRadius: BorderRadius.circular(16),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
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
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
