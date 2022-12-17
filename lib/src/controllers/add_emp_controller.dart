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
  Future<String> getEmployeeData() async {
    QuerySnapshot querySnapshot =
        await _fireStore.collection(Strings.firebase_path).get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    log('$allData');
    return '';
  }

  Future<Response> addEmployee({
    required String name,
    required String position,
    required String contact,
  }) async {
    Response response = Response();
    DocumentReference documentReference = _Collection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      "name": 'Rahul',
      "contact": "263528736"
    };
    await documentReference.set(data).whenComplete(() {
      response.code = 200;
      response.message = 'Successfullt Added';
    }).catchError((e) {
      response.code = 400;
      response.message = "Cannot add due to error";
    });

    return response;
  }
}
