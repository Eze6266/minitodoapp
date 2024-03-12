import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  ///////////////////////**REGISTER NEW PARTNER */////////////////////////////

  bool regUserIsLoading = false;
  var regUserStatus = '';
  var regUserMessage = '';
  var regUserId;

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
      regUserId = jsonDecode(responseString)['data']['_id'];

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
  var loginUserId;
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
      loginUserStatus = jsonDecode(responseString)['status'].toString();
      loginUserMessage = jsonDecode(responseString)['message'];
      loginUserId = jsonDecode(responseString)['data'];
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('email', email);
      pref.setString('userid', loginUserId);
      notifyListeners();
      return loginUserStatus;
    } else {
      String responseString = response.body;
      loginUserStatus = jsonDecode(responseString)['status'].toString();
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

  ///////////////////////**GET USER */////////////////////////////

  bool getUserIsLoading = false;
  var getUserStatus = '';
  var getUserMessage = '';
  var email;
  var phone;
  var userName, balance, transactionsaccNumbers;

  Future<String?> getUser(
    String userId,
  ) async {
    getUserIsLoading = true;
    notifyListeners();
    var response = await http.get(
      Uri.parse('https://vtu-apis.onrender.com/api/users/get-one-user/$userId'),
      headers: {'Content-Type': 'application/json'},
    );
    print('this is get user response code ${response.statusCode}');

    getUserIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('get user was a succes');
      String responseString = response.body;
      getUserStatus = jsonDecode(responseString)['status'].toString();
      getUserMessage = jsonDecode(responseString)['message'];
      userName = jsonDecode(responseString)['data']['userName'];
      balance = jsonDecode(responseString)['data']['walletBalance'];
      email = jsonDecode(responseString)['data']['email'];
      phone = jsonDecode(responseString)['data']['phoneNumber'].toString();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('email', email);
      pref.setString('phone', phone);

      notifyListeners();
      return getUserStatus;
    } else {
      String responseString = response.body;
      getUserStatus = jsonDecode(responseString)['status'].toString();
      getUserMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**GET USER */////////////////////////////

  ///////////////////////**GET USER ACCOUNT NUMBERS*/////////////////////////////

  bool getAccNumIsLoading = false;
  var getAccNumStatus = '';
  var getAccNumMessage = '';
  var bankName = '';
  var accNumbers = '';

  Future<String?> getAccNum(
    String userId,
    String bvn,
  ) async {
    getAccNumIsLoading = true;
    notifyListeners();
    var response = await http.post(
      Uri.parse(
          'https://vtu-apis.onrender.com/api/users/user-virtual-accounts/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "bvn": bvn,
        },
      ),
    );
    print(
        'this is get user account number response code ${response.statusCode}');

    getAccNumIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('get user account number was a succes');
      String responseString = response.body;
      getAccNumStatus = jsonDecode(responseString)['status'].toString();
      getAccNumMessage = jsonDecode(responseString)['message'];
      accNumbers = jsonDecode(responseString)['data']['data']['account_number'];
      bankName = jsonDecode(responseString)['data']['data']['bank_name'];

      notifyListeners();
      return getAccNumStatus;
    } else {
      String responseString = response.body;
      getAccNumStatus = jsonDecode(responseString)['status'].toString();
      getAccNumMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**GET USER ACCOUNT NUMBERS */////////////////////////////

  ///////////////////////**SET USER PIN*/////////////////////////////

  bool setUserPinIsLoading = false;
  var setUserPinStatus = '';
  var setUserPinMessage = '';

  Future<String?> setUserPin(
    String userId,
    String pin,
  ) async {
    setUserPinIsLoading = true;
    notifyListeners();
    var response = await http.post(
      Uri.parse(
          'https://vtu-apis.onrender.com/api/users/transaction-pin-otp/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "transactionPin": pin,
        },
      ),
    );
    print('this is set pin number response code ${response.statusCode}');

    setUserPinIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('set pin was a succes');
      String responseString = response.body;
      setUserPinStatus = jsonDecode(responseString)['status'].toString();
      setUserPinMessage = jsonDecode(responseString)['message'];

      notifyListeners();
      return setUserPinStatus;
    } else {
      String responseString = response.body;
      setUserPinStatus = jsonDecode(responseString)['status'].toString();
      setUserPinMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**SET USER PIN */////////////////////////////
  void authNotifer() {
    notifyListeners();
  }
}
