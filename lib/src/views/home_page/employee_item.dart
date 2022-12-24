import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmployeeItem extends StatefulWidget {
  final Map<String, dynamic> data;
  const EmployeeItem({required this.data, super.key});

  @override
  State<EmployeeItem> createState() => _EmployeeItemState();
}

class _EmployeeItemState extends State<EmployeeItem> {
  bool _checkbox = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white70,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: _checkbox,
                onChanged: (value) {
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
                  style: TextStyle(
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
