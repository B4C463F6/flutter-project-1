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
    final isAlreadyDataExists = await _controller.doesNameAlreadyExist(
        nameController.text, contactController.text);
    if (isAlreadyDataExists) {
      nameController.clear();
      contactController.clear();
      return Navigator.pop(context);
    }
    final response = await _controller.addEmployee(
        name: nameController.text, contact: contactController.text);
    if (response == 200) {
      nameController.clear();
      contactController.clear();
      return Navigator.pop(context);
    }
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return docs.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      final data = docs[index].data();
                      return ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['contact']),
                      );
                    },
                    itemCount: docs.length,
                  )
                : const Center(
                    child: Text('No Data'),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        stream: _controller.streamBuilderQuery,
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
                            borderSide: const BorderSide(color: Colors.grey),
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
