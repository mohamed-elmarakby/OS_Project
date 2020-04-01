import 'dart:math';
import 'package:toast/toast.dart';
import 'globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                                    "START",
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
                      child: Column(
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
                                  start = TextEditingController();
                              // set up the button
                              Widget addButton = FlatButton(
                                child: Text("Add"),
                                onPressed: () {
                                  setState(() {
                                    if (name.text.isNotEmpty &&
                                        (double.parse(length.text) > 0 &&
                                            length.text.isNotEmpty) &&
                                        (start.text.isNotEmpty &&
                                            double.parse(start.text) >= 0)) {
                                      process.add(Proccesses(
                                        name: name.text,
                                        length: length.text,
                                        start: start.text,
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
                                        controller: length,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
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
                                        controller: start,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "Process Start Time",
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
                                    .sort((a, b) => a.start.compareTo(b.start));
                              });
                            },
                            child: Text(
                              'Sort Processes',
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
                          Expanded(
                            child: SizedBox(),
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
                              //draw gant chart
                              for (var i = 0; i < process.length; i++) {
                                process
                                    .sort((a, b) => a.start.compareTo(b.start));
                                print(process[i].start);

                                // if (int.parse(process[i].start) >
                                //     highestStart) {
                                //   highestStart = int.parse(process[i].start);
                                // }
                                // if (int.parse(process[i].length) >
                                //     longestLength) {
                                //   longestLength = int.parse(process[i].length);
                                // }
                                // print(
                                //     'No. Process: ${process.length}, LL: $longestLength, HS: $highestStart');
                                // chosenType.length != 0
                                //     ? print(chosenType)
                                //     : print('nothing chosen');
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChartsDemo()),
                              );
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  final String name, length, start;
  final Color coloring;
  Proccesses({this.name, this.start, this.length, this.coloring});
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
          Expanded(flex: 1, child: Text("${this.length}", style: words)),
          Expanded(flex: 1, child: Text("${this.start}", style: words)),
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
    for (int i = 0; i < process.length; i++) {
      print('${process[i].name}, ${process[i].length}, ${process[i].start}');
      processList.add([
        Proccesses(
          name: process[i].name,
          length: process[i].length,
          start: process[i].start,
          coloring: process[i].coloring,
        )
      ]);
    }
    //FCFS
    if (globals.chosenScheduler == schedularTypes[0]['display']) {
      for (int i = 0; i < process.length; i++) {
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
    seriesList = ganttElements;
  }

  double average() {
    double averageTime = 0;
    process.sort((a, b) => a.start.compareTo(b.start));
    for (var i = 0; i < process.length - 1; i++) {
      if (i == 0) {
        averageTime +=
            (double.parse(process[0].start) + double.parse(process[0].length));
      } else {
        averageTime += (averageTime + double.parse(process[i].length));
      }
    }
    return averageTime / (process.length);
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
                      child: Text('Average Waiting time= ${average()}'),
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
