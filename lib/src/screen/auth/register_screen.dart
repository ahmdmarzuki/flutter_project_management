import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management/src/core/services/auth_services/auth_service.dart';
import 'package:project_management/src/screen/auth/widget/costum_text_form_field.dart';
import 'package:project_management/src/screen/auth/widget/expanded_button.dart';
import 'package:project_management/utils/color.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/fontweight.dart';
import 'package:project_management/utils/margin.dart';
import 'package:project_management/utils/text_style.dart';
import 'package:project_management/utils/theme.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onTap;
  RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  bool passIsHide = false;
  bool passConfirmIsHide = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void togglePass() {
      setState(() {
        passIsHide = !passIsHide;
      });
    }

    void toggleConfirmPass() {
      setState(() {
        passConfirmIsHide = !passConfirmIsHide;
      });
    }

    void SignUp() async {
      if (passwordController.text == passwordConfirmationController.text) {
        final authService = Provider.of<AuthService>(context, listen: false);

        try {
          await authService.signUpByEmail(emailController.text.trim(),
              passwordController.text.trim(), usernameController.text.trim());
        } catch (e) {
          throw Exception(e);
        }
      }
    }

    Widget usernameInput() {
      return Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: bgColor4.withOpacity(.2),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 30,
                  child: Image.asset(
                    'assets/icon_username.png',
                    height: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                      controller: emailController,
                      style: googlePoppins,
                      decoration: InputDecoration.collapsed(
                          hintText: "Username", hintStyle: googlePoppins)),
                ),
              ],
            ),
          ));
    }

    Widget emailInput() {
      return Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: bgColor4.withOpacity(.2),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 30,
                  child: Image.asset(
                    'assets/icon_email.png',
                    height: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                      controller: emailController,
                      style: googlePoppins,
                      decoration: InputDecoration.collapsed(
                          hintText: "Email", hintStyle: googlePoppins)),
                ),
              ],
            ),
          ));
    }

    Widget passwordInput() {
      return Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: bgColor4.withOpacity(.2),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 30,
                  child: Image.asset(
                    'assets/icon_password.png',
                    height: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                      obscureText: passIsHide ? true : false,
                      controller: passwordController,
                      style: googlePoppins,
                      decoration: InputDecoration.collapsed(
                          hintText: "Password", hintStyle: googlePoppins)),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      togglePass();
                    },
                    child: Image.asset(
                      passIsHide
                          ? 'assets/icon_eye_close.png'
                          : 'assets/icon_eye_open.png',
                      width: 20,
                      color: whiteColor,
                    ))
              ],
            ),
          ));
    }

    Widget passwordConfirmationInput() {
      return Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: bgColor4.withOpacity(.2),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 30,
                  child: Image.asset(
                    'assets/icon_password.png',
                    height: 25,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                      obscureText: passConfirmIsHide ? true : false,
                      controller: passwordController,
                      style: googlePoppins,
                      decoration: InputDecoration.collapsed(
                          hintText: "Re-Password", hintStyle: googlePoppins)),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      toggleConfirmPass();
                    },
                    child: Image.asset(
                      passConfirmIsHide
                          ? 'assets/icon_eye_close.png'
                          : 'assets/icon_eye_open.png',
                      width: 20,
                      color: whiteColor,
                    ))
              ],
            ),
          ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor1,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: defaultMargin, vertical: defaultMargin * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CostumText(
                      text: "Getting Started",
                      color: whiteColor,
                      fontSize: 32,
                      fontWeight: medium,
                    ),
                    CostumText(
                        text: "Hello, enjoy your experience here !",
                        color: secondaryTextColor,
                        fontWeight: light)
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image_register.png',
                      height: 200,
                    ),
                    // usernameInput(),
                    const SizedBox(height: 20),
                    emailInput(),
                    const SizedBox(height: 20),
                    passwordInput(),
                    const SizedBox(height: 20),
                    passwordConfirmationInput(),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CostumText(
                            text: "Already have an account?",
                            color: secondaryTextColor),
                        const SizedBox(width: 4),
                        GestureDetector(
                            onTap: widget.onTap,
                            child:
                                CostumText(text: "Login", color: accentColor))
                      ],
                    ),
                    const SizedBox(height: 12),
                    ExpandedButton(
                        text: "Register",
                        isLoading: isLoading,
                        textColor: whiteColor,
                        buttonColor: primaryColor,
                        loadingButtonColor: primaryColor.withOpacity(.7),
                        textStyle: GoogleFonts.poppins(),
                        onTap: () {
                          SignUp();
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
