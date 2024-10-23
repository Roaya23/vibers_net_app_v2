import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/models/user_avatar_type_enum.dart';
import 'package:vibers_net/providers/account/create_user_account_provider.dart';
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
  final _formKey = GlobalKey<FormState>();

  CreateUserAccountParams _params = CreateUserAccountParams();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<CreateUserAccountProvider>().setStateInitial();
      },
    );
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
                label: translate("Name_"),
                validator: (text) {
                  if (text?.isEmpty == true) {
                    return translate("Name_can_not_be_empty");
                  }
                  return null;
                },
                onChanged: (text) {
                  setState(() {
                    _params = _params.copyWith(name: text);
                  });
                },
              ),
              SizedBox(height: 24),
              SelectGenderWidget(
                selectedGender: _params.gender,
                onGenderSelected: (gender) {
                  setState(() {
                    _params = _params.copyWith(gender: gender);
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
                      final bool isSelected = avatarType == _params.avatar;
                      return InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: () {
                          setState(() {
                            _params = _params.copyWith(avatar: avatarType);
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
                      _params = _params.copyWith(isKidsMode: isKids);
                    });
                  },
                  value: _params.isKidsMode)
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
              isEnabled: _params.isNotEmpty,
              text: translate("create_profile"),
              isLoading: context
                  .watch<CreateUserAccountProvider>()
                  .getUserAccountState
                  .isLoading,
              onPressed: () {
                final isValidForm = _formKey.currentState?.validate() ?? false;
                if (isValidForm) {
                  context
                      .read<CreateUserAccountProvider>()
                      .createAccount(_params)
                      .then(
                    (value) {
                      if (value != null) {
                        if (context.mounted) {
                          Navigator.of(context).pop(value);
                        }
                      }
                    },
                  );
                  // Navigator.pop(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
