import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/src/constants/strings.dart';
import 'package:firebase_crud/src/controllers/add_emp_controller.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _controller = AddEmployeeController();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late Future _getAllData;
  bool _loading = false;
  bool _validContact = true;
  bool _validName = true;
  bool validateCell(phone) {
    // log(phone);
    final regex = RegExp(
        r'((\+*)((0[ -]*)*|((91 )*))((\d{12})+|(\d{10})+))|\d{5}([- ]*)\d{6}');
    // log('${regex.hasMatch(phone)}');
    if (regex.hasMatch(phone)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getAllData = _controller.getEmployeeData();
    _controller.getEmployeeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.addEmp),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: FutureBuilder(
        future: _getAllData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }

          final data = snapshot.data as Map<String, dynamic>;
          return !_loading || data == null
              ? ListView.builder(
                  itemCount: data['count'],
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: Icon(Icons.list),
                        trailing: Text(
                          data['data'][index]['name'],
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("List item"));
                  },
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
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
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromARGB(255, 105, 105, 105),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
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
                          errorText:
                              _validName ? null : "Please Enter proper Name",
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
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          labelText: 'Enter Contact',
                          hintText: 'Enter Contact',
                          errorText:
                              // _validContact ? null : "Please Enter Valid Contact",
                              _validContact
                                  ? null
                                  : "Please Enter Valid Contact",
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
                        onPressed: () async {
                          setState(() {
                            _validName = nameController.text.isNotEmpty &&
                                nameController.text.length > 3;
                            _validContact =
                                validateCell(contactController.text);
                          });

                          if (_validContact && _validName) {
                            setState(() {
                              _loading = true;
                            });
                            final response = await _controller.addEmployee(
                              name: nameController.text,
                              contact: contactController.text,
                            );
                            Navigator.pop(context);
                            if (response == 200) {
                              setState(() {
                                _loading = false;
                              });
                            }
                          }
                        },
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
            isScrollControlled: true,
          );
        },
        child: const Icon(
          Icons.person_add_outlined,
        ),
      ),
    );
  }
}
