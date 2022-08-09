// ignore_for_file: prefer_const_constructors

import 'package:digital_identity_ui/widgets/form_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoucheeRegistration extends StatefulWidget {
  const VoucheeRegistration({Key? key}) : super(key: key);

  @override
  State<VoucheeRegistration> createState() => _VoucheeRegistrationState();
}

class _VoucheeRegistrationState extends State<VoucheeRegistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firstName= TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController connectionId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff8c261e)),
                  child: Card(
                      margin: EdgeInsets.all(2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(CupertinoIcons.back),
                      ))),
                       SizedBox(
                      height: 30,
                    ),
                      Text("Vouchee Registration",style: GoogleFonts.varelaRound(fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8c261e),
                          letterSpacing: 1.2)),
                          SizedBox(height: 15,),
                          FormTextField(controller: firstName, formKey: _formKey,hintText: "first name",validator: (value){return value.isEmpty;},errorMessage: "first name should not be empty",),
                          FormTextField(controller: lastName, formKey: _formKey,hintText: "last name",validator: (value){return value.isEmpty;},errorMessage: "last name should not be empty",),
                          FormTextField(controller: nationality, formKey: _formKey,hintText: "nationality",validator: (value){return value.isEmpty;},errorMessage: "nationality should not be empty",)

        
            ],
          ),
        ),
      )),
    );
  }
}
