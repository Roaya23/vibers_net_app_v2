import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/models/gender_type_enum.dart';
import 'package:vibers_net/models/user_avatar_type_enum.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/widgets/app_bar_widget.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
import 'package:vibers_net/ui/widgets/app_text_form_field.dart';
import 'package:vibers_net/ui/widgets/show_modal_bottom_sheet.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  GenderTypeEnum? selectedGender;
  UserAvatarTypeEnum? userAvatarTypeEnum = UserAvatarTypeEnum.values.first;
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
          titleText: translate("Edit_Profile"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppImage(
                path: userAvatarTypeEnum?.emojiPath ?? '',
                height: 150,
                width: 150,
                placeholderColor: Colors.grey[100]!,
              ),
              SizedBox(height: 34),
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
              _SelectChangedField(
                title: translate("profile_picture"),
                hint: translate("change_photo"),
                actionText: translate("change"),
                icon: Icons.image,
                onActionPressed: () {
                  _SelectProfilePictureBottomSheet.show(context,
                          currentAvatar: userAvatarTypeEnum)
                      .then(
                    (value) {
                      if (value != null) {
                        setState(() {
                          userAvatarTypeEnum = value;
                        });
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              _SelectChangedField(
                title: translate("profile_picture"),
                hint: translate("Language_"),
                actionText: translate("select"),
                icon: Icons.language,
                onActionPressed: () {},
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
              text: translate("continue"),
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

class SelectGenderWidget extends StatelessWidget {
  const SelectGenderWidget(
      {this.selectedGender, required this.onGenderSelected});
  final GenderTypeEnum? selectedGender;
  final void Function(GenderTypeEnum? gender) onGenderSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          translate("gender"),
          style: TextStyles.regular14(color: kWhite100),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: RadioListTile.adaptive(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  activeColor: kMainLight,
                  title: Text(
                    GenderTypeEnum.male.nameTranslated,
                    style: TextStyles.medium14(color: kWhite100TextColor),
                  ),
                  useCupertinoCheckmarkStyle: true,
                  splashRadius: 8,
                  value: GenderTypeEnum.male,
                  groupValue: selectedGender,
                  onChanged: onGenderSelected),
            ),
            Expanded(
              flex: 5,
              child: RadioListTile.adaptive(
                  splashRadius: 8,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  activeColor: kMainLight,
                  title: Text(
                    GenderTypeEnum.female.nameTranslated,
                    style: TextStyles.medium14(color: kWhite100TextColor),
                  ),
                  useCupertinoCheckmarkStyle: true,
                  value: GenderTypeEnum.female,
                  groupValue: selectedGender,
                  onChanged: onGenderSelected),
            ),
          ],
        )
      ],
    );
  }
}

class _SelectChangedField extends StatelessWidget {
  const _SelectChangedField(
      {required this.onActionPressed,
      required this.icon,
      required this.title,
      required this.hint,
      required this.actionText});
  final VoidCallback onActionPressed;
  final IconData icon;
  final String title;
  final String hint;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.regular14(color: kWhite100),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: kBorderColor, width: 1),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: kRedColor,
                size: 18,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  hint,
                  style: TextStyles.medium14(color: kWhite100),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onActionPressed,
                child: Text(
                  actionText,
                  style: TextStyles.medium14(color: kMainLight),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class KidsTileWidget extends StatelessWidget {
  const KidsTileWidget({required this.onToggle, required this.value});
  final void Function(bool isKids) onToggle;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      hoverColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onChanged: onToggle,
      contentPadding: EdgeInsets.symmetric(vertical: 14),
      activeColor: kRedColor,
      thumbColor: WidgetStateProperty.all(Colors.white),
      inactiveTrackColor: Colors.grey,
      dense: true,
      title: Text(
        translate("kids_profile"),
        style: TextStyles.regular12(color: kWhite100),
      ),
    );
  }
}

class _SelectProfilePictureBottomSheet extends StatefulWidget {
  const _SelectProfilePictureBottomSheet({required this.currentAvatar});
  final UserAvatarTypeEnum? currentAvatar;
  static Future<UserAvatarTypeEnum?> show(BuildContext context,
      {required UserAvatarTypeEnum? currentAvatar}) async {
    return await showAppModalBottomSheet<UserAvatarTypeEnum?>(
        context: context,
        child: _SelectProfilePictureBottomSheet(
          currentAvatar: currentAvatar,
        ));
  }

  @override
  State<_SelectProfilePictureBottomSheet> createState() =>
      _SelectProfilePictureBottomSheetState();
}

class _SelectProfilePictureBottomSheetState
    extends State<_SelectProfilePictureBottomSheet> {
  UserAvatarTypeEnum? value;
  @override
  void initState() {
    value = widget.currentAvatar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              Icons.image,
              color: kRedColor,
              size: 18,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                translate("change_photo"),
                style: TextStyles.bold16(color: kWhite100),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                translate("Cancel_"),
                style: TextStyles.regular14(color: kWhite100),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Wrap(
          runSpacing: 24,
          spacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          children: UserAvatarTypeEnum.values.map(
            (avatarType) {
              final bool isSelected = avatarType == value;
              return InkWell(
                borderRadius: BorderRadius.circular(22),
                onTap: () {
                  setState(() {
                    value = avatarType;
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
                        color: isSelected ? kMainLight : Colors.transparent,
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
        const SizedBox(
          height: 24,
        ),
        AppButton(
          isEnabled: value != widget.currentAvatar,
          text: translate("change"),
          isExpanded: false,
          textStyle: TextStyles.semiBold14(color: kDarkTextColor),
          onPressed: () {
            Navigator.of(context).pop(value);
          },
        ),
      ],
    );
  }
}
