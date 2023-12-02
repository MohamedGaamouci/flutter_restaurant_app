import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/Admin/add_Item.dart';
import 'package:offi_memoire/Admin/shopping/shopping.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String pizza = "pizza";
  String burger = "burger";
  String plat = "plat";
  String boisson = "boisson";
  String tacos = "tacos";

  CollectionReference user = FirebaseFirestore.instance.collection("users");
  String UID =
      FirebaseAuth.instance.currentUser!.uid.toString(); //ther is a bug
  String? collectionName;
  List name = [];

  getdata() async {
    await user.where("UID", isEqualTo: UID.toString()).get().then((value) {
      value.docs.forEach((element) {
        name.add(element.data());
      });
    });
    name.forEach((element) {
      collectionName = name[0]["name"].toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
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
        backgroundColor: Colors.orange[200],
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Shopping(collectionName: collectionName.toString()),
          )),
          backgroundColor: Colors.orange,
          // ignore: prefer_const_constructors
          child: Icon(Icons.shopping_bag,
              color: Colors.white,
              shadows: const [Shadow(color: Colors.orange, blurRadius: 10)]),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  "start_page", (Route<dynamic> route) => false),
              icon: Icon(Icons.home)),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "start_page", (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.logout))
          ],
          backgroundColor: Colors.orange[500],
          title: Center(
            child: Container(
              margin: EdgeInsets.only(left: 30),
              // ignore: prefer_const_constructors
              child: Text(
                "Admin space", textAlign: TextAlign.center,
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black54,
                  fontFamily: 'Signatra',
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              // ignore: prefer_const_constructors
              child: Text(
                "menu",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.black54,
                  fontFamily: 'Signatra',
                  letterSpacing: 3,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //contain meny images
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Add_Item(
                        catigorieName: pizza,
                        collectionName: collectionName.toString()),
                  )),
                  child: Column(
                    //contain one image
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.all(5),
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: const DecorationImage(
                                image: AssetImage(
                                  'images/menu/pizza.png',
                                ),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        // ignore: prefer_const_constructors
                        child: Text('Pizza',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black54,
                              fontFamily: 'Signatra',
                              letterSpacing: 3,
                            )),
                      )
                    ],
                  ),
                ),
                // ============================
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Add_Item(
                        catigorieName: burger,
                        collectionName: collectionName.toString()),
                  )),
                  child: Column(
                    //contain one image
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.all(5),
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: const DecorationImage(
                                image: AssetImage(
                                  'images/menu/burger.png',
                                ),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        // ignore: prefer_const_constructors
                        child: Text('Burger',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black54,
                              fontFamily: 'Signatra',
                              letterSpacing: 3,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // first row ==========================

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //contain meny images
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Add_Item(
                        catigorieName: plat,
                        collectionName: collectionName.toString()),
                  )),
                  child: Column(
                    //contain one image
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.all(5),
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: const DecorationImage(
                                image: AssetImage(
                                  'images/menu/plat.png',
                                ),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        // ignore: prefer_const_constructors
                        child: Text('The Dishes',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black54,
                              fontFamily: 'Signatra',
                              letterSpacing: 3,
                            )),
                      )
                    ],
                  ),
                ),
                // ============================
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Add_Item(
                        catigorieName: tacos,
                        collectionName: collectionName.toString()),
                  )),
                  child: Column(
                    //contain one image
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.all(5),
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: const DecorationImage(
                                image: AssetImage(
                                  'images/menu/tacos.png',
                                ),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        // ignore: prefer_const_constructors
                        child: Text('Tacos',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black54,
                              fontFamily: 'Signatra',
                              letterSpacing: 3,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            // ========================== socond row

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //contain meny images
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Add_Item(
                        catigorieName: boisson,
                        collectionName: collectionName.toString()),
                  )),
                  child: Column(
                    //contain one image
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.all(5),
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: Colors.black,
                            image: const DecorationImage(
                                image: AssetImage(
                                  'images/menu/boisson.png',
                                ),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      Container(
                        // ignore: prefer_const_constructors
                        child: Text('The Drinks',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black54,
                              fontFamily: 'Signatra',
                              letterSpacing: 3,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
