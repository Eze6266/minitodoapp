// ignore_for_file: prefer_const_constructors
import 'package:todotest/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todotest/auth.dart';
import 'package:todotest/login_screen.dart';

class Height extends StatelessWidget {
  Height({
    super.key,
    required this.h,
  });
  double h;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: h * size.height / 100);
  }
}

class Width extends StatelessWidget {
  Width({
    super.key,
    required this.w,
  });
  double w;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(width: w * size.width / 100);
  }
}

class kText extends StatelessWidget {
  kText({
    super.key,
    this.size,
    required this.txt,
    this.txtColor,
    this.weight,
    this.align,
  });
  String txt;
  double? size;
  Color? txtColor;
  FontWeight? weight;
  TextAlign? align;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$txt',
      style: TextStyle(
        fontSize: size ?? 18,
        fontWeight: weight ?? FontWeight.w500,
        color: txtColor ?? AppColors.primaryColor,
      ),
      textAlign: align ?? TextAlign.center,
    );
  }
}

class GenAuthBtn extends StatelessWidget {
  GenAuthBtn({
    super.key,
    required this.txt,
    this.btnColor,
    this.h,
    this.radius,
    this.txtColor,
    this.w,
    this.onTap,
    this.txtWidth,
    this.txtBtnW,
    this.isLoading,
  });
  String txt;
  Color? btnColor, txtColor;
  double? w, h, radius, txtWidth, txtBtnW;
  Function()? onTap;
  bool? isLoading;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        height: h ?? 7 * size.height / 100,
        width: w ?? 80 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10),
          color: btnColor ?? Colors.white,
        ),
        child: isLoading ?? false
            ? Center(
                child: SizedBox(
                  height: 2 * size.height / 100,
                  width: 4 * size.width / 100,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                children: [
                  Width(w: txtWidth ?? 25),
                  kText(
                    txt: '$txt',
                    txtColor: txtColor ?? Colors.white,
                  ),
                  Width(w: txtBtnW ?? 16),
                  Icon(
                    Icons.arrow_forward,
                    color: txtColor ?? AppColors.primaryColor,
                  ),
                ],
              ),
      ),
    );
  }
}

void goTo(BuildContext context, Widget destination) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => destination,
    ),
  );
}

void goBack(BuildContext context) {
  Navigator.pop(context);
}

class TitleTextFieldTile extends StatefulWidget {
  TitleTextFieldTile({
    super.key,
    required this.size,
    required this.whichController,
    required this.hint,
    required this.title,
    required this.keyboardtype,
    this.onChanged,
    required this.isloading,
    this.validator,
    this.inputFormatters,
  });

  final Size size;
  final TextEditingController whichController;
  List<TextInputFormatter>? inputFormatters;
  String hint;
  String title;
  TextInputType keyboardtype;
  void Function(String)? onChanged;
  bool isloading;
  String? Function(String?)? validator;

  @override
  State<TitleTextFieldTile> createState() => _TitleTextFieldTileState();
}

class _TitleTextFieldTileState extends State<TitleTextFieldTile> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1 * widget.size.width / 100),
            child: Align(
              alignment: Alignment.centerLeft,
              child: kText(
                txtColor: Colors.black,
                size: 16.0,
                txt: widget.title,
                weight: FontWeight.w500,
              ),
            ),
          ),
          Height(h: 1),
          SizedBox(
            width: 90 * widget.size.width / 100,
            child: TextFormField(
              onChanged: widget.onChanged,
              enabled: widget.isloading ? false : true,
              showCursor: true,
              inputFormatters: widget.inputFormatters,
              cursorColor: Colors.grey,
              controller: widget.whichController,
              keyboardType: widget.keyboardtype,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(),
                ),
                hintText: '${widget.hint}',
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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: widget.validator,
              focusNode: _focusNode,
            ),
          ),
        ],
      ),
    );
  }
}

class GoogleFbChip extends StatelessWidget {
  GoogleFbChip({
    super.key,
    required this.imgUrl,
  });
  String imgUrl;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 7 * size.height / 100,
      width: 16 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Image.asset('assets/$imgUrl.png'),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: 90 * size.width / 100,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Height(h: 1.5),
            Center(
              child: kText(
                txt: 'Are you sure you want to log\nout from the appliction?',
                size: 16,
                txtColor: Colors.grey.shade700,
                weight: FontWeight.w400,
              ),
            ),
            Height(h: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LogoutChip(
                  txt: 'Cancel',
                  onTap: () {
                    goBack(context);
                  },
                ),
                Width(w: 3),
                LogoutChip(
                  txt: 'Yes',
                  btnColor: AppColors.primaryColor,
                  txtColor: Colors.white,
                  onTap: () {
                    Auth().signOut();
                    goTo(context, LoginScreen());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutChip extends StatelessWidget {
  LogoutChip({
    super.key,
    required this.onTap,
    required this.txt,
    this.borderColor,
    this.btnColor,
    this.txtColor,
  });
  Function() onTap;
  String txt;
  Color? borderColor, btnColor, txtColor;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 4.5 * size.height / 100,
        width: 28 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: borderColor ?? AppColors.primaryColor),
          color: btnColor ?? Colors.transparent,
        ),
        child: Center(
          child: kText(
            txt: '$txt',
            txtColor: txtColor ?? AppColors.primaryColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class HomeTopBanner extends StatelessWidget {
  const HomeTopBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
      height: 14 * size.height / 100,
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kText(
                    txt: 'Amazing Journey!',
                    txtColor: Colors.white,
                    weight: FontWeight.w600,
                    size: 20,
                    align: TextAlign.start,
                  ),
                  kText(
                    txt: 'You have successfully\nfinished 2 notes',
                    txtColor: Colors.white,
                    weight: FontWeight.w400,
                    size: 14,
                    align: TextAlign.start,
                  ),
                ],
              ),
              Image.asset('assets/todoman.png'),
            ],
          ),
        ],
      ),
    );
  }
}

class EmptyListContainer extends StatelessWidget {
  const EmptyListContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Height(h: 20),
            Center(
              child: Image.asset('assets/emptytodoman.png'),
            ),
            Height(h: 4.5),
            kText(
              txt: 'Start Your Journey',
              txtColor: Colors.black,
              size: 24,
              weight: FontWeight.w600,
            ),
            Height(h: 2),
            kText(
              txt:
                  'Every big step start with small step.\nNotes your first idea and start\nyour journey!',
              txtColor: Colors.grey,
              size: 14,
              weight: FontWeight.w300,
            ),
            Height(h: 2),
          ],
        ),
        Positioned(
          top: 68 * size.height / 100,
          left: 63 * size.width / 100,
          child: Image.asset('assets/arrow.png'),
        ),
      ],
    );
  }
}
