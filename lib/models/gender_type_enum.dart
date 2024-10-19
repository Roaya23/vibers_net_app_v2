import 'package:flutter_translate/flutter_translate.dart';

enum GenderTypeEnum {
  male,
  female;

  String get nameTranslated {
    switch (this) {
      case GenderTypeEnum.male:
        return translate("male");
      case GenderTypeEnum.female:
        return translate("female");
    }
  }
}
