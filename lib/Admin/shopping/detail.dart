import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/Admin/element_of_menu_with_addsign.dart';

class Shopping_Detail extends StatefulWidget {
  String collectionName;
  String id;
  Shopping_Detail({super.key, required this.collectionName, required this.id});

  @override
  State<Shopping_Detail> createState() =>
      _Shopping_DetailState(collectionName: collectionName, id: id);
}

class _Shopping_DetailState extends State<Shopping_Detail> {
  String collectionName;
  String id;
  _Shopping_DetailState({required this.collectionName, required this.id});
  @override
  void initState() {
    getData();
    super.initState();
  }

  List menu = [];
  getData() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection(collectionName)
        .doc("order")
        .collection("order");

    await ref.where("id", isEqualTo: id.toString()).get().then((value) {
      value.docs.forEach((element) {
        print("id :: $id");
        id = element.id;
        print("id :: $id");
      });
    }).then((value) async {
      ref = ref.doc(id.toString()).collection(id.toString());
      await ref.get().then((value) {
        value.docs.forEach((element) {
          setState(() {
            menu.add(element.data());
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[200],
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          title: const Center(
            child: Text(
              "Order Detail",
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
            return Element_of_menu(
              name: menu[index]["name"],
              price: menu[index]["price"],
              description: menu[index]["description"],
              imageURL: menu[index]["image"],
            );
          },
        ));
  }
}
