
import 'package:flutter/material.dart';

import 'package:shiftswift/login/login_home.dart';
import 'package:shiftswift/splash/two_splash.dart';





class OneSolash extends StatelessWidget {
  const OneSolash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 104, 177),
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 104, 177),
        title: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginHome()));
            },
            child: Text(
              "Skip",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 184, 181, 181)),
            )),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 48),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "S H I F T     S W I F T",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: 360,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image(
                          image: AssetImage("asstes/one.png"),
                          // استبدلها برابط الصورة الفعلي
                          height: 350,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("We make it easy for you to\nget the job!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white

                ),
                ),
                SizedBox(
                  height: 40,
                ),
             GestureDetector(
      onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) =>
            TwoSplash()
             ));
      },
      child: Container(
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10
            )
          ]
        ),
        child: Icon(Icons.arrow_forward,color: Color(0xFF0D1B2A), size: 30,),
      ),
             ),

                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
