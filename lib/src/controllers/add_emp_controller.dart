import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/src/constants/strings.dart';
import 'package:firebase_crud/src/models/response.dart';

import '../models/employee.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection =
    _firestore.collection(Strings.firebase_path);
final _fireStore = FirebaseFirestore.instance;

class AddEmployeeController {
  Future<Map<String, dynamic>> getEmployeeData() async {
    QuerySnapshot querySnapshot =
        await _fireStore.collection(Strings.firebase_path).get();

    // Get data from docs and convert map to List
    if (querySnapshot.docs.isNotEmpty) {
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      final Map<String, dynamic> response = {
        "count": allData.length,
        "data": allData
      };
      return response;
    }
    return {};
  }

  Future<int> addEmployee({
    required String name,
    required String contact,
  }) async {
    DocumentReference documentReference = _Collection.doc();
    log("Sterted this");
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
}
