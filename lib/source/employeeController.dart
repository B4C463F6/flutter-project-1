import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/src/constants/strings.dart';
import 'package:firebase_crud/src/models/employeeModel.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection =
    _firestore.collection(Strings.firebase_path);
final _fireStore = FirebaseFirestore.instance;

class AddEmployeeController {
  final streamBuilderQuery =
      _fireStore.collection(Strings.firebase_path).snapshots();
}
