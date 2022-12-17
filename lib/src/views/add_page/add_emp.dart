import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/src/constants/strings.dart';
import 'package:firebase_crud/src/controllers/add_emp_controller.dart';
import 'package:flutter/material.dart';

import 'widgets/add_emp_bottom_sheet.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _controller = AddEmployeeController();

  @override
  void initState() {
    // TODO: implement initState
    _controller.getEmployeeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.addEmp),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => addEmployeeBottomSheet(),
            isDismissible: true,
          );
        },
        child: Text('hdbks'),
      ),
    );
  }
}
