import 'package:flutter/material.dart';
import 'package:semifinal/component/add.dart';
import 'package:semifinal/component/read_data.dart';
import 'package:semifinal/component/update.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 195, 122, 85),
          title: const Text('Admin Page'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Icon(Icons.read_more),
              Icon(Icons.add),
              Icon(Icons.update),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Read(),
            Add(),
            Update(),
          ],
        ),
      ),
    );
  }
}
