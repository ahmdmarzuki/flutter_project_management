import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management/src/screen/auth/widget/costum_text_form_field.dart';
import 'package:project_management/src/screen/auth/widget/expanded_button.dart';
import 'package:project_management/src/core/services/auth_services/auth_service.dart';
import 'package:project_management/utils/color.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/fontweight.dart';
import 'package:project_management/utils/margin.dart';
import 'package:project_management/utils/text_style.dart';
import 'package:project_management/utils/theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passIsHide = false;

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void togglePass() {
      setState(() {
        passIsHide = !passIsHide;
      });
    }

    void signIn() async {
      final authService = Provider.of<AuthService>(context, listen: false);

      try {
        await authService.signInByEmail(
            emailController.text.trim(), passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(code: e.code);
      }
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
                SizedBox(
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
                      text: "Wellcome Back",
                      color: whiteColor,
                      fontSize: 32,
                      fontWeight: medium,
                    ),
                    CostumText(
                        text: "It's been a long time since you left",
                        color: secondaryTextColor,
                        fontWeight: light)
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Image.asset('assets/image_login.png'),
                    emailInput(),
                    const SizedBox(height: 20),
                    passwordInput(),
                    SizedBox(height: defaultMargin * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CostumText(
                            text: "Don't have any account?", color: secondaryTextColor),
                        const SizedBox(width: 4),
                        GestureDetector(
                            onTap: widget.onTap,
                            child: CostumText(
                                text: "Register", color: accentColor))
                      ],
                    ),
                    const SizedBox(height: 12),
                    ExpandedButton(
                        text: "Login",
                        isLoading: isLoading,
                        textColor: whiteColor,
                        buttonColor: primaryColor,
                        loadingButtonColor: primaryColor.withOpacity(.7),
                        textStyle: GoogleFonts.poppins(),
                        onTap: () {
                          signIn();
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
