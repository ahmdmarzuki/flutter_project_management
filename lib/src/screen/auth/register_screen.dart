import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management/src/core/services/auth_services/auth_service.dart';
import 'package:project_management/src/screen/auth/widget/costum_text_form_field.dart';
import 'package:project_management/src/screen/auth/widget/expanded_button.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/theme.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onTap;
  RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmationController = TextEditingController();

    bool isLoading = false;

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
                controller: usernameController,
                obscureText: false,
                hintStyle: GoogleFonts.poppins(),
                hintText: 'Username',
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              CostumTextFormField(
                bgColor: blackColor.withOpacity(.2),
                textStyle: GoogleFonts.poppins(),
                controller: passwordConfirmationController,
                obscureText: false,
                hintStyle: GoogleFonts.poppins(),
                hintText: 'Confirm Password',
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CostumText(
                      text: "Already have an account?", color: blackColor),
                  const SizedBox(width: 4),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: CostumText(text: "Login", color: accentColor))
                ],
              ),
              const SizedBox(height: 12),
              ExpandedButton(
                  text: "Register",
                  isLoading: isLoading,
                  textColor: whiteColor,
                  buttonColor: accentColor,
                  loadingButtonColor: accentDarkColor,
                  textStyle: GoogleFonts.poppins(),
                  onTap: () {
                    SignUp();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
