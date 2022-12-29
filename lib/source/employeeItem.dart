import 'dart:developer';

import 'package:firebase_crud/source/employeeProvider.dart';
import 'package:provider/provider.dart';

import 'employeeController.dart';
import 'employeeModel.dart';
import 'package:flutter/material.dart';

class EmployeeItem extends StatefulWidget {
  // final Map<String, dynamic> data;
  final EmployeeModel data;
  final bool isChecked;
  final Function changecheckStatus;
  const EmployeeItem(
      {required this.data,
      required this.isChecked,
      required this.changecheckStatus,
      super.key});

  @override
  State<EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends State<EmployeeItem> {
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
                value: widget.isChecked,
                onChanged: (value) {
                  setState(() {
                    widget.changecheckStatus(widget.data, value);
                  });
                  !widget.isChecked
                      ? Provider.of<EmployeeProvider>(
                          context,
                          listen: false,
                        ).addEmployeeToSelectedList(widget.data)
                      : Provider.of<EmployeeProvider>(
                          context,
                          listen: false,
                        ).removeEmployeeFromSelectedList(widget.data);
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // widget.data['name'],
                  widget.data.name ?? '',
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
                  widget.data.contact ?? '',
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
