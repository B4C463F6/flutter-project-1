import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/source/addemployeeform.dart';
import 'package:firebase_crud/source/employeeModel.dart';
import 'package:firebase_crud/source/employeeProvider.dart';
import 'package:provider/provider.dart';
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
  final searchtextController = TextEditingController();
  late Future _getDetails;
  bool _show = false;
  bool _loading = false;
  Future<void> changeBottomSheetState() async {
    await _controller.getEmployeeDetails(context);
    setState(() {
      _show = !_show;
    });
  }

  void changeLoadingState() {
    setState(() {
      _loading = !_loading;
    });
  }

  void changeCheckedState(EmployeeModel data, bool value) {
    Provider.of<EmployeeProvider>(
      context,
      listen: false,
    ).updateIsChecked(data, value);
  }

  // void searchText(String value) {
  //   // final empData =
  //   //     Provider.of<EmployeeProvider>(context, listen: false).employeeList;
  // Provider.of<EmployeeProvider>(context, listen: false)
  //     .filterEmployee(searchText: value);
  // }

  @override
  void initState() {
    // TODO: implement initState
    // _controller.getEmployeeDetails(context);
    _getDetails = _controller.getEmployeeDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appHome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Search For a person',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _loading = false;
                    });
                  }
                  if (value.length >= 2) {
                    setState(() {
                      _loading = true;
                    });
                    Provider.of<EmployeeProvider>(context, listen: false)
                        .filterEmployee(searchText: value);
                  } else {
                    setState(() {
                      _loading = false;
                    });
                  }
                },
              ),
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Consumer<EmployeeProvider>(
                  builder: (context, employeeProvider, child) {
                    log("is this data :: ${employeeProvider.selectedEmp}");
                    if (employeeProvider.employees.isEmpty) {
                      return Text('no data');
                    }
                    return Expanded(
                      child: _loading
                          ? ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return EmployeeItem(
                                  data: employeeProvider.employees[index],
                                  isChecked: employeeProvider
                                      .employees[index].isChecked,
                                  changecheckStatus: changeCheckedState,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: employeeProvider.employees.length,
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return EmployeeItem(
                                  data: employeeProvider.employeeList[index],
                                  isChecked: employeeProvider
                                      .employees[index].isChecked,
                                  changecheckStatus: changeCheckedState,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 8,
                                );
                              },
                              itemCount: employeeProvider.employeeList.length,
                            ),
                    );
                  },
                );
              },
              future: _getDetails,
            ),
            // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return const Center(child: CircularProgressIndicator());
            //     }
            //     if (snapshot.hasData) {
            //       final EmpData =
            //           Provider.of<EmployeeProvider>(context).employees;
            //       final docs = snapshot.data!.docs;
            //       if (docs.isNotEmpty) {
            //         if (_loading) {
            //           return Expanded(
            //             child: ListView.separated(
            //               shrinkWrap: true,
            //               itemBuilder: (context, index) {
            //                 // final data = docs[index].data();
            //                 final data = EmpData[index];
            //                 // return EmployeeItem(
            //                 //   data: data as Map<String, dynamic>,
            //                 // );
            //                 return Container(
            //                   child: Text(data.name.toString()),
            //                 );
            //               },
            //               separatorBuilder: (context, index) {
            //                 return const SizedBox(
            //                   height: 8,
            //                 );
            //               },
            //               itemCount: EmpData.length,
            //             ),
            //           );
            //         } else {
            //           return Expanded(
            //             child: ListView.separated(
            //               shrinkWrap: true,
            //               itemBuilder: (context, index) {
            //                 final data = docs[index].data();
            //                 return EmployeeItem(
            //                   data: data,
            //                 );
            //               },
            //               separatorBuilder: (context, index) {
            //                 return const SizedBox(
            //                   height: 8,
            //                 );
            //               },
            //               itemCount: docs.length,
            //             ),
            //           );
            //         }
            //       } else {
            //         return const Center(
            //           child: Text('No Data'),
            //         );
            //       }
            //     }
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            //   stream: _controller.streamBuilderQuery,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (Provider.of<EmployeeProvider>(
                context,
                listen: false,
              ).selectedEmp.length >
              1) {
            final response = await _controller.updateDateForSelected();
            if (response == 200) {
              setState(() {});
            }
          } else {
            setState(() {
              _show = !_show;
            });
          }
        },
        child: Provider.of<EmployeeProvider>(
          context,
        ).selectedEmp.isNotEmpty
            ? const Icon(Icons.arrow_upward)
            : Icon(_show ? Icons.close : Icons.person_add_outlined),
      ),
      bottomSheet: _show
          ? BottomSheet(
              builder: (context) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: AddEmployeeForm(
                    changeShowState: changeBottomSheetState,
                    changeLoadingState: changeLoadingState,
                  ),
                );
              },
              enableDrag: false,
              onClosing: () {},
            )
          : const SizedBox(),
    );
  }
}
