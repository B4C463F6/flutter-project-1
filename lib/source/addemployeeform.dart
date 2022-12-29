import 'dart:developer';

import 'package:flutter/material.dart';

import 'employeeController.dart';
import 'strings.dart';

class AddEmployeeForm extends StatefulWidget {
  final Function changeShowState;
  final Function changeLoadingState;
  const AddEmployeeForm(
      {required this.changeShowState,
      required this.changeLoadingState,
      super.key});

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  final _controller = AddEmployeeController();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contactController = TextEditingController();

  // String validateCell(phone) {
  //   final regex = RegExp(
  //       r'((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}');
  //   if (regex.hasMatch(phone) && phone.length == 10) {
  //     return '';
  //   }
  //   return "Please Enter Valid Contact";
  // }

  void validateCode(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final isNameAlreadyExist = await _controller.doesNameAlreadyExist(
        nameController.text,
        contactController.text,
      );
      if (isNameAlreadyExist) {
        widget.changeShowState();
      } else {
        widget.changeLoadingState();
        final response = await _controller.addEmployee(
          name: nameController.text,
          contact: contactController.text,
        );

        if (response == 200) {
          widget.changeLoadingState();
          widget.changeShowState();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.all(16),
        // padding: EdgeInsets.only(
        //   top: 16,
        //   left: 16,
        //   right: 16,
        //   bottom: MediaQuery.of(context).viewInsets.bottom,
        //   // bottom: 16,
        // ),
        child: Form(
          key: formKey,
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
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    labelText: 'Enter Name',
                    hintText: 'Enter Name',
                    prefixIcon: const Icon(
                      Icons.person_add,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 3) {
                      return "Enter a value";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: contactController,
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    labelText: 'Enter Contact',
                    hintText: 'Enter Contact',
                    prefixIcon: const Icon(
                      Icons.contact_phone_outlined,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}')
                            .hasMatch(value)) {
                      return "Please Enter Proper Contact";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: const BoxDecoration(
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
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
