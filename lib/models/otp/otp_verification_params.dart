import 'package:equatable/equatable.dart';

class OtpVerificationParams extends Equatable {
  final String phone;
  final OtpVerificationTypeEnum type;

  OtpVerificationParams({required this.phone, required this.type});

  
  String get getObuscateText {
    final bool isPhoneNumber = int.tryParse(phone) != null;
    return isPhoneNumber
        ? _obfuscatePhoneNumber(phone)
        : _obfuscateEmail(phone);
  }

  String _obfuscateEmail(String email) {
    // Validate if the email contains at least 5 characters (e.g., d@gmail.com)
    if (email.length < 5 || !email.contains('@')) {
      return email;
    }

    // Split email into local part and domain part
    var emailParts = email.split('@');
    var localPart = emailParts[0]; // Everything before @
    var domainPart = emailParts[1]; // Everything after @

    // Check if the local part has at least 3 characters
    if (localPart.length < 3) {
      return email;
    }

    // Keep the last two characters of the local part visible
    var visiblePart = localPart.substring(localPart.length - 2);

    // Replace all but the last two characters with '*'
    var obfuscatedPart = '*' * (localPart.length - 2) + visiblePart;

    // Combine the obfuscated local part with the domain
    return '$obfuscatedPart@$domainPart';
  }

  String _obfuscatePhoneNumber(String phoneNumber) {
    // Validate the length of the phone number
    if (phoneNumber.length < 4) {
      throw phoneNumber;
    }

    // Keep the last two digits visible
    var visiblePart = phoneNumber.substring(phoneNumber.length - 2);

    // Replace all but the last two digits with '*'
    var obfuscatedPart = '*' * (phoneNumber.length - 2) + visiblePart;

    return obfuscatedPart;
  }
  @override
  List<Object?> get props => [phone, type];
}

enum OtpVerificationTypeEnum { register, forgetPassword, updatePassword }
