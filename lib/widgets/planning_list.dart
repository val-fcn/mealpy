//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/menu.dart';
import '../services/menu_service.dart';

class PlanningList extends StatefulWidget {
  const PlanningList({super.key});

  @override
  State<PlanningList> createState() => _PlanningListState();
}

class _PlanningListState extends State<PlanningList> {
  String get _userId => FirebaseAuth.instance.currentUser!.uid;
  DateTime selectedDay = DateTime.now();
  List<Menu> menus = [];

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    MenuService().getAllMenus(_userId).then((value) {
      setState(() {
        menus = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _dateSlider(),
        const SizedBox(height: 16),
        _menuList(),
      ],
    );
  }

  Widget _dateSlider() {
    return TableCalendar(
      firstDay: DateTime.now().subtract(const Duration(days: 365)),
      lastDay: DateTime.now().add(const Duration(days: 365)),
      focusedDay: selectedDay,
      calendarFormat: CalendarFormat.week,
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      locale: 'fr_FR',
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        setState(
          () {
            this.selectedDay = selectedDay;
          },
        );
      },
    );
  }

  Widget _menuList() {
    if (menus.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Aucun menu trouvé pour cette date'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Ajouter un menu'),
          ),
        ],
      );
    }
    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (context, index) {
        return Text(menus[index].toString());
      },
    );
  }
}
