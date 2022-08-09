// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:digital_identity_ui/RepoLayer/Models/LocationModel.dart';
import 'package:digital_identity_ui/ServiceLayer/http_client_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/otp_form_field.dart';

ValueNotifier<String> code = ValueNotifier("");

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder(
          valueListenable: code,
          builder: (context, value, child) {
            return SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
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
                    height: 50,
                  ),
                  Text(
                    "OTP Verification",
                    style: GoogleFonts.varelaRound(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      "Enter verification code sent to your Email in the field provided",
                      style: GoogleFonts.varelaRound(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8c261e),
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        6,
                        (index) => OtpFormField(
                              index: index,
                            )),
                  ),
                  SizedBox(
                    height: 70,
                  ),
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
                          //onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder:( context)=>OtpVerificationPage())),
                          onTap: () async {
                            var res = await HttpClientUtil(
                                    baseUrl:"https://e13f-197-232-61-198.eu.ngrok.io/api",
                                    endpoint: "location/get-all-locations")
                                .getListAsync<LocationModel>(
                              (json) => LocationModel.fromJson(json),
                            );
                            for (var i in res) {
                              print(jsonEncode(i));
                            }
                            print(code.value);
                          },
                          child: Center(
                            child: Text(
                              "Verify",
                              style: GoogleFonts.varelaRound(
                                  color: Colors.white,
                                  fontSize: 19,
                                  letterSpacing: 1.2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn't Receive Code? ",
                          style: GoogleFonts.varelaRound(
                              fontWeight: FontWeight.bold)),
                      InkWell(
                        onTap: () {},
                        child: Text("Resend",
                            style: GoogleFonts.varelaRound(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff8c261e))),
                      )
                    ],
                  )
                ],
              ),
            ));
          }),
    );
  }
}
