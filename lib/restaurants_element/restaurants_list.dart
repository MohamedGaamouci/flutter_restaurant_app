import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/restaurants_element/profile.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  GlobalKey<ScaffoldState> glblkey = GlobalKey<ScaffoldState>();
  String? havanatitle = 'Havana';
  String? havanaDescription = '4.3   ';
  String? manarchytitle = 'Manarchy';
  String? manarchyDescription = '4.3   ';
  String? odelicetitle = 'Odelice';
  String? odeliceDescription = '4.3   ';
  String? broastertitle = 'Broaster';
  String? broasterDescription = '4.3   ';

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
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
        key: glblkey,

        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text(
            "Restaurants",
            // ignore: prefer_const_constructors
            style: TextStyle(
              fontSize: 40,
              color: Color.fromARGB(255, 232, 139, 0),
              fontFamily: 'Signatra',
              letterSpacing: 3,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.dehaze,
              color: Color.fromARGB(255, 232, 139, 0),
            ),
            onPressed: () {
              glblkey.currentState?.openDrawer();
            },
          ),
        ),
        // ===============================================

        drawer: Drawer(
            child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 250,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    // color: Colors.orange,
                    image: const DecorationImage(
                        image: AssetImage('images/project_logo.png')),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25))),
                width: double.infinity,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      'home_page', (Route<dynamic> route) => false);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Card(
                    child: Row(children: [
                      // ignore: prefer_const_constructors
                      Padding(
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Icon(Icons.home, color: Color.fromARGB(255, 232, 139, 0)),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                      ),

                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[200]),
                      ),
                    ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  islogin == true
                      ? Navigator.of(context).pushNamedAndRemoveUntil(
                          'home_admin', (Route<dynamic> route) => false)
                      : Navigator.of(context).pushNamedAndRemoveUntil(
                          'Login', (Route<dynamic> route) => false);
                  ;
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Card(
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Icon(Icons.login,
                          color: Color.fromARGB(255, 232, 139, 0)),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[200]),
                      ),
                    ]),
                  ),
                ),
              ),
              InkWell(
                onTap: () => exit(0),
                child: Container(
                  margin: EdgeInsets.only(top: 7),
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Card(
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Icon(
                        Icons.exit_to_app,
                        color: Color.fromARGB(255, 232, 139, 0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                      ),
                      Text(
                        'Exit',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[200]),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        )),
        // ===============================================
        body: ListView(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(179, 190, 190, 190)),
              child: InkWell(
                onTap: () => setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Profile(restaurantName: "Havana"),
                  ));
                }),
                child: Container(
                  margin: EdgeInsets.all(10),
                  // height: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        child: PageView(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  'images/havana1.png',
                                  fit: BoxFit.fill,
                                )),
                            Container(
                                child: Image.asset('images/havana2.png',
                                    fit: BoxFit.fill)),
                            Image.asset('images/havana3.png', fit: BoxFit.fill),
                            Image.asset('images/havana4.png', fit: BoxFit.fill),
                            Image.asset('images/havana5.png', fit: BoxFit.fill),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(havanatitle.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(havanaDescription.toString(),
                                  style: TextStyle(fontSize: 22)),
                              Container(
                                  child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star_half,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                              Icon(Icons.restaurant)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ================
            Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(179, 190, 190, 190)),
              child: InkWell(
                onTap: () => setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Profile(restaurantName: "broaster"),
                  ));
                }),
                child: Container(
                  margin: EdgeInsets.all(10),
                  // height: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        child: PageView(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  'images/broaster/broaster_logo.png',
                                  fit: BoxFit.fill,
                                )),
                            Container(
                                child: Image.asset(
                                    'images/broaster/broaster1.png',
                                    fit: BoxFit.fill)),
                            Image.asset('images/broaster/broaster2.png',
                                fit: BoxFit.fill),
                            Image.asset('images/broaster/broaster3.png',
                                fit: BoxFit.fill),
                            Image.asset('images/broaster/broaster4.png',
                                fit: BoxFit.fill),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(broastertitle.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(broasterDescription.toString(),
                                  style: TextStyle(fontSize: 22)),
                              Container(
                                  child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star_half,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // =============

            Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(179, 190, 190, 190)),
              child: InkWell(
                onTap: () => setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Profile(restaurantName: "manarchy"),
                  ));
                }),
                child: Container(
                  margin: EdgeInsets.all(10),
                  // height: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        child: PageView(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  'images/manarchy/manarchy_logo.png',
                                  fit: BoxFit.fill,
                                )),
                            Container(
                                child: Image.asset(
                                    'images/manarchy/manarchy3.png',
                                    fit: BoxFit.fill)),
                            Image.asset('images/manarchy/manarchy1.png',
                                fit: BoxFit.fill),
                            Image.asset('images/manarchy/manarchy2.png',
                                fit: BoxFit.fill),
                            // Image.asset('', fit: BoxFit.fill),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(manarchytitle.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(manarchyDescription.toString(),
                                  style: TextStyle(fontSize: 22)),
                              Container(
                                  child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star_half,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // =============
            Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(179, 190, 190, 190)),
              child: InkWell(
                onTap: () => setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Profile(restaurantName: "odelice"),
                  ));
                }),
                child: Container(
                  margin: EdgeInsets.all(10),
                  // height: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        child: PageView(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  'images/odelice/odelice_logo.png',
                                  fit: BoxFit.fill,
                                )),
                            Container(
                                child: Image.asset(
                                    'images/odelice/odelice_logo.png',
                                    fit: BoxFit.fill)),
                            // Image.asset('images/havana3.png', fit: BoxFit.fill),
                            // Image.asset('images/havana4.png', fit: BoxFit.fill),
                            // Image.asset('images/havana5.png', fit: BoxFit.fill),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(odelicetitle.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(odeliceDescription.toString(),
                                  style: TextStyle(fontSize: 22)),
                              Container(
                                  child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star_half,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
