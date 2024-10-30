import 'package:flutter/material.dart';

import '../models/planning.dart';

class PlanningList extends StatefulWidget {
  const PlanningList({super.key});

  @override
  State<PlanningList> createState() => _PlanningListState();
}

class _PlanningListState extends State<PlanningList> {
  final List<Planning> _plannings = [];
  late Widget content;

  @override
  void initState() {
    super.initState();
    content = _plannings.isNotEmpty
        ? ListView.builder(
            itemCount: _plannings.length,
            itemBuilder: (context, index) {
              return Text(_plannings[index].name);
            },
          )
        : const Center(
            child: Text('No plannings found'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content,
    );
  }
}
