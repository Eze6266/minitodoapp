// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CableProvider extends ChangeNotifier {
  //***************************** VERIFY IUC NUMBER ****************************//

  var verifyIucMessage;
  var cableCustomerName = '';
  var verifyIucStatus;
  bool verifyIucisLoading = false;

  Future<String?> verifyIUCNumber({
    required String cableTv,
    required String iucNumber,
    required String token,
  }) async {
    print('$token $iucNumber $cableTv');
    try {
      verifyIucisLoading = true;

      notifyListeners();
      var response = await http.post(
          Uri.parse(
              'https://vtu-apis.onrender.com/api/users/verify-smart-card-number/$token'),
          headers: {
            "Content-type": 'application/json',
          },
          body: jsonEncode({
            "serviceID": cableTv,
            "Smartcardnumber": iucNumber,
          }));
      verifyIucisLoading = false;
      notifyListeners();
      print('this is the verify iuc response code ${response.statusCode}');

      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        verifyIucStatus = 'success';
        notifyListeners();
        if (jsonDecode(data)['status'].toString() == 'success') {
          verifyIucStatus = 'success';
          cableCustomerName =
              jsonDecode(data)['cardDetails']['Customer_Name'].toString();
          notifyListeners();
        } else {
          cableCustomerName = '';
          notifyListeners();
        }
        return verifyIucStatus;
      } else {
        verifyIucStatus = 'error';
        verifyIucMessage = jsonDecode(data)['message'].toString();
        print(verifyIucMessage);
        notifyListeners();
        return verifyIucStatus;
      }
    } catch (e) {
      print("Catch Error ${e.toString()}");
    }
    notifyListeners();
    return null;
  }
  //***************************** VERIFY IUC NUMBER ****************************//

  //***************************** FETCH CABLE PLANS****************************//

  var getCablePlanMessage;
  var selectedCablePlan = '';
  var selectedCableVarCode = '';
  var selectedCableAmount = '';
  var getCablePlanStatus;
  bool getCablePlanisLoading = false;
  List<dynamic> cablePlans = [];
  Future<String?> getCablePlans({
    required String cableTv,
  }) async {
    cablePlans.clear();
    try {
      getCablePlanisLoading = true;

      notifyListeners();
      var response = await http.get(
        Uri.parse(
            'https://api-service.vtpass.com/api/service-variations?serviceID=$cableTv'),
        headers: {
          "Content-type": 'application/json',
        },
      );
      getCablePlanisLoading = false;
      notifyListeners();
      print('this is the get cable response code ${response.statusCode}');

      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(data)['response_description'].toString() == '000') {
          getCablePlanStatus = 'success';
          cablePlans = jsonDecode(data)['content']['variations'];
          print(cablePlans);
          notifyListeners();
        } else {
          getCablePlanStatus = 'error';
          notifyListeners();
          return getCablePlanStatus;
        }
        return getCablePlanStatus;
      } else {
        getCablePlanStatus = 'error';
        //   getCablePlanMessage = jsonDecode(data)['message'].toString();
        notifyListeners();
        return getCablePlanStatus;
      }
    } catch (e) {
      print("Catch Error ${e.toString()}");
    }
    notifyListeners();
    return null;
  }

  //***************************** FETCH CABLE PLANS ****************************//

  //***************************** BUY CABLE PLAN ****************************//

  var buyCableMessage;

  var buyCableStatus;
  bool buyCableisLoading = false;

  Future<String?> buyCablePlan({
    required String cableTv,
    required String smartCardNumber,
    required String cableAmount,
    required String phone,
    required String token,
  }) async {
    try {
      buyCableisLoading = true;

      notifyListeners();
      var response = await http.post(
          Uri.parse(
              'https://vtu-apis.onrender.com/api/users/renew-current-cable-tv/$token'),
          headers: {
            "Content-type": 'application/json',
          },
          body: jsonEncode({
            "serviceID": cableTv,
            "smartCardNumber": smartCardNumber,
            "amount": cableAmount,
            "phone": phone,
          }));
      buyCableisLoading = false;
      notifyListeners();
      print('this is the buy cable response code ${response.statusCode}');

      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        buyCableStatus = 'success';

        if (jsonDecode(data)['status'].toString() == 'success') {
          buyCableStatus = 'success';

          notifyListeners();
        } else {
          cableCustomerName = '';
          notifyListeners();
        }
        return buyCableStatus;
      } else {
        buyCableStatus = 'error';
        buyCableMessage = jsonDecode(data)['message'].toString();
        notifyListeners();
        return buyCableStatus;
      }
    } catch (e) {
      print("Catch Error ${e.toString()}");
    }
    notifyListeners();
    return null;
  }

  //***************************** BUY CABLE PLAN ****************************//
  void cableNotifier() {
    notifyListeners();
  }
}
