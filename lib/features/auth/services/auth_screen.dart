// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../constants/error_handler.dart';
import '../../../constants/global_constants.dart';
import '../../../constants/utils.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          name: name,
          id: '',
          address: '',
          email: email,
          password: password,
          type: '',
          token: '');
      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: user.toJson(),
      );
      debugPrint(res.statusCode.toString());
      httpHandle(
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account created ! Login with the same credentials");
          },
          response: res);
    } catch (e) {
      print(e);
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void signInUser({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {"email": email, 'password': password},
        ),
      );
      debugPrint(
        res.body.toString(),
      );
      httpHandle(
        context: context,
        response: res,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString(
            "x-auth-token",
            jsonDecode(res.body)["token"],
          );

          Navigator.pushReplacementNamed(
            context,
            BottomBar.routeName,
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        prefs.setString("x-auth-token", "");
      }
      print(token);
      var tokenRes = await http.post(
        Uri.parse("$uri/api/tokenIsValid"),
        headers: {
          'Content-Type': 'application/json',
          "x-auth-token": token!,
        },
      );
      bool response = jsonDecode(tokenRes.body);
      print(response);
      if (response == true) {
        print("response");

        http.Response userRes = await http.get(
          Uri.parse("$uri/api/"),
          headers: {
            'Content-Type': 'application/json',
            "x-auth-token": token,
          },
        );
        print(userRes.body);

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
