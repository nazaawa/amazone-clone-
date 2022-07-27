import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'utils.dart';

void httpHandle(
    {required BuildContext context,
      required Response response,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, jsonDecode(response.body));
  }
}
