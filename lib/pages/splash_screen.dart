import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_app/pages/auth/login_pages.dart';
import 'package:otp_app/pages/home_page.dart';
import 'package:otp_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool("isLoggedIn");
    print(isLoggedIn);
    print("======token=======");
    print(sharedPreferences.getString("accessToken"));
    if (isLoggedIn != null && isLoggedIn) {
      print("islogged in");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print("islogged out");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    print("Init splash");
    // SharedPreferences.setMockInitialValues({});
    Future.delayed(const Duration(seconds: 3), () {
      _isUserLogin()();
      print("after splash");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (Container(
      height: Utils.displayHeight(context),
      width: Utils.displayWidth(context),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [const Color(0xff009FDA), const Color(0xff002244)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        //tileMode: TileMode.repeated,
      )),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 60.0),
        //   child: SvgPicture.asset('assets/icons/Laye.svg'),
        // ),
        SizedBox(height: Utils.displayHeight(context) * 0.4),
        RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: "MAIDS",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                      color: Color(0xFFFFFFFF)))
            ],
            text: "PRO",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
                color: Colors.grey[600]),
          ),
        ),
      ]),
    )));
  }
}
