import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:vibers_net/common/route_paths.dart';
import 'package:vibers_net/common/styles.dart';
import 'package:vibers_net/common/text_styles.dart';
import 'package:vibers_net/providers/account/get_all_user_accounts_provider.dart';
import 'package:vibers_net/ui/shared/app_fail_widget.dart';
import 'package:vibers_net/ui/shared/app_image.dart';
import 'package:vibers_net/ui/shared/app_loading_widget.dart';
import 'package:vibers_net/ui/widgets/app_bar_widget.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  bool canEditAccounts = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _getAllAccounts();
      },
    );
  }

  void _getAllAccounts() {
    context.read<GetAllUserAccountsProvider>().getAllAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: translate("who_watching"),
      ),
      body: Consumer<GetAllUserAccountsProvider>(
        builder: (context, GetAllUserAccountsProvider value, child) {
          if (value.userAccountModel.isSuccess) {
            final accounts = value.userAccountModel.data ?? [];
            return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(32.0),
              mainAxisSpacing: 32,
              childAspectRatio: .85,
              crossAxisSpacing: 32,
              children: [
                ...accounts.map(
                  (account) {
                    return UserAvatarWidget(
                      avatr: account.avatar ?? "",
                      userName: account.name,
                      canEditAccounts: canEditAccounts,
                      onTap: () {
                        if (canEditAccounts) {
                          Navigator.of(context)
                              .pushNamed(RoutePaths.editAccountPage);
                        } else {
                          // TODO : add change account feature
                        }
                      },
                    );
                  },
                ),
                AnimatedOpacity(
                  opacity: canEditAccounts ? 0.0 : 1.0,
                  duration: Durations.medium1,
                  child: _AddNewProfileWidget(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RoutePaths.createAccountProfilePage);
                    },
                  ),
                )
              ],
            );
          } else if (value.userAccountModel.isFailure) {
            return AppFailWidget(onRetry: _getAllAccounts);
          }
          return const AppLoadingWidget();
        },
      ),
      bottomNavigationBar: _ManageProfileWidget(
        canEditAccounts: canEditAccounts,
        onTap: () {
          setState(() {
            canEditAccounts = !canEditAccounts;
          });
        },
      ),
    );
  }
}

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget(
      {Key? key,
      this.size,
      required this.avatr,
      required this.userName,
      this.canEditAccounts = false,
      this.onTap})
      : super(key: key);
  final double? size;
  final String avatr;
  final String userName;
  final bool canEditAccounts;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: AnimatedContainer(
              duration: Durations.medium1,
              clipBehavior: Clip.antiAlias,
              foregroundDecoration: canEditAccounts
                  ? null
                  : BoxDecoration(
                      color: Colors.black12,
                    ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                      color: canEditAccounts ? kMainLight : Colors.transparent,
                      width: 3)),
              child: Stack(
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                children: [
                  AppImage.rounded(
                    path: avatr,
                    fit: BoxFit.cover,
                    cacheImage: false,
                    showFailIcon: false,
                    radius: 22,
                    width: double.infinity,
                    height: double.infinity,
                    bgColor: Colors.grey[100]!,
                  ),
                  AnimatedOpacity(
                    opacity: canEditAccounts ? 1.0 : 0.0,
                    duration: Durations.medium1,
                    child: Icon(
                      Icons.edit,
                      size: 28,
                      color: kMainLight,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            userName.split(" ").first,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextStyles.regular14(color: kWhite100),
          )
        ],
      ),
    );
  }
}

class _AddNewProfileWidget extends StatelessWidget {
  const _AddNewProfileWidget({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.add_circle,
            size: 70,
            color: Colors.white,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            translate("add_profile"),
            style: TextStyles.regular14(color: kWhite100),
          )
        ],
      ),
    );
  }
}

class _ManageProfileWidget extends StatelessWidget {
  const _ManageProfileWidget(
      {required this.onTap, required this.canEditAccounts});
  final VoidCallback onTap;
  final bool canEditAccounts;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: SafeArea(
          bottom: true,
          top: false,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Text(
              canEditAccounts
                  ? translate("Cancel_")
                  : translate("Manage_Profile"),
              style: TextStyles.regular14(
                  color: canEditAccounts ? kRedColor : kWhite100),
            ),
          ),
        ),
      ),
    );
  }
}
