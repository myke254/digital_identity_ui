// ignore_for_file: prefer_const_constructors

import 'package:digital_identity_ui/screens/verify_otp.dart';
import 'package:digital_identity_ui/screens/vouchee_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/form_text_field.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool _obscurepassword = true;
  bool _obscureConfirmPassword = true;
  bool register = true;
  bool recoverPassword = false;
  
  void _toggleObscured(bool pass) {
    setState(() {
      if (pass) {
        _obscurepassword = !_obscurepassword;
      } else {
        _obscureConfirmPassword = !_obscureConfirmPassword;
      }

      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;
      // Prevents focus if tap on eye
    });
  }

  void toggleSignin() {
    setState(() {
      register = !register;
    });
  }

  void toggleRecoverPassword() {
    setState(() {
      recoverPassword = !recoverPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left:8.0,right: 8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/equity-bank-logo.png",
                  height: 90,
                  width: 120,
                ),
                SizedBox(height: 30),
                Center(
                    child: Text('Welcome',
                        style: GoogleFonts.varelaRound(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color(
                              0xff8c261e,
                            )))),
                SizedBox(height: 30),
                Center(
                    child: Text("Equity Digital Identity",
                        style: GoogleFonts.varelaRound(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    register
                        ? "Register"
                        : recoverPassword
                            ? "Provide an Email address you previously Logged in with to send a password reset email"
                            : "Login",
                    style: GoogleFonts.varelaRound(
                        color: const Color(
                          0xff8c261e,
                        ),
                        fontSize: 13),
                  ),
                ),
                FormTextField(
                  validator: (String value){
                   return value.isEmpty;
                  },
                  errorMessage: "Please provide a valid Email addresss",
                  inputType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: SizedBox(),
                  controller: emailController,
                  formKey: _formKey,
                  hintText: "Email",
                ),
                if (register || !recoverPassword)
                  FormTextField(
                    validator: (String value)=>value.isEmpty,
                  errorMessage: "invalid password",
                    inputType: TextInputType.visiblePassword,
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurepassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => _toggleObscured(true),
                    ),
                    controller: passwordController,
                    formKey: _formKey,
                    letterSpacing: 2.0,
                    obscured: _obscurepassword,
                    hintText: "Password",
                    focusNode: textFieldFocusNode,
                  ),
                if (register)
                  FormTextField(
                     validator: (String value){
                   return value!=passwordController.text;
                  },
                  errorMessage: "Passwords do not match",
                    inputType: TextInputType.visiblePassword,
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => _toggleObscured(false),
                    ),
                    controller: confirmPasswordController,
                    formKey: _formKey,
                    letterSpacing: 2.0,
                    obscured: _obscureConfirmPassword,
                    hintText: "Confirm Password",
                    focusNode: textFieldFocusNode,
                  ),
                if (!register)
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: toggleRecoverPassword,
                            child: Text(!recoverPassword
                                ? "forgot password?"
                                : "Back to login")),
                      )),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 12),
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Color(0xff8c261e),
                        borderRadius: BorderRadius.circular(14)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => _formKey.currentState!.validate()? Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => OtpVerificationPage())):print("email: ${emailController.text}, Password: ${passwordController.text}"),
                        child: Center(
                          child: Text(
                            register
                                ? "Register"
                                : recoverPassword
                                    ? "Reset Password"
                                    : "login",
                            style: GoogleFonts.varelaRound(
                                color: Colors.white,
                                fontSize: recoverPassword ? 15 : 19),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                    child: InkWell(
                      onTap: () {
                        toggleSignin();
                        recoverPassword ? toggleRecoverPassword() : null;
                      },
                      child: Text(
                        register ? "Login instead" : "No account? Register now",
                        style: GoogleFonts.varelaRound(
                            fontSize: 18, color: Color(0xff8c261e)),
                      ),
                    ),
                  ),
                ),
                if (!recoverPassword)
                  Center(
                      child: SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              width: 200,
                              height: 1,
                            )),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xff8c261e),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                "OR",
                                style: GoogleFonts.varelaRound(
                                    color: Colors.white),
                              )),
                            ))
                      ],
                    ),
                  )),
                  if(!recoverPassword)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text("Continue With",
                          style: GoogleFonts.varelaRound(
                              color: const Color(
                            0xff8c261e,
                          )))),
                ),
                if (!recoverPassword)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: (){
                              print(emailController.text);
                            },
                            child: Image.asset(
                              "assets/google.png",
                              fit: BoxFit.fill,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Text(
                            "Google",
                            style: GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 1,
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VoucheeRegistration())),
                            child: Image.asset(
                              "assets/facebook.png",
                              fit: BoxFit.fill,
                              height: 37,
                              width: 37,
                            ),
                          ),
                          Text(
                            "facebook",
                            style: GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
