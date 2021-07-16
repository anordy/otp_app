import 'dart:async';
import 'package:flutter/gestures.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:otp_app/pages/home_page.dart';
import 'package:otp_app/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpSignin extends StatefulWidget {
  _OtpSigninState createState() => _OtpSigninState();
}

class _OtpSigninState extends State<OtpSignin> {
  TextEditingController _controller = TextEditingController();

// bool _readOnly = true;

  // ..text = "123456";
  Timer _timer;

  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  String passwordText = '';
  
  

  // ignore: close_sinks
  // StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Container(
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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFFFFFFFF),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(height: Utils.displayHeight(context) * 0.1),
                  PinCodeTextField(
                    autoFocus: true,
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    showCursor: true,
                    obscureText: true,
                    obscuringCharacter: '*',
                    // obscuringWidget: Image.asset('assets/icons/logo.png'),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v.length < 1) {
                        return "code should be 6";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      activeColor: Color(0xff009FDA),
                      selectedFillColor: Colors.white,
                      selectedColor: Color(0xff009FDA),
                      fieldWidth: 40,
                      inactiveFillColor: Color(0xff009FDA),
                      inactiveColor: Color(0xff009FDA),
                      activeFillColor:
                          hasError ? Color(0xff009FDA) : Color(0xff009FDA),
                    ),
                    cursorColor: Colors.white,
                    // autoFocus: true,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,

                    // errorAnimationController: errorController,
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Color(0xff002244),
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        passwordText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  SizedBox(height: 15),
                  // Center(
                  //     child: Text(
                  //   _start > 0 ? "in $_start" : "now",
                  //   style: TextStyle(color: Colors.white),
                  // )),
                  SizedBox(height: 15),
                  Center(
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(text: "Didin't resend the code?  "),
                      TextSpan(
                          text: "RESEND ",
                           recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // if (_start == 0) {
                              //   setState(() {
                              //     _start = 30;
                              //   });
                              //   startTimer();
                              Navigator.pop(context);
                             
                             
                              print('***************object*************');
                            },
                          style: TextStyle(color: Color(0xff002244))),
                           TextSpan(
                          text: _start > 0 ? "in $_start" : "now",
                          style: TextStyle(
                              color: Color(0xff002244),
                              fontWeight: FontWeight.w400,
                              fontSize: 16))
                    ])),
                  ),
                  SizedBox(height: 25),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    minWidth: Utils.displayWidth(context),
                    color: Colors.blue,
                    child: Text(
                      "Verify",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                      // _verifyFirebase(this.widget.firebaseToken);
                      // signIn(context);
                      if (formKey.currentState.validate()) {
                        if (passwordText.length != 6) {
                        } else {
                          print('smsCode:  $passwordText');
                        
                          setState(() {
                            hasError = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 40),
                  Container(
                      height: Utils.displayHeight(context) * 0.45,
                      decoration: BoxDecoration(
                          // color: Colors.transparent
                          ),
                      // child:
                      //  CustomKeyboard(
                      //   onBackspace: () {
                      //     _backspace();
                      //   },
                      //   onTextInput: (String myText) {
                      //     _insertText(myText);
                      //   },
                      // )
                      
                      )
                ]),
          ),
        ),
      ),
    );
  }
}

