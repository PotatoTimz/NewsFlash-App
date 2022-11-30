import 'package:flutter/material.dart';

class ViewPollStatistics extends StatefulWidget {
  const ViewPollStatistics({Key? key}) : super(key: key);

  @override
  State<ViewPollStatistics> createState() => _ViewPollStatisticsState();
}

class _ViewPollStatisticsState extends State<ViewPollStatistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poll's Data Table and Statistics Mode"),
      ),
    );
  }
}
