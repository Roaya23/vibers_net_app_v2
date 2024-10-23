import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:vibers_net/common/apipath.dart';
import 'package:vibers_net/common/async.dart';
import 'package:vibers_net/models/account/user_acount_model.dart';
import 'package:vibers_net/models/user_avatar_type_enum.dart';
import 'package:vibers_net/common/global.dart';
import 'package:http/http.dart' as http;

class CreateUserAccountProvider extends ChangeNotifier {
  Async<UserAccountModel> _userAccountModel = const Async.initial();

  Async<UserAccountModel> get getUserAccountState => _userAccountModel;

  Future<UserAccountModel?> createAccount(
      CreateUserAccountParams params) async {
    try {
      _userAccountModel = Async.loading();
      notifyListeners();
      final response = await http.post(
        Uri.parse(APIData.createUserProfile),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: "Bearer $authToken",
        },
        body: params.toMap,
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final UserAccountModel account =
            UserAccountModel.fromMap(result["data"]);
        _userAccountModel = Async.success(account);
        notifyListeners();
        return account;
      } else {
        _userAccountModel = Async.failure("errorMessage");
      }
    } catch (error) {
      _userAccountModel = Async.failure("errorMessage");
    }
    _userAccountModel = const Async.initial();
    notifyListeners();

    return null;
  }

  void setStateInitial() {
    _userAccountModel = const Async.initial();
    notifyListeners();
  }
}

class CreateUserAccountParams extends Equatable {
  final String? name;
  final UserAccountGenderEnum? gender;
  final UserAvatarTypeEnum? avatar;
  final bool isKidsMode;
  final String? languageLocal;

  const CreateUserAccountParams({
    this.name,
    this.gender,
    this.avatar,
    this.isKidsMode = false,
    this.languageLocal,
  });

  CreateUserAccountParams copyWith({
    String? name,
    UserAccountGenderEnum? gender,
    UserAvatarTypeEnum? avatar,
    bool? isKidsMode,
    String? languageLocal,
  }) {
    return CreateUserAccountParams(
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      isKidsMode: isKidsMode ?? this.isKidsMode,
      languageLocal: languageLocal ?? this.languageLocal,
    );
  }

  Map<String, dynamic> get toMap => {
        "name": name,
        "kids_account_type": isKidsMode ? 1 : 0,
        if (languageLocal != null) "language": languageLocal,
        "gender": gender?.value,
        "avatar": avatar?.emojiPath
      };

  bool get isNotEmpty =>
      avatar != null && gender != null && name != null && name != "";

  @override
  List<Object?> get props => [name, gender, avatar, isKidsMode, languageLocal];
}
