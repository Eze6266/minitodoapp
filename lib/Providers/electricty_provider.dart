import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ElectricityProvider extends ChangeNotifier {
  var selectedElectricPlan = '';
  var selectedElectricCode = '';

  //***************************** VERIFY METER NUMBER ****************************//

  var verifyMeterMessage;
  var meterCustomerName = '';
  var verifyMeterStatus;
  bool verifyMeterisLoading = false;

  Future<String?> verifyMeterNumber({
    required String serviceID,
    required String meterNumber,
    required String type,
    required String token,
  }) async {
    try {
      print('$serviceID $meterNumber $type $token');
      verifyMeterisLoading = true;

      notifyListeners();
      var response = await http.post(
          Uri.parse(
              'https://vtu-apis.onrender.com/api/users/verify-meter-number/$token'),
          headers: {
            "Content-type": 'application/json',
          },
          body: jsonEncode({
            "serviceID": serviceID,
            "meterNumber": meterNumber,
            "type": type,
          }));
      verifyMeterisLoading = false;
      notifyListeners();
      print(
          'this is the verify meter number response code ${response.statusCode}');

      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        verifyMeterStatus = 'success';

        if (jsonDecode(data)['status'].toString() == 'success') {
          verifyMeterStatus = 'success';
          meterCustomerName = jsonDecode(data)['MeterDetails']['Customer_Name'];

          notifyListeners();
        } else {
          meterCustomerName = '';
          notifyListeners();
        }
        return verifyMeterStatus;
      } else {
        verifyMeterStatus = 'error';
        verifyMeterMessage = jsonDecode(data)['message'].toString();
        notifyListeners();
        return verifyMeterStatus;
      }
    } catch (e) {
      print("Catch Error ${e.toString()}");
    }
    notifyListeners();
    return null;
  }

  //***************************** VERIFY METER NUMBER ****************************//
  void electricityNotifier() {
    notifyListeners();
  }
}
