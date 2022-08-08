// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                SizedBox(height: 40),
                Center(
                    child: Text('Welcome',
                        style: GoogleFonts.varelaRound(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color(
                              0xff8c261e,
                            )))),
                SizedBox(height: 40),
                Center(
                    child: Text("Equity Digital Identity",
                        style: GoogleFonts.varelaRound(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(register ? "Register" : "Login"),
                ),
                FormTextField(
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: SizedBox(),
                  controller: emailController,
                  formKey: _formKey,
                  hintText: "Email",
                  focusNode: textFieldFocusNode,
                ),
                FormTextField(
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurepassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () => _toggleObscured(true),
                  ),
                  controller: emailController,
                  formKey: _formKey,
                  obscured: _obscurepassword,
                  hintText: "Password",
                  focusNode: textFieldFocusNode,
                ),
                !register
                    ? SizedBox()
                    : FormTextField(
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () => _toggleObscured(false),
                        ),
                        controller: confirmPasswordController,
                        formKey: _formKey,
                        obscured: _obscureConfirmPassword,
                        hintText: "Confirm Password",
                        focusNode: textFieldFocusNode,
                      ),
                register?SizedBox(): Align(alignment: Alignment.bottomRight,child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: InkWell(
                    onTap: (){},
                    child: Text("forgot password?")),
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
                        onTap: () {},
                        child: Center(
                          child: Text(
                            register ? "Register" : "login",
                            style: GoogleFonts.varelaRound(
                                color: Colors.white, fontSize: 19),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: toggleSignin,
                      child: Text(register
                          ? "Login instead"
                          : "No account? Register now"),
                    ),
                  ),
                ),
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
                              style:
                                  GoogleFonts.varelaRound(color: Colors.white),
                            )),
                          ))
                    ],
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   Column(
                     children: [
                       SizedBox(height: 30,width: 30,child: Image.asset("assets/google.png",fit: BoxFit.fill,),),
                       Text("Google")
                     ],
                   ),
                  // Container(height: 40,width: 1,color: Colors.black,),
                  // SizedBox(width: 20,),
               Column(
                 children: [
                   SizedBox(height: 30,width: 30,child: Image.asset("assets/facebook.png",fit: BoxFit.fill,),),
                   Text("facebook")
                 ],
               )
             
                ],)
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class FormTextField extends StatelessWidget {
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String hintText;
  final FocusNode focusNode;
  final TextInputType inputType;
  final bool obscured;
  const FormTextField({
    Key? key,
    this.prefixIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    required this.controller,
    required this.formKey,
    this.hintText = "",
    required this.focusNode,
    this.inputType = TextInputType.text,
    this.obscured = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10),
      child: TextFormField(
        keyboardType: inputType,
        obscureText: obscured,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xff8c261e)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Color.fromARGB(255, 66, 125, 145)),
          ),
        ),
      ),
    );
  }
}
