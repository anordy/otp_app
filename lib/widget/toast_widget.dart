import 'package:flutter/material.dart';
 
class ToastWidget extends StatelessWidget {
  final Color color;
  final String image;
  final String title;
  final String description;
  const ToastWidget({@required this.color,@required this.image,@required this.title,@required this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      
        // alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            // width: 250.0,
            height: 85,
            color: color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                     Image.asset(image,height: 20,width: 20,),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    description,
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}