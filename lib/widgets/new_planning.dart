import 'package:flutter/material.dart';

import '../themes/theme.dart';

class NewPlanning extends StatefulWidget {
  const NewPlanning({super.key});

  @override
  State<NewPlanning> createState() => _NewPlanningState();
}

class _NewPlanningState extends State<NewPlanning> {
  DateTimeRange? selectedDateRange;

  void _showDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      initialDateRange: selectedDateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(
              const Duration(days: 7),
            ),
          ),
    );

    if (picked != null) {
      setState(
        () {
          selectedDateRange = picked;
        },
      );
    }
  }

  List<DateTime> _getDaysInRange() {
    if (selectedDateRange == null) return [];

    final days = <DateTime>[];
    var current = selectedDateRange!.start;

    while (current.isBefore(selectedDateRange!.end) ||
        current.isAtSameMomentAs(selectedDateRange!.end)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInRange();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppTheme.backgroundColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Créer un planning",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showDateRangePicker,
                child: Text(selectedDateRange == null
                    ? 'Sélectionner une période'
                    : '${selectedDateRange!.start.day}/${selectedDateRange!.start.month} - ${selectedDateRange!.end.day}/${selectedDateRange!.end.month}'),
              ),
            ),
            const SizedBox(height: 16),
            if (days.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    final day = days[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${day.day}/${day.month}/${day.year}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        // Vous pouvez ajouter ici d'autres widgets pour chaque jour
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
