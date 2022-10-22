import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:semifinal/screens/admin.dart';

final CollectionReference userRef =
    FirebaseFirestore.instance.collection("users");

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder<QuerySnapshot>(
        builder: ((context, snapshot) {
          final int count = snapshot.data!.docs.length;
          return Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color.fromARGB(251, 243, 94, 35),
                  Color.fromARGB(227, 240, 99, 34),
                  Color.fromARGB(199, 237, 105, 40),
                ],
              ),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
                thickness: 2,
              ),
              itemCount: count,
              itemBuilder: (context, i) {
                return ListTile(
                  subtitle: Text("${snapshot.data!.docs[i]['age']}"),
                  leading: Text("${snapshot.data!.docs[i]['id']}"),
                  title: Text("${snapshot.data!.docs[i]['name']}"),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: 100,
                              height: 100,
                              child: Column(
                                children: [
                                  const Text('Do you want delete this user??'),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          final docId =
                                              snapshot.data!.docs[i].id;
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(docId)
                                              .delete();
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const AdminPage();
                                            },
                                          ));
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete_forever),
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
