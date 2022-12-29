import 'dart:developer';

import 'employeeModel.dart';
import 'package:flutter/cupertino.dart';

class EmployeeProvider extends ChangeNotifier {
  final List<EmployeeModel> employeeList = [];
  final List<EmployeeModel> selectedEmp = [];
  String employeeSearch = "";
  // List<EmployeeModel> get employees {
  //   return employeeList;
  // }
  List<EmployeeModel> get employees {
    if (employeeSearch == '') {
      return employeeList;
    } else {
      return employeeList
          .where(
            (e) => e.name!.toLowerCase().contains(
                  employeeSearch.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  void addEmployeeToList(EmployeeModel emp) {
    final bool productExists = employeeList.any((p) => p.name == emp.name);
    if (!productExists) {
      employeeList.add(emp);
    }
    notifyListeners();
  }

  void addEmployeeToSelectedList(EmployeeModel emp) {
    final bool empexists = selectedEmp.any((p) => p.name == emp.name);
    if (!empexists) {
      selectedEmp.add(emp);
    }
    notifyListeners();
  }

  void removeEmployeeFromSelectedList(EmployeeModel emp) {
    final bool productExists = selectedEmp.any((p) => p.name == emp.name);
    if (productExists) {
      selectedEmp.removeWhere(
        (p) => p.name == emp.name,
      );
      notifyListeners();
    }
  }

  void updateIsChecked(EmployeeModel emp, bool value) {
    // final bool productExists = employeeList.any((p) => p.name == emp.name);
    // log('podu  $productExists');
    // if (productExists) {
    employeeList[employeeList.indexWhere((element) => element.name == emp.name)]
        .isChecked = value;

    notifyListeners();
    // }
  }

  void filterEmployee({String searchText = ''}) {
    employeeSearch = searchText;
    notifyListeners();
  }
}
