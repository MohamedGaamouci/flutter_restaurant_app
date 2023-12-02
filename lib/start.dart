import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class start extends StatefulWidget {
  const start({super.key});

  @override
  State<start> createState() => _startState();
}

class _startState extends State<start> {
  bool? islogin;
  @override
  void initState() {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      islogin = false;
    } else {
      islogin = true;
    }
    // TODO: implement initState
    super.initState();
  }

  Future<bool> _onPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        body: Center(
          child: Container(
            color: Color.fromARGB(255, 250, 218, 171),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 240, 211, 107),
                          spreadRadius: 1,
                          offset: Offset.fromDirection(double.maxFinite)),
                    ],
                    image: DecorationImage(
                        // fit: BoxFit.scaleDown,
                        image: AssetImage('images/project_logo.png')),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Delecious meal with ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black87,
                    fontFamily: 'Signatra',
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Fast Delevery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black87,
                    fontFamily: 'Signatra',
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Get your food delevery to you at the',
                ),
                Text(
                  'comfort at your home',
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("home_page");
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        padding:
                            EdgeInsets.symmetric(horizontal: 85, vertical: 11),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      islogin == true
                          ? Navigator.of(context).pushNamed("home_admin")
                          : Navigator.of(context).pushNamed("Login");
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 117, vertical: 11),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: Text('Login',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
