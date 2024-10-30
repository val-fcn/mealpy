import 'package:flutter/material.dart';

import '../data/planning_dummy_data.dart';
import '../models/planning.dart';
import 'new_planning.dart';

class PlanningList extends StatefulWidget {
  const PlanningList({super.key});

  @override
  State<PlanningList> createState() => _PlanningListState();
}

class _PlanningListState extends State<PlanningList> {
  late List<Planning> _plannings;
  final ScrollController _scrollController = ScrollController();
  late PlanningDay _selectedDay;

  @override
  void initState() {
    super.initState();
    _plannings = PlanningDummyData.plannings;
    _selectedDay = _plannings[0].days[0];
  }

  List<DateTime> _getDaysInRange() {
    if (_plannings.isEmpty) return [];

    final firstPlanning = _plannings[0];
    final List<DateTime> days = [];

    for (var day in firstPlanning.days) {
      days.add(day.date);
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (_plannings.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No plannings found'),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NewPlanning()),
                );
              },
              label: const Text('Add a planning'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      );
    } else {
      content = Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _getDaysInRange().length,
              itemBuilder: (context, index) {
                final day = _getDaysInRange()[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDay = _plannings[0].days[index];
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 7,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _selectedDay.date.day == day.day
                                ? Colors.purple.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Liste des menus
          Expanded(
            child: ListView.builder(
              itemCount: _selectedDay.meals.length,
              itemBuilder: (context, index) {
                final planning = _selectedDay;
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(planning.meals[index].name),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO : Navigation vers le détail du menu
                    },
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 160,
              margin: const EdgeInsets.all(16),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const NewPlanning()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Add a planning'),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: content,
    );
  }
}
