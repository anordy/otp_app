import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:oktoast/oktoast.dart';
import 'package:otp_app/pages/auth/otp_auth.dart';
import 'package:otp_app/utils/styles.dart';
import 'package:otp_app/utils/utils.dart';
import 'package:otp_app/widget/toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controller;

  String initialCountry = 'TZ';
  String phone;
  PhoneNumber number = PhoneNumber(isoCode: 'TZ');
requestOtp(String phoneNo) async {
    print("otp number");
    print('$phoneNo');
    print("====================");
    final Map<String, dynamic> _data = {'msisdn': '$phoneNo'};
    try {
      var url = Uri.parse("http://localhost:9988/api/request");
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'accept': 'application/json',
          },
          body: json.encode(_data));
      // print("=====  response body  ==");
      // print(response.body);

      // print(data);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String,dynamic> data = json.decode(response.body);
        print("*******  sms sent ******");
        print(data);
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OtpSignin()));
    //        showToastWidget(
    //   ToastWidget(
    //       color: Colors.white,
    //       image: "assets/images/checked.png",
    //       title: "success",656
    //       description: "code sent"),
    //   duration: Duration(seconds: 5),
    //   position: ToastPosition.top,
    // );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OtpSignin()));
      } else {
        print("====   is not logged in");
      }
    } catch (e) {
      print("-========errorr ========");
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Utils.displayHeight(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xff0D5384),
                  const Color(0xff072A42),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                tileMode: TileMode.repeated),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 25, right: 25),
            child: Form(
              key: formKey,
              // autovalidate: true,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFFFFFFFF),
                        ),
                        onPressed: () {}),
                    SizedBox(height: Utils.displayHeight(context) * 0.12),
                    Container(
                      height: Utils.displayHeight(context) / 2,
                      width: Utils.displayWidth(context),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 50),
                        child:
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Center(
                                child:
                                    Text("Sign In", style: Styles.headerLarge, ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 8.0, 10.0, 8.0),
                                    child: InternationalPhoneNumberInput(
                                      autoFocus: false,
                                      onInputChanged: (number) {
                                        print(number.phoneNumber);
                                        this.phone = number.phoneNumber;
                                        // print(_authProvider.setPhoneNumber.);
                                      },
                                      onInputValidated: (bool value) {
                                        print(value);
                                      },
                                      selectorConfig: SelectorConfig(
                                        selectorType:
                                            PhoneInputSelectorType.DIALOG,
                                      ),
                                      ignoreBlank: false,
                                      autoValidateMode:
                                          AutovalidateMode.disabled,
                                      selectorTextStyle:
                                          TextStyle(color: Colors.black),
                                      initialValue: number,
                                      //textFieldController: controller,
                                      formatInput: false,

                                      hintText: "716 121 689",
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      inputBorder: InputBorder.none,
                                      onSaved: (PhoneNumber number) {
                                        print('On Saved: $number');
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 100.0, top: 20),
                                child: Text(
                                  "Tap Continue to get a one time Login sent to you via sms.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 2,
                                      color: Color(0xFF414141)),
                                ),
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "Email to Sign in",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff002244)))
                                    ],
                                    text: "Or use",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.pushNamed(context, emailSignin);
                                  controller.text = '';
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.pushNamed(context, emailSignup);
                                  },
                                  child: Text(
                                    "Create an Account",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF0D5384)),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(height: Utils.displayHeight(context) * 0.12),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        height: 50,
                        minWidth: Utils.displayWidth(context),
                        color: Colors.blue,
                        child: Text(
                                "continue".toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                        onPressed: () {
                          requestOtp(this.phone);
                         print('phone number ${this.phone}');
          // Navigator.pushReplacement(
          // context, MaterialPageRoute(builder: (context) => OtpSignin()));
                        })
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
