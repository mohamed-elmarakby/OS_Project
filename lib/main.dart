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

List<Proccesses> process = [];
List<Proccesses> sortedByStart = [];
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChartsDemo()),
                                );
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
    "display": "SJF",
    "value": "SJF",
  },
  {
    "display": "Priority",
    "value": "Priority",
  },
  {
    "display": "Round Robin",
    "value": "Round Robin",
  },
];

class Proccesses extends StatelessWidget {
  final String name, length, arrival, priority;
  final Color coloring;
  Proccesses(
      {this.name, this.arrival, this.length, this.coloring, this.priority});
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
    //adding Dummy Chart
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
      // process.sort((a, b) => a.arrival.compareTo(b.arrival));
      // process.sort((a, b) => a.length.compareTo(b.length));
      // for (int i = 0; i < process.length; i++) {
      //   processList.add([process[i]]);
      // }
      // for (int i = 0; i < process.length; i++) {
      //   ganttElements.add(charts.Series<Proccesses, String>(
      //     id: '${process[i].name}',
      //     domainFn: (Proccesses operation, _) => 'Start',
      //     measureFn: (Proccesses operation, _) =>
      //         double.parse(process[i].length),
      //     data: processList[i],
      //     labelAccessorFn: (Proccesses operation, _) => ('${operation.name}'),
      //   ));
      // }
    }
    seriesList = ganttElements;
  }

  double startDouble = 0, length = 0, waitingTime = 0;

  double average() {
    double numberOfProcesses = 0;

    //FCFS average time calculation
    if (globals.chosenScheduler == schedularTypes[0]['display']) {
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                processList.clear();
                ganttElements.clear();
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
