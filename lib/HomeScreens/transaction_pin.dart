// ignore_for_file: prefer_final_fields, prefer_const_constructors, unnecessary_string_interpolations

import 'package:confetti/confetti.dart';
import 'package:datahub/HomeScreens/succes_page.dart';
import 'package:datahub/Providers/data_providers.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../Utilities/app_colors.dart';

class TransactionPinScreen extends StatefulWidget {
  TransactionPinScreen({
    super.key,
    required this.which,
    required this.amount,
    required this.phone,
    required this.serviceid,
    required this.userid,
    required this.network,
    required this.selectedDataId,
    required this.selectedDataPlan,
  });

  var which,
      userid,
      serviceid,
      phone,
      amount,
      network,
      selectedDataId,
      selectedDataPlan;
  @override
  State<TransactionPinScreen> createState() => _TransactionPinScreenState();
}

class _TransactionPinScreenState extends State<TransactionPinScreen> {
  bool isLoading = false;

  List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(text: ''),
  );

  final confetticontroller = ConfettiController();

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.length == 1) {
      if (index < _focusNodes.length - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus();
      }
    }
    setState(() {});
  }

  bool areAllFieldsFilled() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  String getPin() {
    String pin = '';
    for (var controller in _controllers) {
      pin += controller.text;
    }
    return pin;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var airtimeProvider = Provider.of<DataProvider>(context);
    isLoading = widget.which == '1'
        ? Provider.of<DataProvider>(context).buyAirtimeIsLoading
        : Provider.of<DataProvider>(context).buyDataIsLoading;
    confetticontroller.play();
    return SafeArea(
      child: Scaffold(
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
              PoppinsCustText(
                color: Colors.white,
                size: 18.0,
                text: 'Transaction pin',
                weight: FontWeight.w500,
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * size.width / 100),
          child: Column(
            children: [
              HeightWidget(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PoppinsCustText(
                    color: Colors.black,
                    size: 18.0,
                    text: 'Enter Pin',
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              HeightWidget(height: 1),
              Padding(
                padding: EdgeInsets.only(left: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PoppinsCustText(
                    color: Color(0xff8c8b90),
                    size: 14.0,
                    text: 'Enter your 4-digit pin to continue',
                    weight: FontWeight.w400,
                  ),
                ),
              ),
              HeightWidget(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 18 * size.width / 100,
                    height: 8 * size.height / 100,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1 * size.width / 100),
                      child: TextFormField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        onChanged: (value) => _onChanged(index, value),
                        cursorColor: Colors.black,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: '-',
                          filled: true,
                          fillColor: _controllers[index].text.isNotEmpty
                              ? Colors.blue.withOpacity(0.1)
                              : Colors.white,
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: _controllers[index].text.isNotEmpty
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _controllers[index].text.isNotEmpty
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.grey.shade500,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              HeightWidget(height: 5),
              GeneralButton(
                size: size,
                buttonColor:
                    areAllFieldsFilled() ? AppColors.primaryColor : Colors.grey,
                height: 7,
                text: 'Confirm',
                width: 85,
                onPressed: () async {
                  if (areAllFieldsFilled()) {
                    if (widget.which == '1') {
                      await airtimeProvider
                          .buyAirtime(
                        userid: widget.userid,
                        serviceID: widget.serviceid,
                        phoneNumber: widget.phone,
                        amount: widget.amount,
                        pin: getPin(),
                      )
                          .then((value) {
                        if (value == 'success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessPage(
                                which: widget.which,
                                airtime: widget.network,
                                cost: widget.amount,
                                number: widget.phone,
                                selectedDataPlan: widget.selectedDataPlan,
                                cablePlan: '',
                                iucNumber: '',
                                meterNumber: '',
                              ),
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: '${airtimeProvider.buyAirtimeMessage}',
                            ),
                            dismissType: DismissType.onSwipe,
                          );
                        }
                      });
                    } else if (widget.which == '2') {
                      await airtimeProvider
                          .buyData(
                        userid: widget.userid,
                        network: widget.network,
                        phoneNumber: widget.phone,
                        dataplan: widget.selectedDataId,
                        pin: getPin(),
                      )
                          .then((value) {
                        if (value == 'success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessPage(
                                which: widget.which,
                                airtime: widget.network,
                                cost: widget.amount,
                                number: widget.phone,
                                selectedDataPlan: widget.selectedDataPlan,
                                cablePlan: '',
                                iucNumber: '',
                                meterNumber: '',
                              ),
                            ),
                          );
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: '${airtimeProvider.buyDataMessage}',
                            ),
                            dismissType: DismissType.onSwipe,
                          );
                        }
                      });
                    }
                  } else {}
                },
                isLoading: isLoading,
              ),
              HeightWidget(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
