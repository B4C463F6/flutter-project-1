import 'package:firebase_crud/src/views/add_page/add_emp.dart';
import 'package:firebase_crud/src/views/home_page/home/home_screen.dart';
import 'package:firebase_crud/src/views/records_page/show_emp.dart';
import 'package:flutter/material.dart';
import '../../constants/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    HomeScreen(),
    ShowRecords(),
    AddEmployee(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.blue.shade100,
              surfaceTintColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )),
          child: NavigationBar(
            surfaceTintColor: Colors.transparent,
            height: 60,
            backgroundColor: Colors.transparent,
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              this.index = index;
            }),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home_filled),
                label: Strings.appHome,
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: Strings.empRecords,
              ),
              NavigationDestination(
                icon: Icon(Icons.add_circle_outline),
                selectedIcon: Icon(Icons.add_circle),
                label: Strings.addEmp,
              )
            ],
          ),
        ),
      ),
      body: screens[index],
    );
  }
}
