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

  bool loginUserIsLoading = false;
  var loginUserStatus = '';
  var loginUserMessage = '';

  Future<String?> loginUser(
    String email,
    String password,
  ) async {
    loginUserIsLoading = true;
    notifyListeners();
    var response = await http.post(
      Uri.parse('https://vtu-apis.onrender.com/api/users/login-user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "email": email,
          "password": password,
        },
      ),
    );
    print('this is login response code ${response.statusCode}');

    loginUserIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('login was a succes');
      String responseString = response.body;
      loginUserStatus = jsonDecode(responseString)['status'];
      loginUserMessage = jsonDecode(responseString)['message'];

      notifyListeners();
      return loginUserStatus;
    } else {
      String responseString = response.body;
      loginUserStatus = jsonDecode(responseString)['status'];
      loginUserMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**LOGIN USER */////////////////////////////

  ///////////////////////** FORGOT PASSWORD */////////////////////////////

  bool forgotPwdIsLoading = false;
  var forgotPwdStatus = '';
  var forgotPwdMessage = '';

  Future<String?> forgotPassword(
    String email,
  ) async {
    forgotPwdIsLoading = true;
    notifyListeners();
    var response = await http.post(
      Uri.parse('https://vtu-apis.onrender.com/api/users/forgetpassword'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "email": email,
        },
      ),
    );
    print('this is forgot password response code ${response.statusCode}');

    forgotPwdIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('mail sent was a succes');
      String responseString = response.body;
      forgotPwdStatus = jsonDecode(responseString)['status'];
      forgotPwdMessage = jsonDecode(responseString)['message'];

      notifyListeners();
      return forgotPwdStatus;
    } else {
      String responseString = response.body;
      forgotPwdStatus = jsonDecode(responseString)['status'];
      forgotPwdMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**FORGOT PASSWORD*/////////////////////////////
  void authNotifer() {
    notifyListeners();
  }
}
