import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vibers_net/common/apipath.dart';
import 'package:vibers_net/common/async.dart';
import 'package:vibers_net/common/global.dart';
import 'package:vibers_net/models/account/user_acount_model.dart';
import 'package:http/http.dart' as http;

class GetAllUserAccountsProvider extends ChangeNotifier {
  Async<List<UserAccountModel>> _userAccountModel = const Async.initial();

  Async<List<UserAccountModel>> get userAccountModel => _userAccountModel;

  void getAllAccounts() async {
    try {
      _userAccountModel = Async.loading();
      notifyListeners();
      final response = await http.get(
        Uri.parse(APIData.allUserAccounts),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: "Bearer $authToken",
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final data = (result?["data"] as List?) ?? [];
        final List<UserAccountModel> accounts =
            data.map((data) => UserAccountModel.fromMap(data)).toList();
        _userAccountModel = Async.success(accounts);
      } else {
        _userAccountModel = Async.failure("errorMessage");
      }
    } catch (error) {
      _userAccountModel = Async.failure("errorMessage");
    }
    notifyListeners();
  }
}
