import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/user.dart';
import '../utility/app_url.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final Map<String, dynamic> apiBodyData = {
      'firstName': name.split(' ')[0],
      'lastName': name.split(' ')[1],
      'email': email,
      'phoneNumber': '01234567891',
      'password': password
    };

    print('firstname: '+apiBodyData['firstName']);
    print('lastname: '+apiBodyData['lastName']);
    var result;

    result =  await post(
        Uri.parse(AppUrl.register),
        body: json.encode(apiBodyData),
        headers: {'Content-Type':'application/json'}
    ).then(onValue)
        .catchError(onError);

    return result;
  }


  notify(){
    notifyListeners();
  }

  static Future<FutureOr> onValue (Response response) async {
    var result ;

    final Map<String, dynamic> responseData = json.decode(response.body);

    print(responseData);

    if(response.statusCode == 200){

      var userData = responseData['data'];

      // now we will create a user.dart model
      User authUser = User.fromJson(responseData);

      // now we will create shared preferences and save data
      //UserPreferences().saveUser(authUser);

      result = {
        'status':true,
        'message':'Successfully registered',
        'data':authUser
      };

    }else{
      result = {
        'status':false,
        'message':responseData['message'],
        'data':responseData
      };
    }
    return result;
  }

  // For Login
  Future<Map<String, dynamic>> login(String email, String password) async {

    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> responseData = json.decode(response.body);

      print(responseData);

      //var userData = responseData['data'];
      //print("userData $userData");

      //User authUser = User.fromJson(userData);
      print(responseData);

      //UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful'};

    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;

  }


  Future<Map<String, dynamic>> forgotPassword(String email) async {

    var result;

    final Map<String, dynamic> inputData = {
      'email': email,
    };

    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.forgotPassword),
      body: json.encode(inputData),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {

      final Map<String, dynamic> responseData = json.decode(response.body);

      print('ResponseData: ${responseData.toString()}');

      result = {
        'status': true,
        'message': 'Mail has been sent'};

    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;

  }


  static onError(error){
    print('the error is ${error.detail}');
    return {
      'status': false,
      'message':'Unsuccessful Request',
      'data':error
    };
  }

  Future<Map<String, dynamic>> verify(String email, String token) async {

    var result;

    print('Email: $email');

    final Map<String, dynamic> inputData = {
      'email': email,
      'token': token
    };

    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.verifyUser),
      body: json.encode(inputData),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {


      print(responseData);

      result = {
        'status': true,
        'message': 'You have been verified'};

    } else {

      result = {
        'status': false,
        'message': responseData['message']
      };
    }

    return result;

  }

  Future<Map<String, dynamic>> resetPassword(String password) async {

    var result;

    final Map<String, dynamic> inputData = {
      'password': password
    };

    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.resetPassword),
      body: json.encode(inputData),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {


      print(responseData);

      result = {
        'status': true,
        'message': 'Your password has been reset'};

    } else {

      result = {
        'status': false,
        'message': responseData['message']
      };
    }

    return result;

  }


}