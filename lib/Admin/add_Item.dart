import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/Admin/addProdect.dart';
import 'package:offi_memoire/Admin/one_element_menu_container.dart';

class Add_Item extends StatefulWidget {
  String catigorieName;
  String collectionName;
  Add_Item(
      {super.key, required this.catigorieName, required this.collectionName});

  @override
  State<Add_Item> createState() => _Add_ItemState(
      catigorieName: catigorieName, collectionName: collectionName);
}

class _Add_ItemState extends State<Add_Item> {
  String catigorieName;
  String collectionName;
  _Add_ItemState({required this.catigorieName, required this.collectionName});
  @override
  void initState() {
    getData();
    super.initState();
  }

  List menu = [];
  String imageNotFound =
      "https://firebasestorage.googleapis.com/v0/b/deleveryapp-eab92.appspot.com/o/fuel-sign-nhe-13784_1000_2.gif?alt=media&token=15ecb827-58f6-4dcd-a320-b485e7917708";

  void getData() async {
    CollectionReference restaurant_menu = FirebaseFirestore.instance
        .collection(collectionName.toString())
        .doc(catigorieName.toString())
        .collection(catigorieName.toString());
    await restaurant_menu.snapshots().listen((event) {
      menu.clear();
      event.docs.forEach((element) {
        setState(() {
          print("data :: ${element.data()}");
          menu.add(element.data());
        });
      });
    });
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
          appBar: AppBar(
            backgroundColor: Colors.orange[500],
            leading: IconButton(
                onPressed: () =>
                    Navigator.of(context).popAndPushNamed("home_admin"),
                icon: Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Add_Product(
                          collectionName: collectionName,
                          menuName: catigorieName),
                    ));
                  },
                  icon: Icon(Icons.add))
            ],
            title: const Center(
              child: Text(
                "Admin space",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black54,
                  fontFamily: 'Signatra',
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: menu.length,
            itemBuilder: (context, index) {
              if (menu[index]["image"].toString().isEmpty) {
                menu[index]["image"] = imageNotFound;
              }
              return Element_of_menu(
                name: menu[index]["name"],
                price: menu[index]["price"],
                description: menu[index]["description"],
                imageURL: menu[index]["image"],
                collectionName: collectionName,
                docName: catigorieName,
              );
            },
          )),
    );
  }
}
