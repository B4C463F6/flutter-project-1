import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/source/employeeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'employeeModel.dart';
import 'strings.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection =
    _firestore.collection(Strings.firebase_path);
final _fireStore = FirebaseFirestore.instance;

class AddEmployeeController {
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
      "isChecked": false,
    };
    try {
      await documentReference.set(data);
      return 200;
    } catch (e) {
      return 400;
    }
  }

  Future<void> getEmployeeDetails(BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> documentSnapshot =
          await _fireStore.collection(Strings.firebase_path).get();
      final employeeDetails = documentSnapshot.docs;
      for (var i = 0; i < employeeDetails.length; i++) {
        final temp = EmployeeModel.fromJson(employeeDetails[i].data());
        Provider.of<EmployeeProvider>(context, listen: false)
            .addEmployeeToList(temp);
      }
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

  Future<int> updateDateForSelected() async {
    return 200;
  }
}
