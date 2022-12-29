import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/source/addemployeeform.dart';
import 'employeeController.dart';
import 'package:flutter/material.dart';

import 'employeeItem.dart';
import 'strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = AddEmployeeController();
  bool _show = false;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _show = !_show;
          });
        },
        child: Icon(_show ? Icons.close : Icons.person_add_outlined),
      ),
      bottomSheet: _show
          ? BottomSheet(
              builder: (context) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: const AddEmployeeForm(),
                );
              },
              enableDrag: false,
              onClosing: () {
                log('closeddd');
              },
            )
          : const SizedBox(),
    );
  }
}
