import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:semifinal/component/custom_button.dart';
import 'package:semifinal/component/text_field.dart';

final CollectionReference userRef =
    FirebaseFirestore.instance.collection("users");

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color.fromARGB(255, 231, 117, 52),
            Color.fromARGB(255, 199, 84, 49),
            Color.fromARGB(255, 189, 85, 41),
          ],
        ),
      ),
      child: ListView(children: [
        const SizedBox(
          height: 20,
        ),
        Center(
            child: Text(
          "Add user information",
          style: Theme.of(context).textTheme.headline4!,
        )),
        const SizedBox(
          height: 40,
        ),
        Text_Field(
          TypeInput: "id",
          prefixIcon: const Icon(Ionicons.id_card),
          obscure: false,
          controller: idController,
        ),
        Text_Field(
          TypeInput: "name",
          prefixIcon: const Icon(Icons.person),
          obscure: false,
          controller: nameController,
        ),
        Text_Field(
          TypeInput: "age",
          prefixIcon: const Icon(Icons.view_agenda),
          obscure: false,
          controller: ageController,
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: MyButton(
              onTap: () {
                userRef.add({
                  "id": idController.text,
                  "name": nameController.text,
                  "age": ageController.text,
                });
              },
              text: "Add user"),
        )
      ]),
    );
  }
}
