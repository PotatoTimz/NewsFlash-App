import 'package:flutter/material.dart';
import '../../../models/Polls.dart';
import 'PollFrequencyTable.dart';

/*
 ViewPollStatistics displays polls using a data table containing the title of each of the
 polls as well as the amount of votes given to each option

 @author Andre Alix
 @version Final - Group Project
 @since 2022-12-06
 */
class ViewPollStatistics extends StatefulWidget {
  ViewPollStatistics({Key? key, this.pollData}) : super(key: key);

  var pollData;

  @override
  State<ViewPollStatistics> createState() => _ViewPollStatisticsState();
}

class _ViewPollStatisticsState extends State<ViewPollStatistics> {

  List<Polls> pollsList = [];

  /*
    On initialization will add options to polls that have less than 4 options
    to allow for smaller polls to be easily indicated within the data table
   */  @override
  void initState(){
    for(int i = 0; i < widget.pollData.length; i++){
      Polls poll = Polls.fromMap(widget.pollData[i].data(), reference: widget.pollData[i].reference);
      List<dynamic> tempPollOptions = ["No Option","No Option","No Option","No Option"];
      List<dynamic> tempPollResults = ["None","None","None","None"];
      for(int i = 0; i <poll.pollOptions!.length; i++){
        tempPollResults[i] = poll.pollResults![i];
        tempPollOptions[i] = poll.pollOptions![i];
      }
      poll.pollResults = tempPollResults;
      poll.pollOptions = tempPollOptions;
      pollsList.add(poll);
    }

  }

  /*
    Builds a data table that contains the results and the title of each poll
    The Data table will contain 5 columns (title and results (1-4)) and will be
    on display for the user. Option names can be indicated by holding on the option
    results and will change in correlation to each poll
    Polls with less than 4 options will display "None" for empty options
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poll's Statistics"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PollFrequencyTable(pollsList: pollsList)));
              },
              icon: Icon(Icons.insert_chart))
        ],
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          DataTable(
              columns: const [
                DataColumn(
                    tooltip: "Title Of Poll",
                    label: const Text("Title")
                ),
                DataColumn(
                    tooltip: "Amount of votes on this option",
                    label: const Text("Option 1")
                ),
                DataColumn(
                    tooltip: "Amount of votes on this option",
                    label: const Text("Option 2")
                ),
                DataColumn(
                    tooltip: "Amount of votes on this option",
                    label: const Text("Option 3")
                ),
                DataColumn(
                    tooltip: "Amount of votes on this option",
                    label: const Text("Option 4")
                ),
              ],
              rows: pollsList.map((Polls poll)=>DataRow(
                cells: [
                  DataCell(
                    Container(
                      child: Text(poll.title!),
                    )
                  ),
                  DataCell(
                      Tooltip(
                        message: poll.pollOptions![0].toString(),
                        child: Text(poll.pollResults![0].toString()),
                      )
                  ),
                  DataCell(
                      Tooltip(
                        message: poll.pollOptions![1].toString(),
                        child: Text(poll.pollResults![1].toString()),
                      )
                  ),
                  DataCell(
                      Tooltip(
                        message: poll.pollOptions![2].toString(),
                        child: Text(poll.pollResults![2].toString()),
                      )
                  ),
                  DataCell(
                      Tooltip(
                        message: poll.pollOptions![3].toString(),
                        child: Text(poll.pollResults![3].toString()),
                      )
                  ),
                ]
              )).toList()
          )
        ],
      ),
    );
  }
}
