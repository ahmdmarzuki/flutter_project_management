import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management/src/screen/auth/widget/costum_text_form_field.dart';
import 'package:project_management/src/screen/auth/widget/expanded_button.dart';
import 'package:project_management/src/core/services/auth_services/auth_service.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // final AuthService auth = AuthService();

    bool isLoading = false;

    void signIn() async {
      final authService = Provider.of<AuthService>(context, listen: false);

      try {
        await authService.signInByEmail(
            emailController.text.trim(), passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        throw FirebaseAuthException(code: e.code);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CostumTextFormField(
                bgColor: blackColor.withOpacity(.2),
                textStyle: GoogleFonts.poppins(),
                controller: emailController,
                obscureText: false,
                hintStyle: GoogleFonts.poppins(),
                hintText: 'Email',
              ),
              const SizedBox(height: 20),
              CostumTextFormField(
                bgColor: blackColor.withOpacity(.2),
                textStyle: GoogleFonts.poppins(),
                controller: passwordController,
                obscureText: false,
                hintStyle: GoogleFonts.poppins(),
                hintText: 'Password',
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CostumText(
                      text: "Don't have any account?", color: blackColor),
                  SizedBox(width: 4),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: CostumText(text: "Register", color: accentColor))
                ],
              ),
              const SizedBox(height: 12),
              ExpandedButton(
                  text: "Login",
                  isLoading: isLoading,
                  textColor: whiteColor,
                  buttonColor: accentColor,
                  loadingButtonColor: accentDarkColor,
                  textStyle: GoogleFonts.poppins(),
                  onTap: () {
                    signIn();

                    // Navigator.pushNamed(context, '/home');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
