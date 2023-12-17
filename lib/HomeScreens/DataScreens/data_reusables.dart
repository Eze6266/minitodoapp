// ignore_for_file: prefer_const_constructors

import 'package:datahub/Providers/data_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DataProvidersBox extends StatelessWidget {
  DataProvidersBox({
    super.key,
    required this.size,
    required this.colorType,
    required this.provider,
    required this.imgUrl,
    required this.clicked,
    required this.selected,
  });

  final Size size;
  String provider, imgUrl;
  Color colorType;
  Function() clicked;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
      child: GestureDetector(
        onTap: clicked,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color:
                        selected ? AppColors.primaryColor : Colors.transparent),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 6.5 * size.height / 100,
                    width: 14 * size.width / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: AssetImage('assets/images/$imgUrl'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  HeightWidget(height: 0.3),
                  Text(
                    '$provider',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            selected
                ? Positioned(
                    left: 10 * size.width / 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 8,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class DropdownAndTitle extends StatelessWidget {
  DropdownAndTitle({
    super.key,
    required this.size,
    required this.onTap,
    required this.text,
    required this.title,
  });

  final Size size;
  String title, text;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2 * size.width / 100),
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
        HeightWidget(height: 0.2),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 7 * size.height / 100,
            width: 90 * size.width / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoppinsCustText(
                  color: Colors.black,
                  size: 14.0,
                  text: '$text',
                  weight: FontWeight.w500,
                ),
                Icon(
                  Icons.expand_more_outlined,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChooseDataType {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet(BuildContext context) {
    var dataType = Provider.of<DataProvider>(context, listen: false);

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
                height: 60 * size.height / 100,
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
                          text: 'Choose Data Type',
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
                        dataType.seldataType = 1;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      selected: dataType.seldataType == 1 ? true : false,
                      type: 'SME',
                    ),
                    HeightWidget(height: 1),
                    SheetTiles(
                      size: size,
                      onTap: () {
                        Navigator.pop(context);
                        dataType.seldataType = 2;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      type: 'Normal Data',
                      selected: dataType.seldataType == 2 ? true : false,
                    ),
                    HeightWidget(height: 1),
                    SheetTiles(
                      size: size,
                      onTap: () {
                        Navigator.pop(context);
                        dataType.seldataType = 3;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      type: 'Enterprise Data',
                      selected: dataType.seldataType == 3 ? true : false,
                    ),
                    HeightWidget(height: 2),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SheetTiles extends StatelessWidget {
  SheetTiles({
    super.key,
    required this.onTap,
    required this.type,
    required this.size,
    required this.selected,
  });

  final Size size;
  String type;
  Function() onTap;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1 * size.width / 100),
        height: 7 * size.height / 100,
        width: 100 * size.width / 100,
        color: const Color.fromARGB(255, 238, 236, 236),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PoppinsCustText(
              color: Colors.black,
              size: 14.0,
              text: '$type',
              weight: FontWeight.w400,
            ),
            Container(
              height: 2 * size.height / 100,
              width: 4 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: selected
                  ? Icon(
                      Icons.check,
                      size: 12,
                      color: AppColors.primaryColor,
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseDataPlan {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet(BuildContext context) {
    var dataType = Provider.of<DataProvider>(context, listen: false);

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
                height: 60 * size.height / 100,
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
                          text: 'Choose Data Plan',
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
                        dataType.seldataPlan = 1;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      selected: dataType.seldataPlan == 1 ? true : false,
                      type: 'N200 200MB - 3 days',
                    ),
                    HeightWidget(height: 1),
                    SheetTiles(
                      size: size,
                      onTap: () {
                        Navigator.pop(context);
                        dataType.seldataPlan = 2;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      type: 'N2,000 4GB - 30 days',
                      selected: dataType.seldataPlan == 2 ? true : false,
                    ),
                    HeightWidget(height: 1),
                    SheetTiles(
                      size: size,
                      onTap: () {
                        Navigator.pop(context);
                        dataType.seldataPlan = 3;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      type: 'N2,500 6GB - 30 days',
                      selected: dataType.seldataPlan == 3 ? true : false,
                    ),
                    HeightWidget(height: 2),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
