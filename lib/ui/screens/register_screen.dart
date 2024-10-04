import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vibers_net/ui/widgets/app_button.dart';
import 'package:vibers_net/ui/widgets/app_text_form_field.dart';
import '/common/route_paths.dart';
import '/common/styles.dart';
import '/providers/app_config.dart';
import '/providers/login_provider.dart';
import '/providers/user_profile_provider.dart';
import '/ui/shared/appbar.dart';
import '/ui/shared/logo.dart';
import '/ui/widgets/register_here.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _passController = new TextEditingController();
  final _confirmPassController = new TextEditingController();
  final _phoneController = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  bool _isLoading = false;

// Sign up button

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final form = _formKey.currentState!;
    form.save();
    if (form.validate() == true) {
      try {
        await loginProvider.register(_nameController.text,
            _emailController.text, _passController.text, context);
        if (loginProvider.loginStatus == true) {
          final userDetails =
              Provider.of<UserProfileProvider>(context, listen: false)
                  .userProfileModel!;
          if (userDetails.active == 1 || userDetails.active == "1") {
            if (userDetails.payment == "Free") {
              Navigator.pushNamed(context, RoutePaths.bottomNavigationHome);
            } else {
              Navigator.pushNamed(context, RoutePaths.multiScreen);
            }
          } else {
            Navigator.pushNamed(context, RoutePaths.bottomNavigationHome);
          }
        } else if (loginProvider.emailVerify == false) {
          setState(() {
            _isLoading = false;
            _nameController.text = '';
            _emailController.text = '';
            _passController.text = '';
          });
          showAlertDialog(context, loginProvider.emailVerifyMsg);
        } else {
          setState(() {
            _isLoading = false;
          });
          print("registratiopn test: ${loginProvider.emailVerifyMsg}");
          Fluttertoast.showToast(
            msg: "${loginProvider.emailVerifyMsg}",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Text(
              'An error occurred!',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Something went wrong',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color?>(
                    Colors.blueAccent,
                  ),
                ),
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  showAlertDialog(BuildContext context, String msg) {
    var msg1 = msg.replaceAll('"', "");
    Widget okButton = TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color?>(
          primaryBlue,
        ),
      ),
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text(
        "Sign Up Successful!",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: primaryBlue,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "$msg1 Verify your email to continue.",
        style: TextStyle(
          color: Theme.of(context).colorScheme.background,
          fontSize: 16.0,
        ),
      ),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget phoneField() {
    return AppTextFormField(
      label: translate("phone"),
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value!.length == 0) {
          return 'Phone can not be empty';
        } else {
          return null;
        }
      },
    );
  }

  Widget emailField() {
    return AppTextFormField(
      label: translate("emailAddress"),
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.length == 0) {
          return 'Email can not be empty';
        } else {
          if (!value.contains('@')) {
            return 'Invalid Email';
          } else {
            return null;
          }
        }
      },
    );
  }

  Widget nameField() {
    return AppTextFormField(
      label: translate("Name_"),
      controller: _nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.length < 5) {
          if (value.length == 0) {
            return 'Enter name';
          } else {
            return 'Enter minimum 5 characters';
          }
        } else {
          return null;
        }
      },
    );
  }

  Widget passwordField() {
    return AppTextFormField(
      controller: _passController,
      label: translate("password"),
      isTextSecured: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 6) {
          return 'Enter minimum 6 digits';
        } else {
          return null;
        }
      },
    );
  }

  Widget confirmPasswordField() {
    return AppTextFormField(
      controller: _confirmPassController,
      label: translate("Confirm_Password"),
      isTextSecured: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 6) {
          return 'Enter minimum 6 digits';
        } else if (_passController.text != value) {
          return "Password doesn't match";
        } else {
          return null;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<AppConfig>(context, listen: false);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            appBar: customAppBar(context, "Sign Up") as PreferredSizeWidget?,
            key: scaffoldKey,
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    logoImage(context, myModel, 1, 130.0, 130.0),
                    // const SizedBox(
                    //   height: 18,
                    // ),
                    nameField(),
                    const SizedBox(
                      height: 18,
                    ),
                    emailField(),
                    const SizedBox(
                      height: 18,
                    ),
                    phoneField(),
                    const SizedBox(
                      height: 18,
                    ),
                    passwordField(),
                    const SizedBox(
                      height: 18,
                    ),
                    confirmPasswordField(),
                    SizedBox(
                      height: 24,
                    ),
                    AppButton(
                      text: translate("Register_"),
                      isLoading: _isLoading,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _signUp();
                      },
                    ),

                    SizedBox(
                      height: 32,
                    ),
                    loginHereText(context),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            )));
  }
}
