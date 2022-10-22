import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference userRef =
    FirebaseFirestore.instance.collection("users");

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _ageController.text = documentSnapshot['age'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final String age = _ageController.text;
                    if (age != null && name != null) {
                      await userRef
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "age": age});
                      _nameController.text = '';
                      _ageController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder<QuerySnapshot>(
        builder: ((context, snapshot) {
          return Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(colors: [
              Color.fromARGB(251, 243, 94, 35),
              Color.fromARGB(227, 240, 99, 34),
              Color.fromARGB(199, 237, 105, 40),
            ])),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                return ListTile(
                  subtitle: Text("${snapshot.data!.docs[i]['age']}"),
                  leading: Text("${snapshot.data!.docs[i]['id']}"),
                  title: Text("${snapshot.data!.docs[i]['name']}"),
                  trailing: IconButton(
                    onPressed: () {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[i];
                      _update(documentSnapshot);
                    },
                    icon: const Icon(Icons.update),
                  ),
                );
              },
            ),
          );
        }),
        future: userRef.get(),
      ),
    );
  }
}
