import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_translate/flutter_translate.dart';

class UserAccountModel extends Equatable {
  final int id;
  final String? avatar;
  final String name;
  final String gender;
  final String? language;
  final int kidsAccountType;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isKidsMode {
    if (kidsAccountType == 1) {
      return true;
    } else {
      return false;
    }
  }

  UserAccountModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.gender,
    required this.language,
    required this.kidsAccountType,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserAccountModel.fromJson(String str) =>
      UserAccountModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  UserAccountModel copyWith({
    int? id,
    String? avatar,
    String? name,
    String? gender,
    String? language,
    int? kidsAccountType,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserAccountModel(
        id: id ?? this.id,
        avatar: avatar ?? this.avatar,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        language: language ?? this.language,
        kidsAccountType: kidsAccountType ?? this.kidsAccountType,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserAccountModel.fromMap(Map<String, dynamic> json) =>
      UserAccountModel(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        gender: json["gender"],
        language: json["language"],
        kidsAccountType: json["kids_account_type"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "gender": gender,
        "language": language,
        "kids_account_type": kidsAccountType,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [];
}

enum UserAccountGenderEnum {
  male(value: "male"),
  female(value: "female");

  final String value;

  const UserAccountGenderEnum({required this.value});

  String get nameTranslated {
    switch (this) {
      case UserAccountGenderEnum.male:
        return translate("male");
      case UserAccountGenderEnum.female:
        return translate("female");
    }
  }
}
