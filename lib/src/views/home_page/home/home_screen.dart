import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/src/models/employeeModel.dart';
import 'package:firebase_crud/src/views/home_page/employee_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/strings.dart';
import '../../../controllers/add_emp_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = AddEmployeeController();
  late Future<List<EmployeeModel>?> _future;

  @override
  void initState() {
    // TODO: implement initState
    _future = _controller.getEmployeeDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appHome),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return docs.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              hintText: 'Search For a person',
                              prefixIcon: const Icon(Icons.search),
                              errorText: null,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final data = docs[index].data();
                              return EmployeeItem(
                                data: data,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                            itemCount: docs.length,
                          ),
                        ),
                      ],
                    ),
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
    );
  }
}
