import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groupproject/models/Polls.dart';
import 'package:groupproject/views/DatabaseEditors.dart';
import 'package:pie_chart/pie_chart.dart';
import 'ViewPollStatistics.dart';

/*
 PollsPageBuilder creates a list of polls based on the data found within the firebase
 database "polls".
 Data stored like "description", "title", etc are all found within the database and are
 converted into Poll types which are than displayed to the user through a listview
 @author Andre Alix
 @version Final - Group Project
 @since 2022-12-06
 */

// Stores boolean used to determine whether the user has already voted for the
// specific poll
List voted = [];

class PollsPageBuilder extends StatefulWidget {
  const PollsPageBuilder({Key? key}) : super(key: key);

  @override
  State<PollsPageBuilder> createState() => _PollsPageBuilderState();
}

/*
  PollsPageBuilder creates a listview using snapshot instances found within the database.
  The data in the firebase is read and than converted into "Polls" class instances
  This is used to generate widgets containing a visual representation and for the user
  allowing them to view the results and to vote for any given poll
  On startup polls will display a question and a list of answers (2-4) the user may choose
  to answer once. After voting the user will no longer be allowed to vote and will be shown
  the current results for the poll
 */

class _PollsPageBuilderState extends State<PollsPageBuilder> {

  final fireBaseInstance = FirebaseFirestore.instance.collection('polls');
  int pollSelectedIndex = 10^100;

  // Collects data from the firebase database and generates "polls"
  // Also creates the button to alternatively view polls in a datatable or frequency chart
  // Poll data will be either displayed in voting mode or viewing mode.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fireBaseInstance.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (!snapshot.hasData) {
            print("Data is missing from buildGradeList");
            return CircularProgressIndicator();
          }
          else{
            print("Poll Data Loaded!");
            for (int i = 0; i <snapshot.data.docs.length; i ++){
              voted.add(false);
            }

            return ListView(
              children: [

                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewPollStatistics(pollData: snapshot.data.docs,))
                      );
                },
                    child: Text("View Data Table Mode")
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    Polls poll = Polls.fromMap(snapshot.data.docs[index].data(), reference: snapshot.data.docs[index].reference);
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey),),

                          child: Container(
                            decoration: BoxDecoration(color: pollSelectedIndex != index ? Colors.white : Colors.black12 ),
                            padding: const EdgeInsets.all(15),
                            child: voted[index] == false ? buildPollView(poll, index, context) : buildPollResults(poll, index, context),

                          ),

                        )
                      ],
                    );
                  },
                ),
              ],
            );

          }
        }
    );
  }

  // Poll viewing mode
  // Displays poll information including the title, description, etc
  // As well as an option to delete and vote for the poll, voting will
  // change the poll to viewing mode where the poll's results will be shown
  // Poll's are shown in viewing mode by default
  Widget buildPollView(poll, index, context){
    return Column(
      children: [

        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 15,
                  child: Text("AA", textScaleFactor: 1),
                ),
                const SizedBox(width: 20),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        "${poll.userName}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    IconButton(
                      onPressed: () {
                        deleteDialog(context, index, fireBaseInstance);
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),

        Text(
            "${poll?.title}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30
            ),
            textAlign: TextAlign.center
        ),
        Text("${poll?.timeString}",
            style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15),
            textAlign: TextAlign.center
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "${poll?.description}",
            style: const TextStyle(fontSize: 15),
          ),
        ),
        const SizedBox(height: 10),

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: poll.pollOptions?.length,
          itemBuilder: (context, pollOptionsIndex){
            return GestureDetector(
              onTap: (){
                setState(() {
                  poll.pollResults?[pollOptionsIndex]++;
                  updatePollDatabase(index, poll, fireBaseInstance);
                  voted[index] = true;
                });
              },
              child:
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  poll.pollOptions![pollOptionsIndex],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ),
            );
          },
        )

      ],
    );
  }

  // Poll Results Mode
  // Displays the results of a poll through a pie chart. Users will only be shown
  // the results of a poll after voting for the poll and will no longer be allowed
  // to vote again once they vote.
  Widget buildPollResults(poll, index, context){

    Map<String, double> dataMap = {};

    for (int i = 0; i < poll.pollOptions.length; i++){
      dataMap["${poll.pollOptions[i]}"] = poll.pollResults[i].toDouble();
    }

    return Column(
        children: [

          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    radius: 15,
                    child: Text("AA", textScaleFactor: 1),
                  ),
                  const SizedBox(width: 20),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          "${poll.userName}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      IconButton(
                        onPressed: () {
                          deleteDialog(context, index, fireBaseInstance);
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),

          Text(
              "${poll?.title}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 30
              ),
              textAlign: TextAlign.center
          ),
          Text("${poll?.timeString}",
              style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15),
              textAlign: TextAlign.center
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "${poll?.description}",
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 30),

          PieChart(
            dataMap : dataMap,
            chartType: ChartType.ring,
          ),
        ]
    );
  }

  // deleteDialog shows is shown by clicking the 3 dots button beside the username
  // This will prompt a dialog to appear asking the user whether they would like
  // to delete the post
  deleteDialog(context, index, fireBaseInstance){
    showDialog(context: context,
        barrierDismissible: false,                              //doesn't allow user to click of alert pop up
        builder: (context){
          return AlertDialog(
            title: const Text("Delete Post"),
            content: const Text("Are you sure you would like to delete this post"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")
              ),
              TextButton(
                  onPressed: (){
                    deleteOnlineDatabase(index, fireBaseInstance);
                    Navigator.of(context).pop();
                  },
                  child: Text("Delete")
              )
            ],
          );
        }
    );
  }

}

