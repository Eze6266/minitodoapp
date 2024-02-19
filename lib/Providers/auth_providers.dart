import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  ///////////////////////**REGISTER NEW PARTNER */////////////////////////////

  bool regUserIsLoading = false;
  var regUserStatus = '';
  var regUserMessage = '';

  Future<String?> registerUser({
    required String username,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    regUserIsLoading = true;
    print('$username $firstName $lastName $phone $email $password');
    notifyListeners();

    var response = await http.post(
      Uri.parse('https://vtu-apis.onrender.com/api/users/register-user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userName": username,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phone,
        "email": email,
        "password": password
      }),
    );
    print('this is reg new user response code ${response.statusCode}');

    regUserIsLoading = false;
    notifyListeners();

    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('reg partner was a succes');
      String responseString = response.body;
      regUserStatus = jsonDecode(responseString)['status'];
      regUserMessage = jsonDecode(responseString)['message'];

      notifyListeners();
      return regUserStatus;
    } else {
      String responseString = response.body;
      regUserStatus = jsonDecode(responseString)['status'];
      regUserMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }
///////////////////////**REGISTER NEW PARTNER */////////////////////////////

  ///////////////////////**LOGIN USER */////////////////////////////

  bool loginPartIsLoading = false;
  var loginPartStatus = '';
  var loginPartMessage = '';

  Future<String?> loginNewPartner(
    String phoneNumber,
    String password,
  ) async {
    loginPartIsLoading = true;
    notifyListeners();
    var response = await http.post(
        Uri.parse(
            'https://picadailys-app-6hlm.onrender.com/api/v1/accounts/login/'),
        body: {
          "phone_number": phoneNumber,
          "password": password,
        });
    print('this is login partner response code ${response.statusCode}');

    loginPartIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('reg partner was a succes');
      String responseString = response.body;
      loginPartStatus = jsonDecode(responseString)['status'];
      loginPartMessage = jsonDecode(responseString)['message'];

      notifyListeners();
      return loginPartStatus;
    } else {
      String responseString = response.body;
      loginPartStatus = jsonDecode(responseString)['status'];
      loginPartMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**LOGIN USER */////////////////////////////
  void partnerAuthNotifer() {
    notifyListeners();
  }
}
