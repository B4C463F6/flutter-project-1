import 'dart:developer';

import 'package:firebase_crud/src/controllers/add_emp_controller.dart';
import 'package:firebase_crud/src/models/employeeModel.dart';
import 'package:flutter/material.dart';

class EmployeeItem extends StatefulWidget {
  final Map<String, dynamic> data;
  const EmployeeItem({required this.data, super.key});

  @override
  State<EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends State<EmployeeItem> {
  bool _checkbox = false;
  final employeeController = AddEmployeeController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: _checkbox,
                onChanged: (value) {
                  employeeController.addEmployeeToselectedList(widget.data);
                  setState(() {
                    _checkbox = value as bool;
                  });
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.data['contact'],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
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
