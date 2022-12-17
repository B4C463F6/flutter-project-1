import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class addEmployeeBottomSheet extends StatefulWidget {
  const addEmployeeBottomSheet({super.key});

  @override
  State<addEmployeeBottomSheet> createState() => _addEmployeeBottomSheetState();
}

class _addEmployeeBottomSheetState extends State<addEmployeeBottomSheet> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    log('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(),
        TextField(),
      ],
    );
  }
}
