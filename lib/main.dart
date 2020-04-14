import 'dart:math';
import 'package:toast/toast.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OS Project',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<List<Proccesses>> processList = [];
List<Proccesses> oldArrival = [];
List<Proccesses> oldBurst = [];
List<Proccesses> process = [];
List<Proccesses> readyQ = [];
int highestStart = 0, longestLength = 0;

class _HomePageState extends State<HomePage> {
  String _myActivity, chosenType = '';

  @override
  void initState() {
    super.initState();
    _myActivity = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 4,
        title: Text('OS Project'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 16.0, top: 16.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "NAME",
                                    style: TextStyle(
                                      fontSize: 16,
                                      wordSpacing: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Arrival",
                                    style: TextStyle(
                                      fontSize: 16,
                                      wordSpacing: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "LENGTH",
                                    style: TextStyle(
                                      fontSize: 16,
                                      wordSpacing: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Priority",
                                    style: TextStyle(
                                      fontSize: 16,
                                      wordSpacing: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: process.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return process[index];
                              })
                        ],
                      ),
                    ),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16),
                      child: ListView(
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              setState(() {});
                              //function of showing alert
                              TextEditingController name =
                                      TextEditingController(),
                                  length = TextEditingController(),
                                  arrival = TextEditingController(),
                                  priority = TextEditingController();
                              // set up the button
                              Widget addButton = FlatButton(
                                child: Text("Add"),
                                onPressed: () {
                                  setState(() {
                                    if (name.text.isNotEmpty &&
                                        (double.parse(length.text) > 0 &&
                                            length.text.isNotEmpty) &&
                                        (arrival.text.isNotEmpty &&
                                            double.parse(arrival.text) >= 0) &&
                                        (priority.text.isNotEmpty &&
                                            double.parse(priority.text) >= 0)) {
                                      process.add(Proccesses(
                                        name: name.text,
                                        length: length.text,
                                        arrival: arrival.text,
                                        priority: priority.text,
                                        coloring: Color((Random().nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt() <<
                                                0)
                                            .withOpacity(1.0),
                                      ));
                                      Navigator.pop(context);
                                    } else {
                                      Toast.show(
                                          "Please Insert Everything", context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.BOTTOM);
                                    }
                                  });
                                },
                              );
                              Widget cancelButton = FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              );
                              // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                title: Text("Insert Process Properities"),
                                content: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        controller: name,
                                        keyboardType: TextInputType.text,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            labelText: "Process Name",
                                            hintText: "Process Name",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        controller: arrival,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: "Process Arrival Time",
                                            hintText: "Process Arrival Time",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        controller: length,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: "Process Length",
                                            hintText: "Process Length",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        controller: priority,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: "Process Priority",
                                            hintText: "Process Priority",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  addButton,
                                  cancelButton,
                                ],
                              );

                              // show the dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            child: Text(
                              'Add new process',
                              style: TextStyle(
                                fontSize: 16,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              setState(() {
                                process
                                    .sort((a, b) => a.name.compareTo(b.name));
                              });
                            },
                            child: Text(
                              'Sort Processes By Name',
                              style: TextStyle(
                                fontSize: 16,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              setState(() {
                                process.sort((a, b) => (double.parse(a.length))
                                    .compareTo(double.parse(b.length)));
                              });
                            },
                            child: Text(
                              'Sort Processes By Length',
                              style: TextStyle(
                                fontSize: 16,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              setState(() {
                                process.sort((a, b) => (double.parse(a.arrival))
                                    .compareTo(double.parse(b.arrival)));
                              });
                            },
                            child: Text(
                              'Sort Processes By Arrival',
                              style: TextStyle(
                                fontSize: 16,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              setState(() {
                                process.sort((a, b) =>
                                    (double.parse(a.priority))
                                        .compareTo(double.parse(b.priority)));
                              });
                            },
                            child: Text(
                              'Sort Processes By Priority',
                              style: TextStyle(
                                fontSize: 16,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                process.removeAt(0);
                              });
                            },
                            child: Text(
                              'Clear First Process',
                              style: TextStyle(
                                fontSize: 16,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                process.removeLast();
                              });
                            },
                            child: Text(
                              'Clear Last Process',
                              style: TextStyle(
                                fontSize: 16,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                process.clear();
                              });
                            },
                            child: Text(
                              'Clear Processes',
                              style: TextStyle(
                                fontSize: 16,
                                wordSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: DropDownFormField(
                              titleText: 'Types of schedulers supported',
                              hintText: 'Please choose a type',
                              value: _myActivity,
                              onSaved: (value) {
                                setState(() {
                                  _myActivity = value;
                                  globals.chosenScheduler = _myActivity;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _myActivity = value;
                                  globals.chosenScheduler = _myActivity;
                                });
                              },
                              dataSource: schedularTypes,
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              //draw gant chart by choosing scheduler type
                              if (globals.chosenScheduler != '') {
                                if (globals.chosenScheduler == "Round Robin") {
                                  setState(() {});
                                  //function of showing alert
                                  TextEditingController quantumTime =
                                      TextEditingController();
                                  // set up the button
                                  Widget addButton = FlatButton(
                                    child: Text("Add"),
                                    onPressed: () {
                                      setState(() {
                                        if (quantumTime.text.isNotEmpty &&
                                            double.parse(quantumTime.text) >
                                                0) {
                                          globals.quantum =
                                              quantumTime.text.toString();
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChartsDemo()),
                                          );
                                        } else {
                                          Toast.show(
                                              "Please Insert Quantum Time",
                                              context,
                                              duration: Toast.LENGTH_SHORT,
                                              gravity: Toast.BOTTOM);
                                        }
                                      });
                                    },
                                  );
                                  Widget cancelButton = FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Insert Quantum Time"),
                                    content: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: TextField(
                                            controller: quantumTime,
                                            keyboardType: TextInputType.text,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                                labelText: "Quantum Time",
                                                hintText: "Quantum Time",
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      addButton,
                                      cancelButton,
                                    ],
                                  );

                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                } else {
                                  if (process.length != 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChartsDemo()),
                                    );
                                  } else {
                                    Toast.show(
                                        "Please Insert Some Processes", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM);
                                  }
                                }
                              } else {
                                Toast.show(
                                    "Please Choose a Scheduler Type", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);
                              }
                            },
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Draw Chart',
                                style: TextStyle(
                                  fontSize: 16,
                                  wordSpacing: 1.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List schedularTypes = [
  {
    "display": "FCFS",
    "value": "FCFS",
  },
  {
    "display": "SJF Non Preemptive",
    "value": "SJF Non Preemptive",
  },
  {
    "display": "SJF Preemptive",
    "value": "SJF Preemptive",
  },
  {
    "display": "Priority Non Preemptive",
    "value": "Priority Non Preemptive",
  },
  {
    "display": "Priority Preemptive",
    "value": "Priority Preemptive",
  },
  {
    "display": "Round Robin",
    "value": "Round Robin",
  },
];

class Proccesses extends StatelessWidget {
  String name, start, length, arrival, priority;
  final Color coloring;
  Proccesses(
      {this.name,
      this.arrival,
      this.length,
      this.coloring,
      this.priority,
      this.start = '0'});
  final TextStyle words = TextStyle(fontSize: 14.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              "${this.name}",
              style: words,
            ),
          ),
          Expanded(flex: 1, child: Text("${this.arrival}", style: words)),
          Expanded(flex: 1, child: Text("${this.length}", style: words)),
          Expanded(flex: 1, child: Text("${this.priority}", style: words)),
        ],
      ),
    );
  }
}

// List<Widget> tableRows = [];
// List<SizedBox> sizedBoxes = [];

// class DrawChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     for (var i = 0; i < (highestStart + longestLength); i++) {
//       sizedBoxes.add(SizedBox(
//         child: FlatButton(onPressed: null, child: null),
//         width:
//             MediaQuery.of(context).size.width / (highestStart + longestLength),
//       ));
//     }
//     for (var i = 0; i < (process.length + 1); i++) {
//       tableRows.add(Row(
//         children: sizedBoxes,
//       ));
//     }
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Gantt Chart'),
//           centerTitle: true,
//           automaticallyImplyLeading: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             elevation: 20,
//             child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: ScrollPhysics(),
//                     itemCount: process.length,
//                     itemBuilder: (BuildContext ctxt, int index) {
//                       return process[index];
//                     })),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ChartsDemo extends StatefulWidget {
  //
  ChartsDemo() : super();

  final String title = "Gantt Chart";

  @override
  ChartsDemoState createState() => ChartsDemoState();
}

List<double> start = [];

class ChartsDemoState extends State<ChartsDemo> {
  //
  List<charts.Series> seriesList;
  List<Proccesses> temp = [];
  static List<charts.Series<Proccesses, String>> ganttElements = [];

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 16,
                  // size in Pts.
                  color: charts.MaterialPalette.white),
              labelOffsetFromAxisPx: 0,
              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
              // Tick and Label styling here.

              labelStyle: new charts.TextStyleSpec(
                  fontSize: 26, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  thickness: 4, color: charts.MaterialPalette.white))),
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      behaviors: [new charts.SeriesLegend()],
      barGroupingType: charts.BarGroupingType.stacked,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.stacked,
      ),
      animationDuration: Duration(milliseconds: 750),
    );
  }

  @override
  void initState() {
    super.initState();
    //FCFS
    if (globals.chosenScheduler == schedularTypes[0]['display']) {
      //sorting for first ararival
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      //adding dummy activities
      if (double.parse(process[0].arrival) != 0) {
        process.insert(
            0,
            Proccesses(
              arrival: '0',
              length: process[0].arrival,
              name: 'Dummy',
              start: '0',
              priority: '0',
            ));
      }
      //getting real start time
      double startDouble = 0;
      start.add(double.parse(process[0].arrival)); //start=0
      for (int i = 1; i < process.length; i++) {
        startDouble += double.parse(process[i - 1].length);
        start.add(startDouble); //array start
      }
      ///////////////////////////////////////////////////////////
      ///add dummy
      for (int i = 0; i < process.length; i++) {
        if (start[i] < double.parse(process[i].arrival)) {
          if (process[i].arrival != process[i - 1].arrival) {
            double newStart =
                (start[i - 1] + double.parse(process[i - 1].length));
            start.insert(i, newStart);
            process.insert(
                i,
                Proccesses(
                  arrival: newStart.toString(),
                  start: newStart.toString(),
                  name: "Dummy",
                  length:
                      (double.parse(process[i].arrival) - newStart).toString(),
                  priority: '0',
                ));
            start[i + 1] = double.parse(process[i].arrival) +
                double.parse(process[i].length);
            process[i + 1].start = (double.parse(process[i].arrival) +
                    double.parse(process[i].length))
                .toString();
          } else {
            start[i] += ((start[i - 1]) + double.parse(process[i - 1].length));
            process[i].start =
                (((start[i - 1]) + double.parse(process[i - 1].length)))
                    .toString();
          }
        }
      }
      for (var i = 0; i < process.length; i++) {
        processList.add([process[i]]);
      }
      for (var i = 0; i < processList.length; i++) {
        print(
            "name: ${processList[i][0].name}, arrival: ${start[i]}, length: ${processList[i][0].length}");
      }
      for (int i = 0; i < process.length; i++) {
        if (processList[i][0].name == "Dummy") {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            colorFn: (Proccesses operation, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        } else {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        }
      }
    }
    //SJF Non Preemptive
    else if (globals.chosenScheduler == schedularTypes[1]['display']) {
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      /////////////////SORTING BY PRIORITY//////////////////////////////////////////////

      for (var n = 0; n < process.length - 1; n++) {
        for (int i = 0; i < process.length - 1; i++) {
          if ((double.parse(process[i].length) >
                  double.parse(process[i + 1].length)) &&
              (double.parse(process[i].arrival) ==
                  double.parse(process[i + 1].arrival))) {
            Proccesses temp = Proccesses();
            temp.priority = process[i + 1].priority;
            temp.start = process[i + 1].start;
            temp.arrival = process[i + 1].arrival;
            temp.name = process[i + 1].name;
            temp.length = process[i + 1].length;
            process[i + 1] = process[i];
            process[i] = temp;
          }
        }
      }
      /////////////////////////////////////////////////////////////////////////////

      if (double.parse(process[0].arrival) > 0) {
        process.insert(
            0,
            Proccesses(
              name: 'Dummy',
              arrival: '0',
              start: '0',
              priority: '0',
              length: process[0].length,
            ));
        completion.insert(0,
            double.parse(process[0].length) + double.parse(process[0].arrival));
        turnAround.insert(0, completion[0] - double.parse(process[0].arrival));
        waitingTimeList.insert(
            0, turnAround[0] - double.parse(process[0].length));
      } else {
        completion.insert(0,
            double.parse(process[0].length) + double.parse(process[0].arrival));
        turnAround.insert(0, completion[0] - double.parse(process[0].arrival));
        waitingTimeList.insert(
            0, turnAround[0] - double.parse(process[0].length));
      }

      int i = 1, m = process.length, j;
      while (i < m) {
        for (j = i; j < process.length; j++) {
          if (double.parse(process[j].arrival) > completion[i - 1]) {
            break;
          }
        }
        //
        for (int n = 0; n < process.length - 1; n++) {
          for (int y = i; y < j - 1; y++) {
            if ((double.parse(process[y].length) >
                double.parse(process[y + 1].length))) {
              Proccesses temp = Proccesses();
              temp.priority = process[y + 1].priority;
              temp.start = process[y + 1].start;
              temp.arrival = process[y + 1].arrival;
              temp.name = process[y + 1].name;
              temp.length = process[y + 1].length;
              process[y + 1] = process[y];
              process[y] = temp;
            }
          }
        }
        //
        if (double.parse(process[i].arrival) > completion[i - 1]) {
          Proccesses dummy = Proccesses();
          dummy.name = 'Dummy';
          dummy.arrival = completion[i - 1].toString();
          dummy.start = completion[i - 1].toString();
          dummy.length =
              (double.parse(process[i].arrival) - completion[i - 1]).toString();
          dummy.priority = '0';
          process.insert(i, dummy);
          completion.insert(
              i, completion[i - 1] + double.parse(process[i].length));
          turnAround.insert(
              i, completion[i] - double.parse(process[i].arrival));
          waitingTimeList.insert(
              i, turnAround[i] - double.parse(process[i].length));
          i++;
          m++;
        } else if (m != i + 1) {
          completion.insert(
              i, completion[i - 1] + double.parse(process[i].length));
          turnAround.insert(
              i, completion[i] - double.parse(process[i].arrival));
          waitingTimeList.insert(
              i, turnAround[i] - double.parse(process[i].length));
          i++;
        } else {
          break;
        }
      }
      completion.insert(i, completion[i - 1] + double.parse(process[i].length));
      turnAround.insert(i, completion[i] - double.parse(process[i].arrival));
      waitingTimeList.insert(
          i, turnAround[i] - double.parse(process[i].length));

      for (int u = 0; u < process.length; u++) {
        processList.add([process[u]]);
      }
      // for (int i = 0; i < processList.length; i++) {
      //   print(
      //       "name: ${processList[i][0].name}, arrival: ${processList[i][0].arrival}, length: ${processList[i][0].length}");
      // }
      for (int i = 0; i < process.length; i++) {
        if (processList[i][0].name == "Dummy") {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            colorFn: (Proccesses operation, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        } else {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        }
      }
    }
    //SJF Preemptive
    else if (globals.chosenScheduler == schedularTypes[2]['display']) {
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      /////////////////SORTING BY PRIORITY//////////////////////////////////////////////

      for (var n = 0; n < process.length - 1; n++) {
        for (int i = 0; i < process.length - 1; i++) {
          if ((double.parse(process[i].length) >
                  double.parse(process[i + 1].length)) &&
              (double.parse(process[i].arrival) ==
                  double.parse(process[i + 1].arrival))) {
            Proccesses temp = Proccesses();
            temp.priority = process[i + 1].priority;
            temp.start = process[i + 1].start;
            temp.arrival = process[i + 1].arrival;
            temp.name = process[i + 1].name;
            temp.length = process[i + 1].length;
            process[i + 1] = process[i];
            process[i] = temp;
          }
        }
      }
      /////////////////////////////////////////////////////////////////////////////
      for (int i = 0; i < process.length; i++) {
        oldArrival.add(Proccesses(
          start: process[i].start,
          arrival: process[i].arrival,
          length: process[i].length,
          name: process[i].name,
          priority: process[i].priority,
        ));
        oldBurst.add(Proccesses(
          start: process[i].start,
          arrival: process[i].arrival,
          length: process[i].length,
          name: process[i].name,
          priority: process[i].priority,
        ));
      }
      if (double.parse(process[0].arrival) > 0) {
        process.insert(
            0,
            Proccesses(
              name: 'Dummy',
              arrival: '0',
              start: '0',
              priority: '0',
              length: process[0].length,
            ));
      }
      /////////////////////////////////////////////////////////////////////////////

      for (int i = 0; i < process.length - 1; i++) {
        for (int j = i; j < process.length - 1; j++) {
          if ((double.parse(process[j + 1].arrival) <
              (double.parse(process[i].arrival) +
                  double.parse(process[i].length)))) {
            if (double.parse(process[j + 1].length) <
                double.parse(process[i].length)) {
              String n = process[j + 1].name;
              String ar = process[j + 1].arrival;
              String ln = process[j + 1].length;
              readyQ.add(Proccesses(
                name: n,
                start: ar,
                length: ln,
                arrival: ar,
                priority: process[j + 1].priority,
              ));
              double length = (double.parse(process[i].length) +
                      double.parse(process[i].arrival)) -
                  double.parse(process[j + 1].arrival);
              String arvl = process[i].arrival;
              readyQ.add(Proccesses(
                  name: process[i].name,
                  length: length.toString(),
                  start: arvl,
                  arrival: arvl,
                  priority: process[i].priority));
              process[i].length = (double.parse(process[j + 1].arrival) -
                      double.parse(process[i].arrival))
                  .toString();
              process.removeAt(j + 1);
              readyQ.sort((a, b) =>
                  (double.parse(a.length)).compareTo(double.parse(b.length)));
              for (var n = 0; n < readyQ.length - 1; n++) {
                for (int s = 0; s < readyQ.length - 1; s++) {
                  if ((double.parse(readyQ[s].arrival) >
                          double.parse(readyQ[s + 1].arrival)) &&
                      (double.parse(readyQ[s].length) ==
                          double.parse(readyQ[s + 1].length))) {
                    Proccesses temp = Proccesses();
                    temp.priority = readyQ[s + 1].priority;
                    temp.start = readyQ[s + 1].start;
                    temp.arrival = readyQ[s + 1].arrival;
                    temp.name = readyQ[s + 1].name;
                    temp.length = readyQ[s + 1].length;
                    readyQ[s + 1] = readyQ[s];
                    readyQ[s] = temp;
                  }
                }
              }
              process.insert(i + 1, readyQ[0]);
              readyQ.removeAt(0);
              process[i + 1].arrival = (double.parse(process[i].length) +
                      double.parse(process[i].arrival))
                  .toString();
              break;
            } else {
              readyQ.add(process[j + 1]);
              process.removeAt(j + 1);
              j--;
              readyQ.sort((a, b) =>
                  (double.parse(a.length)).compareTo(double.parse(b.length)));
              for (int n = 0; n < readyQ.length - 1; n++) {
                for (int s = 0; s < readyQ.length - 1; s++) {
                  if ((double.parse(readyQ[s].arrival) >=
                          double.parse(readyQ[s + 1].arrival)) &&
                      (double.parse(readyQ[s].length) ==
                          double.parse(readyQ[s + 1].length))) {
                    Proccesses temp = Proccesses();
                    temp.priority = readyQ[s + 1].priority;
                    temp.start = readyQ[s + 1].start;
                    temp.arrival = readyQ[s + 1].arrival;
                    temp.name = readyQ[s + 1].name;
                    temp.length = readyQ[s + 1].length;
                    readyQ[s + 1] = readyQ[s];
                    readyQ[s] = temp;
                  }
                }
              }
            }
          } else {
            int here = 0;
            double time = double.parse(process[i].arrival) +
                double.parse(process[i].length);
            for (int m = i; m < process.length - 1; m++) {
              if (double.parse(process[m].arrival) <= time) {
                here = m;
              }
            }
            for (int w = i; w < here; w++) {
              readyQ.add(process[here]);
              process.removeAt(here);
              readyQ.sort((a, b) =>
                  (double.parse(a.length)).compareTo(double.parse(b.length)));
              for (int n = 0; n < readyQ.length - 1; n++) {
                for (int s = 0; s < readyQ.length - 1; s++) {
                  if ((double.parse(readyQ[s].arrival) >=
                          double.parse(readyQ[s + 1].arrival)) &&
                      (double.parse(readyQ[s].length) ==
                          double.parse(readyQ[s + 1].length))) {
                    Proccesses temp = Proccesses();
                    temp.priority = readyQ[s + 1].priority;
                    temp.start = readyQ[s + 1].start;
                    temp.arrival = readyQ[s + 1].arrival;
                    temp.name = readyQ[s + 1].name;
                    temp.length = readyQ[s + 1].length;
                    readyQ[s + 1] = readyQ[s];
                    readyQ[s] = temp;
                  }
                }
              }
            }
            process.insert(i + 1, readyQ[0]);
            readyQ.removeAt(0);
            process[i + 1].arrival = time.toString();
          }
        }
      }
      for (int a = 0; a < readyQ.length; a++) {
        Proccesses l = Proccesses();
        l = readyQ[a];
        l.arrival = (double.parse(process[process.length - 1].arrival) +
                double.parse(process[process.length - 1].length))
            .toString();
        process.add(l);
      }
      for (int u = 0; u < process.length; u++) {
        processList.add([process[u]]);
      }
      // for (int i = 0; i < processList.length; i++) {
      //   print(
      //       "name: ${processList[i][0].name}, arrival: ${processList[i][0].arrival}, length: ${processList[i][0].length}");
      // }
      for (int i = 0; i < process.length; i++) {
        if (processList[i][0].name == "Dummy") {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            colorFn: (Proccesses operation, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        } else {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        }
      }
    }
    //Priority Non Preemptive
    else if (globals.chosenScheduler == schedularTypes[3]['display']) {
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      /////////////////SORTING BY PRIORITY//////////////////////////////////////////////

      for (var n = 0; n < process.length - 1; n++) {
        for (int i = 0; i < process.length - 1; i++) {
          if ((double.parse(process[i].priority) >
                  double.parse(process[i + 1].priority)) &&
              (double.parse(process[i].arrival) ==
                  double.parse(process[i + 1].arrival))) {
            Proccesses temp = Proccesses();
            temp.priority = process[i + 1].priority;
            temp.start = process[i + 1].start;
            temp.arrival = process[i + 1].arrival;
            temp.name = process[i + 1].name;
            temp.length = process[i + 1].length;
            process[i + 1] = process[i];
            process[i] = temp;
          }
        }
      }
      /////////////////////////////////////////////////////////////////////////////

      if (double.parse(process[0].arrival) > 0) {
        process.insert(
            0,
            Proccesses(
              name: 'Dummy',
              arrival: '0',
              start: '0',
              priority: '0',
              length: process[0].length,
            ));
        completion.insert(0,
            double.parse(process[0].length) + double.parse(process[0].arrival));
        turnAround.insert(0, completion[0] - double.parse(process[0].arrival));
        waitingTimeList.insert(
            0, turnAround[0] - double.parse(process[0].length));
      } else {
        completion.insert(0,
            double.parse(process[0].length) + double.parse(process[0].arrival));
        turnAround.insert(0, completion[0] - double.parse(process[0].arrival));
        waitingTimeList.insert(
            0, turnAround[0] - double.parse(process[0].length));
      }

      int i = 1, m = process.length, j;
      while (i < m) {
        for (j = i; j < process.length; j++) {
          if (double.parse(process[j].arrival) > completion[i - 1]) {
            break;
          }
        }
        //
        for (int n = 0; n < process.length - 1; n++) {
          for (int y = i; y < j - 1; y++) {
            if ((double.parse(process[y].priority) >
                double.parse(process[y + 1].priority))) {
              Proccesses temp = Proccesses();
              temp.priority = process[y + 1].priority;
              temp.start = process[y + 1].start;
              temp.arrival = process[y + 1].arrival;
              temp.name = process[y + 1].name;
              temp.length = process[y + 1].length;
              process[y + 1] = process[y];
              process[y] = temp;
            }
          }
        }
        //
        if (double.parse(process[i].arrival) > completion[i - 1]) {
          Proccesses dummy = Proccesses();
          dummy.name = 'Dummy';
          dummy.arrival = completion[i - 1].toString();
          dummy.start = completion[i - 1].toString();
          dummy.length =
              (double.parse(process[i].arrival) - completion[i - 1]).toString();
          dummy.priority = '0';
          process.insert(i, dummy);
          completion.insert(
              i, completion[i - 1] + double.parse(process[i].length));
          turnAround.insert(
              i, completion[i] - double.parse(process[i].arrival));
          waitingTimeList.insert(
              i, turnAround[i] - double.parse(process[i].length));
          i++;
          m++;
        } else if (m != i + 1) {
          completion.insert(
              i, completion[i - 1] + double.parse(process[i].length));
          turnAround.insert(
              i, completion[i] - double.parse(process[i].arrival));
          waitingTimeList.insert(
              i, turnAround[i] - double.parse(process[i].length));
          i++;
        } else {
          break;
        }
      }
      completion.insert(i, completion[i - 1] + double.parse(process[i].length));
      turnAround.insert(i, completion[i] - double.parse(process[i].arrival));
      waitingTimeList.insert(
          i, turnAround[i] - double.parse(process[i].length));

      for (int u = 0; u < process.length; u++) {
        processList.add([process[u]]);
      }
      // for (int i = 0; i < processList.length; i++) {
      //   print(
      //       "name: ${processList[i][0].name}, arrival: ${processList[i][0].arrival}, length: ${processList[i][0].length}");
      // }
      for (int i = 0; i < process.length; i++) {
        if (processList[i][0].name == "Dummy") {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            colorFn: (Proccesses operation, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        } else {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        }
      }
    }
    //Priority Preemptive to be added here
    else if (globals.chosenScheduler == schedularTypes[4]['display']) {
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      /////////////////SORTING BY PRIORITY//////////////////////////////////////////////

      for (var n = 0; n < process.length - 1; n++) {
        for (int i = 0; i < process.length - 1; i++) {
          if ((double.parse(process[i].priority) >
                  double.parse(process[i + 1].priority)) &&
              (double.parse(process[i].arrival) ==
                  double.parse(process[i + 1].arrival))) {
            Proccesses temp = Proccesses();
            temp.priority = process[i + 1].priority;
            temp.start = process[i + 1].start;
            temp.arrival = process[i + 1].arrival;
            temp.name = process[i + 1].name;
            temp.length = process[i + 1].length;
            process[i + 1] = process[i];
            process[i] = temp;
          }
        }
      }
      /////////////////////////////////////////////////////////////////////////////
      for (int i = 0; i < process.length; i++) {
        oldArrival.add(Proccesses(
          start: process[i].start,
          arrival: process[i].arrival,
          length: process[i].length,
          name: process[i].name,
          priority: process[i].priority,
        ));
        oldBurst.add(Proccesses(
          start: process[i].start,
          arrival: process[i].arrival,
          length: process[i].length,
          name: process[i].name,
          priority: process[i].priority,
        ));
      }
      if (double.parse(process[0].arrival) > 0) {
        process.insert(
            0,
            Proccesses(
              name: 'Dummy',
              arrival: '0',
              start: '0',
              priority: '0',
              length: process[0].length,
            ));
      }
      /////////////////////////////////////////////////////////////////////////////

      for (int i = 0; i < process.length - 1; i++) {
        for (int j = i; j < process.length - 1; j++) {
          if ((double.parse(process[j + 1].arrival) <
              (double.parse(process[i].arrival) +
                  double.parse(process[i].length)))) {
            if (double.parse(process[j + 1].priority) <
                double.parse(process[i].priority)) {
              String n = process[j + 1].name;
              String ar = process[j + 1].arrival;
              String ln = process[j + 1].length;
              readyQ.add(Proccesses(
                name: n,
                start: ar,
                length: ln,
                arrival: ar,
                priority: process[j + 1].priority,
              ));
              double length = (double.parse(process[i].length) +
                      double.parse(process[i].arrival)) -
                  double.parse(process[j + 1].arrival);
              String arvl = process[i].arrival;
              readyQ.add(Proccesses(
                  name: process[i].name,
                  length: length.toString(),
                  start: arvl,
                  arrival: arvl,
                  priority: process[i].priority));
              process[i].length = (double.parse(process[j + 1].arrival) -
                      double.parse(process[i].arrival))
                  .toString();
              process.removeAt(j + 1);
              readyQ.sort((a, b) => (double.parse(a.priority))
                  .compareTo(double.parse(b.priority)));
              for (var n = 0; n < readyQ.length - 1; n++) {
                for (int s = 0; s < readyQ.length - 1; s++) {
                  if ((double.parse(readyQ[s].arrival) >
                          double.parse(readyQ[s + 1].arrival)) &&
                      (double.parse(readyQ[s].priority) ==
                          double.parse(readyQ[s + 1].priority))) {
                    Proccesses temp = Proccesses();
                    temp.priority = readyQ[s + 1].priority;
                    temp.start = readyQ[s + 1].start;
                    temp.arrival = readyQ[s + 1].arrival;
                    temp.name = readyQ[s + 1].name;
                    temp.length = readyQ[s + 1].length;
                    readyQ[s + 1] = readyQ[s];
                    readyQ[s] = temp;
                  }
                }
              }
              process.insert(i + 1, readyQ[0]);
              readyQ.removeAt(0);
              process[i + 1].arrival = (double.parse(process[i].length) +
                      double.parse(process[i].arrival))
                  .toString();
              break;
            } else {
              readyQ.add(process[j + 1]);
              process.removeAt(j + 1);
              j--;
              readyQ.sort((a, b) => (double.parse(a.priority))
                  .compareTo(double.parse(b.priority)));
              for (var n = 0; n < readyQ.length - 1; n++) {
                for (int s = 0; s < readyQ.length - 1; s++) {
                  if ((double.parse(readyQ[s].arrival) >
                          double.parse(readyQ[s + 1].arrival)) &&
                      (double.parse(readyQ[s].priority) ==
                          double.parse(readyQ[s + 1].priority))) {
                    Proccesses temp = Proccesses();
                    temp.priority = readyQ[s + 1].priority;
                    temp.start = readyQ[s + 1].start;
                    temp.arrival = readyQ[s + 1].arrival;
                    temp.name = readyQ[s + 1].name;
                    temp.length = readyQ[s + 1].length;
                    readyQ[s + 1] = readyQ[s];
                    readyQ[s] = temp;
                  }
                }
              }
            }
          } else {
            int here = 0;
            double time = double.parse(process[i].arrival) +
                double.parse(process[i].length);
            for (int m = i; m < process.length - 1; m++) {
              if (double.parse(process[m].arrival) <= time) {
                here = m;
              }
            }
            for (int w = i; w < here; w++) {
              readyQ.add(process[here]);
              process.removeAt(here);
              readyQ.sort((a, b) => (double.parse(a.priority))
                  .compareTo(double.parse(b.priority)));
              for (var n = 0; n < readyQ.length - 1; n++) {
                for (int s = 0; s < readyQ.length - 1; s++) {
                  if ((double.parse(readyQ[s].arrival) >
                          double.parse(readyQ[s + 1].arrival)) &&
                      (double.parse(readyQ[s].priority) ==
                          double.parse(readyQ[s + 1].priority))) {
                    Proccesses temp = Proccesses();
                    temp.priority = readyQ[s + 1].priority;
                    temp.start = readyQ[s + 1].start;
                    temp.arrival = readyQ[s + 1].arrival;
                    temp.name = readyQ[s + 1].name;
                    temp.length = readyQ[s + 1].length;
                    readyQ[s + 1] = readyQ[s];
                    readyQ[s] = temp;
                  }
                }
              }
            }
            process.insert(i + 1, readyQ[0]);
            readyQ.removeAt(0);
            process[i + 1].arrival = time.toString();
          }
        }
      }
      for (int a = 0; a < readyQ.length; a++) {
        Proccesses l = Proccesses();
        l = readyQ[a];
        l.arrival = (double.parse(process[process.length - 1].arrival) +
                double.parse(process[process.length - 1].length))
            .toString();
        process.add(l);
      }
      for (int u = 0; u < process.length; u++) {
        processList.add([process[u]]);
      }
      // for (int i = 0; i < processList.length; i++) {
      //   print(
      //       "name: ${processList[i][0].name}, arrival: ${processList[i][0].arrival}, length: ${processList[i][0].length}");
      // }
      for (int i = 0; i < process.length; i++) {
        if (processList[i][0].name == "Dummy") {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            colorFn: (Proccesses operation, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        } else {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        }
      }
    }
    //Round Robin
    else if (globals.chosenScheduler == schedularTypes[5]['display']) {
      String quantumTimeGot = globals.quantum;
      int loop = process.length, here = 0;
      bool found = false;
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      if (double.parse(process[0].arrival) != 0) {
        process.insert(
            0,
            Proccesses(
              arrival: '0',
              length: process[0].arrival,
              name: 'Dummy',
              start: '0',
              priority: '0',
            ));
      }
      for (int i = 0; i < process.length; i++) {
        oldArrival.add(Proccesses(
          start: process[i].start,
          arrival: process[i].arrival,
          length: process[i].length,
          name: process[i].name,
          priority: process[i].priority,
        ));
        oldBurst.add(Proccesses(
          start: process[i].start,
          arrival: process[i].arrival,
          length: process[i].length,
          name: process[i].name,
          priority: process[i].priority,
        ));
      }

      for (int i = 0; i < loop - 1; i++) {
        if ((double.parse(process[i].length) > double.parse(quantumTimeGot)) &&
            process[i].name != 'Dummy') {
          double x =
              double.parse(process[i].length) - double.parse(quantumTimeGot);
          process[i].length = (double.parse(quantumTimeGot)).toString();
          double y =
              double.parse(process[i].arrival) + double.parse(quantumTimeGot);
          for (int j = i + 1; j < loop; j++) {
            if (double.parse(process[j].arrival) > y) {
              found = true;
              here = j;
              break;
            }
          }
          if (found) {
            process.insert(
                here,
                Proccesses(
                  name: process[i].name,
                  length: x.toString(),
                  arrival: y.toString(),
                  priority: '0',
                  start: '0',
                ));
            found = false;
          } else {
            process.add(Proccesses(
              name: process[i].name,
              length: x.toString(),
              arrival: y.toString(),
              priority: '0',
              start: '0',
            ));
          }
          if ((double.parse(process[i].arrival) +
                  double.parse(process[i].length)) <
              double.parse(process[i + 1].arrival)) {
            process.insert(
                i + 1,
                Proccesses(
                    name: 'Dummy',
                    arrival: (double.parse(process[i].length) +
                            double.parse(process[i].arrival))
                        .toString(),
                    start: (double.parse(process[i].length) +
                            double.parse(process[i].arrival))
                        .toString(),
                    priority: '0',
                    length: (double.parse(process[i + 1].arrival) -
                            (double.parse(process[i].length) +
                                double.parse(process[i].arrival)))
                        .toString()));
          } else {
            process[i + 1].arrival = (double.parse(process[i].length) +
                    double.parse(process[i].arrival))
                .toString();
          }
        } else {
          if ((double.parse(process[i].arrival) +
                  double.parse(process[i].length)) <
              double.parse(process[i + 1].arrival)) {
            process.insert(
                i + 1,
                Proccesses(
                    name: 'Dummy',
                    arrival: (double.parse(process[i].length) +
                            double.parse(process[i].arrival))
                        .toString(),
                    start: (double.parse(process[i].length) +
                            double.parse(process[i].arrival))
                        .toString(),
                    priority: '0',
                    length: (double.parse(process[i + 1].arrival) -
                            (double.parse(process[i].length) +
                                double.parse(process[i].arrival)))
                        .toString()));
          } else {
            process[i + 1].arrival = (double.parse(process[i].length) +
                    double.parse(process[i].arrival))
                .toString();
          }
        }
        loop = process.length;
      }
      for (int i = 0; i < process.length; i++) {
        processList.add([process[i]]);
      }
      // for (int i = 0; i < processList.length; i++) {
      //   print(
      //       "name: ${processList[i][0].name}, arrival: ${processList[i][0].arrival}, length: ${processList[i][0].length}");
      // }
      for (int i = 0; i < process.length; i++) {
        if (processList[i][0].name == "Dummy") {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            colorFn: (Proccesses operation, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        } else {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        }
      }
    }
    seriesList = ganttElements;
  }

  List<double> completion = [];
  List<double> turnAround = [];
  List<double> waitingTimeList = [];
  //calculation of average time
  double average() {
    int numberOfProcesses = 0;
    double waitingTime = 0;
    //FCFS Time Calculation
    if (globals.chosenScheduler == schedularTypes[0]['display']) {
      for (int i = 0; i < process.length; i++) {
        if (process[i].name != "Dummy") {
          numberOfProcesses++;
        }
        if (start[i] > double.parse(process[i].arrival)) {
          waitingTime += (start[i] - double.parse(process[i].arrival));
        }
      }
    }
    //SJF Non Primative Time Calculation
    else if (globals.chosenScheduler == schedularTypes[1]['display']) {
      for (var i = 0; i < process.length; i++) {
        if (process[i].name != "Dummy") {
          numberOfProcesses++;
        }
        waitingTime += waitingTimeList[i];
      }
    }
    //SJF Primative
    else if (globals.chosenScheduler == schedularTypes[2]['display']) {
      for (var i = 0; i < oldArrival.length; i++) {
        print(
            "Name: ${oldArrival[i].name}, Arrival: ${oldArrival[i].arrival}, Length: ${oldArrival[i].length}");
        if (oldArrival[i].name != "Dummy") {
          numberOfProcesses++;
        }
      }
      for (var i = 0; i < oldArrival.length; i++) {
        for (var j = 0; j < process.length; j++) {
          if (oldArrival[i].name == process[j].name) {
            oldArrival[i].length = (double.parse(oldArrival[i].length) -
                    double.parse(process[j].length))
                .toString();
            if (double.parse(oldArrival[i].length) == 0) {
              completion.add(double.parse(process[j].arrival) +
                  double.parse(process[j].length));
            }
          }
        }
      }
      for (int i = 0; i < oldArrival.length; i++) {
        waitingTime += (completion[i] -
            (double.parse(oldArrival[i].arrival) +
                double.parse(oldBurst[i].length)));
      }
    }
    //Priority Non Preemptive Time Calculation
    else if (globals.chosenScheduler == schedularTypes[3]['display']) {
      for (var i = 0; i < process.length; i++) {
        if (process[i].name != "Dummy") {
          numberOfProcesses++;
        }
        waitingTime += waitingTimeList[i];
      }
    }
    /////////////////////////////////////////////
    //Priority Primative
    else if (globals.chosenScheduler == schedularTypes[4]['display']) {
      for (var i = 0; i < oldArrival.length; i++) {
        print(
            "Name: ${oldArrival[i].name}, Arrival: ${oldArrival[i].arrival}, Length: ${oldArrival[i].length}");
        if (oldArrival[i].name != "Dummy") {
          numberOfProcesses++;
        }
      }
      for (var i = 0; i < oldArrival.length; i++) {
        for (var j = 0; j < process.length; j++) {
          if (oldArrival[i].name == process[j].name) {
            oldArrival[i].length = (double.parse(oldArrival[i].length) -
                    double.parse(process[j].length))
                .toString();
            if (double.parse(oldArrival[i].length) == 0) {
              completion.add(double.parse(process[j].arrival) +
                  double.parse(process[j].length));
            }
          }
        }
      }
      for (int i = 0; i < oldArrival.length; i++) {
        waitingTime += (completion[i] -
            (double.parse(oldArrival[i].arrival) +
                double.parse(oldBurst[i].length)));
      }
    }
    //Round Robin Time Calculation
    else if (globals.chosenScheduler == schedularTypes[5]['display']) {
      for (var i = 0; i < oldArrival.length; i++) {
        print(
            "Name: ${oldArrival[i].name}, Arrival: ${oldArrival[i].arrival}, Length: ${oldArrival[i].length}");
        if (oldArrival[i].name != "Dummy") {
          numberOfProcesses++;
        }
      }
      for (int i = 0; i < oldArrival.length; i++) {
        for (int j = 0; j < process.length; j++) {
          if (oldArrival[i].name == process[j].name) {
            oldArrival[i].length = (double.parse(oldArrival[i].length) -
                    double.parse(process[j].length))
                .toString();
            if (double.parse(oldArrival[i].length) == 0) {
              completion.add(double.parse(process[j].arrival) +
                  double.parse(process[j].length));
            }
          }
        }
      }
      for (int i = 0; i < oldArrival.length; i++) {
        waitingTime += (completion[i] -
            (double.parse(oldArrival[i].arrival) +
                double.parse(oldBurst[i].length)));
      }
    }
    return waitingTime / numberOfProcesses;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                seriesList.clear();
                ganttElements.clear();
                processList.clear();
                start.clear();
                temp.clear();
                completion.clear();
                readyQ.clear();
                oldBurst.clear();
                oldArrival.clear();
                turnAround.clear();
                waitingTimeList.clear();
                globals.chosenScheduler = '';
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 20,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text('Average Waiting time= ${average()} ms'),
                    ),
                    Expanded(
                      flex: 9,
                      child: barChart(),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

/*
if (globals.chosenScheduler == schedularTypes[0]['display']) {
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      for (int i = 0; i < process.length - 1; i++) {
        if (double.parse(process[0].arrival) != 0) {
          process.insert(
              0,
              Proccesses(
                name: 'Dummy',
                length: process[i].arrival,
                arrival: '0',
                priority: '0',
                coloring: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                    .withOpacity(1.0),
              ));
        } else {
          if (double.parse(process[i + 1].arrival) >
              (double.parse(process[i].arrival) +
                  double.parse(process[i].length))) {
            double dummyIndex = double.parse(process[i + 1].arrival) -
                (double.parse(process[i].arrival) +
                    double.parse(process[i].length));
            startDouble = double.parse(process[i].arrival);
            startDouble += double.parse(process[i - 1].length);
            setState(() {
              process.insert(
                  i + 1,
                  Proccesses(
                    name: 'Dummy',
                    priority: '0',
                    length: dummyIndex.toString(),
                    arrival: startDouble.toString(),
                    coloring:
                        Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                            .withOpacity(1.0),
                  ));
            });
          }
        }
      }
      for (int i = 0; i < process.length; i++) {
        if (process.length != 1) {
          print(
              '${process[i].name}, ${process[i].length}, ${process[i].arrival}');
          processList.add([
            Proccesses(
              name: process[i].name,
              length: process[i].length,
              arrival: process[i].arrival,
              priority: process[i].priority,
              coloring: process[i].coloring,
            )
          ]);
        } else {
          if (process[0].arrival == "0") {
            processList.add([
              Proccesses(
                name: process[i].name,
                length: process[i].length,
                priority: process[i].priority,
                arrival: process[i].arrival,
                coloring: process[i].coloring,
              )
            ]);
          } else {
            process.insert(
                0,
                Proccesses(
                  name: 'Dummy',
                  length: process[0].arrival,
                  arrival: '0',
                  coloring: process[0].coloring,
                  //dummy priority
                  priority: '0',
                ));
            for (int i = 0; i < process.length; i++) {
              processList.add([process[i]]);
            }
          }
        }
      }
      for (int i = 0; i < process.length; i++) {
        if (processList[i][0].name == "Dummy") {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            colorFn: (Proccesses operation, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        } else {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        }
      }
    }
    //SJF
    if (globals.chosenScheduler == schedularTypes[1]['display']) {
      //ordering the inputs with respect to arrival and length===\\
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      for (var i = 0; i < process.length; i++) {
        for (var j = 0; j < process.length; j++) {
          if ((double.parse(process[i].length) <
                  double.parse(process[j].length)) &&
              (double.parse(process[i].arrival) ==
                  double.parse(process[j].arrival))) {
            temp.insert(0, process[i]);
            process[i] = process[j];
            process[j] = temp[0];
          }
        }
        //=========================================================\\
      }
      for (int i = 0; i < process.length - 1; i++) {
        if (double.parse(process[0].arrival) != 0) {
          process.insert(
              0,
              Proccesses(
                name: 'Dummy',
                length: process[i].arrival,
                arrival: '0',
                priority: '0',
                coloring: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                    .withOpacity(1.0),
              ));
        } else {
          if (double.parse(process[i + 1].arrival) >
              (double.parse(process[i].arrival) +
                  double.parse(process[i].length))) {
            double dummyIndex = double.parse(process[i + 1].arrival) -
                (double.parse(process[i].arrival) +
                    double.parse(process[i].length));
            setState(() {
              process.insert(
                  i + 1,
                  Proccesses(
                    name: 'Dummy',
                    priority: '0',
                    length: dummyIndex.toString(),
                    arrival: (double.parse(process[i].arrival) +
                            double.parse(process[i].length))
                        .toString(),
                    coloring:
                        Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                            .withOpacity(1.0),
                  ));
            });
          }
        }
      }
      //============================================================================\\
      start.add(double.parse(process[0].arrival));
      for (int i = 1; i < process.length; i++) {
        if (process[i].name=="Dummy") {
           startDouble = double.parse(process[i-1].length)+start[i-1];
        }
        else{
          startDouble += double.parse(process[i - 1].length);
        }
        start.add(startDouble);
      }
      for (int i = 0; i < process.length; i++) {
        if (process.length != 1) {
          if (process[i].name=="Dummy") {
             processList.add([
            Proccesses(
              name: process[i].name,
              arrival: i==0? process[i].arrival:(start[i-1]+double.parse(process[i-1].length)).toString(),
              length: i==0?process[i].length:start[i].toString(),
              priority: process[i].priority,
              coloring: process[i].coloring,
            )
          ]);
          }else{
             processList.add([
            Proccesses(
              name: process[i].name,
              length: process[i].length,
              arrival: start[i].toString(),
              priority: process[i].priority,
              coloring: process[i].coloring,
            )
          ]);
          }
          print(
              '${processList[i][0].name}, ${processList[i][0].arrival}, ${processList[i][0].length}');
        } else {
          if (process[0].arrival == "0") {
            processList.add([
              Proccesses(
                name: process[i].name,
                length: process[i].length,
                priority: process[i].priority,
                arrival: process[i].arrival,
                coloring: process[i].coloring,
              )
            ]);
          } else {
            process.insert(
                0,
                Proccesses(
                  name: 'Dummy',
                  length: process[0].arrival,
                  arrival: '0',
                  coloring: process[0].coloring,
                  //dummy priority
                  priority: '0',
                ));
            for (int i = 0; i < process.length; i++) {
              processList.add([process[i]]);
            }
          }
        }
      }
      //====================================================================\\
      for (int i = 0; i < process.length; i++) {
        if (processList[i][0].name == "Dummy") {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            colorFn: (Proccesses operation, _) =>
                charts.ColorUtil.fromDartColor(Colors.black),
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        } else {
          ganttElements.add(charts.Series<Proccesses, String>(
            id: '${process[i].name}',
            domainFn: (Proccesses operation, _) => 'Start',
            measureFn: (Proccesses operation, _) =>
                double.parse(process[i].length),
            data: processList[i],
            labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
          ));
        }
      }
    }
    seriesList = ganttElements;
  }
  double startDouble = 0, length = 0, waitingTime = 0;
  double average() {
    double numberOfProcesses = 0;
    //FCFS average time calculation
    if (globals.chosenScheduler == schedularTypes[0]['display'] ||
        globals.chosenScheduler == schedularTypes[1]['display']) {
      process.sort((a, b) =>
          (double.parse(a.arrival)).compareTo(double.parse(b.arrival)));
      start.add(double.parse(process[0].arrival)); //start=0
      for (int i = 1; i < process.length; i++) {
        startDouble += double.parse(process[i - 1].length);
        start.add(startDouble);
      }
      for (int i = 0; i < process.length; i++) {
        waitingTime += start[i] - double.parse(process[i].arrival);
      }
    }
    for (int i = 0; i < process.length; i++) {
      if (process[i].name != "Dummy") {
        numberOfProcesses++;
      }
    }
    for (int i = 0; i < process.length; i++) {
      print(
          'Name: ${process[i].name}, Arrival: ${process[i].arrival}, Length: ${process[i].length}, Priority: ${process[i].priority}\n');
    }
    return waitingTime / numberOfProcesses;
*/
