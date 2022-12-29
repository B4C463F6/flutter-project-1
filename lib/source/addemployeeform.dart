import 'package:flutter/material.dart';

import 'employeeController.dart';
import 'strings.dart';

class AddEmployeeForm extends StatefulWidget {
  const AddEmployeeForm({super.key});

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final _controller = AddEmployeeController();
  final nameController = TextEditingController();
  final contactController = TextEditingController();

  String validateCell(phone) {
    // log(phone);
    final regex = RegExp(
        r'((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}');
    // log('${regex.hasMatch(phone)}');
    if (regex.hasMatch(phone) && phone.length == 10) {
      return '';
    }

    return "Please Enter Valid Contact";
  }

  String isValidName(String name) {
    if (name.isNotEmpty && name.length > 3) {
      return '';
    }
    return "Please Enter proper Name";
  }

  void validateCode(BuildContext context) async {
    // final isAlreadyDataExists = await _controller.doesNameAlreadyExist(
    //     nameController.text, contactController.text);
    // if (isAlreadyDataExists) {
    //   nameController.clear();
    //   contactController.clear();
    //   return Navigator.pop(context);
    // }
    // final response = await _controller.addEmployee(
    //     name: nameController.text, contact: contactController.text);
    // if (response == 200) {
    //   nameController.clear();
    //   contactController.clear();
    //   return Navigator.pop(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: Colors.black,
              size: 50,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  labelText: 'Enter Name',
                  hintText: 'Enter Name',
                  prefixIcon: const Icon(Icons.person_add),
                  errorText: isValidName(nameController.text),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: contactController,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  labelText: 'Enter Contact',
                  hintText: 'Enter Contact',
                  errorText: validateCell(contactController.text),
                  prefixIcon: const Icon(Icons.contact_phone_outlined),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: TextButton.icon(
                onPressed: () => validateCode(context),
                label: const Text(
                  style: TextStyle(color: Colors.white),
                  Strings.submit,
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.all(13),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                icon: const Icon(
                  color: Colors.white,
                  Icons.add,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
