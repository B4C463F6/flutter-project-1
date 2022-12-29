import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/src/constants/strings.dart';
import 'package:firebase_crud/src/models/employeeModel.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection =
    _firestore.collection(Strings.firebase_path);
final _fireStore = FirebaseFirestore.instance;

class AddEmployeeController {
  final List<EmployeeModel> employeeList = [];

  final streamBuilderQuery =
      _fireStore.collection(Strings.firebase_path).snapshots();
  Future<int> addEmployee({
    required String name,
    required String contact,
  }) async {
    DocumentReference documentReference = _Collection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "contact": contact,
    };
    try {
      await documentReference.set(data);
      return 200;
    } catch (e) {
      return 400;
    }
  }

  Future<List<EmployeeModel>?> getEmployeeDetails() async {
    try {
      QuerySnapshot<Map<String, dynamic>> documentSnapshot =
          await _fireStore.collection(Strings.firebase_path).get();
      final employeeDetails = documentSnapshot.docs;
      final List<EmployeeModel> empData = [];
      for (var i = 0; i < employeeDetails.length; i++) {
        final temp = EmployeeModel.fromJson(employeeDetails[i].data());
        empData.add(temp);
      }
      return empData;
    } catch (e) {
      log("ERROR IN GET EMP DETAILS:: $e");
    }
  }

  Future<bool> doesNameAlreadyExist(String name, String contact) async {
    final QuerySnapshot nameResult = await _fireStore
        .collection(Strings.firebase_path)
        .where('name', isEqualTo: name)
        .limit(1)
        .get();
    final QuerySnapshot contactResult = await _fireStore
        .collection(Strings.firebase_path)
        .where('contact', isEqualTo: contact)
        .limit(1)
        .get();
    final List<DocumentSnapshot> nameDocuments = nameResult.docs;
    final List<DocumentSnapshot> contactDocuments = contactResult.docs;
    if (nameDocuments.length == 1 || contactDocuments.length == 1) {
      return true;
    }
    return false;
  }

  void addEmployeeToselectedList(Map<String, dynamic> empData) {
    if (employeeList.contains(empData)) {
      log("It is already done");
    }
    final employeedata = EmployeeModel.fromJson(empData);
    employeeList.add(employeedata);
  }
}
