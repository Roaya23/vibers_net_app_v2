import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/models/gender_type_enum.dart';
import 'package:vibers_net/models/user_avatar_type_enum.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/widgets/app_bar_widget.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
import 'package:vibers_net/ui/widgets/app_text_form_field.dart';

import 'edit_acount_page.dart';

class CreateAccountProfilePage extends StatefulWidget {
  const CreateAccountProfilePage({super.key});

  @override
  State<CreateAccountProfilePage> createState() =>
      _CreateAccountProfilePageState();
}

class _CreateAccountProfilePageState extends State<CreateAccountProfilePage> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GenderTypeEnum? selectedGender;
  UserAvatarTypeEnum? userAvatarTypeEnum;
  bool isKidsMode = false;

  bool get isRequiredDataHasFilled {
    return _nameController.text.isNotEmpty &&
        selectedGender != null &&
        userAvatarTypeEnum != null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBarWidget(
          titleText: translate("create_profile"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppTextFormField(
                controller: _nameController,
                label: translate("Name_"),
                validator: (text) {
                  if (text?.isEmpty == true) {
                    return translate("Name_can_not_be_empty");
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {});
                },
              ),
              SizedBox(height: 24),
              SelectGenderWidget(
                selectedGender: selectedGender,
                onGenderSelected: (gender) {
                  setState(() {
                    selectedGender = gender;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Text(translate("profile_photo")),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Wrap(
                  runSpacing: 20,
                  spacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  children: UserAvatarTypeEnum.values.map(
                    (avatarType) {
                      final bool isSelected = avatarType == userAvatarTypeEnum;
                      return InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: () {
                          setState(() {
                            userAvatarTypeEnum = avatarType;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Durations.medium1,
                          height: 80,
                          width: 80,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                width: 3,
                                color: isSelected
                                    ? kMainLight
                                    : Colors.transparent,
                              )),
                          child: Stack(
                            clipBehavior: Clip.antiAlias,
                            children: [
                              AppImage(
                                path: avatarType.emojiPath,
                                cacheImage: false,
                                fit: BoxFit.cover,
                              ),
                              AnimatedOpacity(
                                opacity: isSelected ? 1 : 0,
                                duration: Durations.medium1,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                  ),
                                  width: double.infinity,
                                  height: double.infinity,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: kMainLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              KidsTileWidget(
                  onToggle: (isKids) {
                    setState(() {
                      isKidsMode = isKids;
                    });
                  },
                  value: isKidsMode)
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: SafeArea(
            bottom: true,
            top: false,
            child: AppButton(
              isEnabled: isRequiredDataHasFilled,
              text: translate("create_profile"),
              onPressed: () {
                final isValidForm = _formKey.currentState?.validate() ?? false;
                if (isValidForm) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
