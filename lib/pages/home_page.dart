import 'package:flutter/material.dart';
import 'package:otp_app/utils/utils.dart';

class HomePage extends StatelessWidget {
  // const ({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: () {
          Navigator.pop(context);
        },),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff0D5384),title: Text('Promaids'),),
      body: Container(
        height: Utils.displayHeight(context),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: Center(child: Text('Welcome to Promaids The Otp Verification Call was sucessful.',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),)),
        )),
    );
  }
}