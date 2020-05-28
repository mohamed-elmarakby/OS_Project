import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'globals.dart' as globals;
import 'main.dart';
import 'package:charts_flutter/flutter.dart' as charts;

String memSize = 'Not Yet Defined';
String memoryLeft = '0';
List fitTypes = [
  {
    "display": "First Fit",
    "value": "First Fit",
  },
  {
    "display": "Best Fit",
    "value": "Best Fit",
  },
];

List<List<MemProcess>> memoryList = [];
List<MemProcess> memoryProcesses = [];
List<MemProcess> memoryHoles = [];

class MemoryAllocator extends StatefulWidget {
  @override
  _MemoryAllocatorState createState() => _MemoryAllocatorState();
}

class _MemoryAllocatorState extends State<MemoryAllocator> {
  String _myActivity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Allocator'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //back button reset everything here
            globals.fitType = '';
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, top: 16.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Process Name",
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
                                      "Segment Name",
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
                                      "Segment Size",
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
                                itemCount: memoryProcesses.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return memoryProcesses[index];
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, top: 16.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Start",
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
                                      "Size",
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
                                itemCount: memoryHoles.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return memoryHoles[index];
                                })
                          ],
                        ),
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
                          Text(
                            'Memory size = $memSize',
                            style: TextStyle(fontSize: 16),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              setState(() {});
                              //function of showing alert
                              TextEditingController capacity =
                                  TextEditingController();
                              // set up the button
                              Widget addButton = FlatButton(
                                child: Text("Add"),
                                onPressed: () {
                                  setState(() {
                                    if (capacity.text.isNotEmpty &&
                                        double.parse(capacity.text.toString()) >
                                            0) {
                                      memSize = capacity.text;
                                      memoryLeft = capacity.text;
                                      Navigator.pop(context);
                                    } else {
                                      Toast.show("Please Insert Size", context,
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
                                title: Text("Insert Memory Size"),
                                content: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        controller: capacity,
                                        keyboardType: TextInputType.number,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            labelText: "Memory Size",
                                            hintText: "Memory Size",
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
                              'Enter Memory Size',
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
                                setState(() {});
                                //function of showing alert
                                TextEditingController startingAddress =
                                        TextEditingController(),
                                    holeSize = TextEditingController();
                                // set up the button
                                Widget addButton = FlatButton(
                                  child: Text("Add"),
                                  onPressed: () {
                                    setState(() {
                                      if (startingAddress.text.isNotEmpty &&
                                          holeSize.text.isNotEmpty &&
                                          double.parse(startingAddress.text) >=
                                              0 &&
                                          double.parse(holeSize.text) > 0) {
                                        if (double.parse(startingAddress.text) +
                                                double.parse(holeSize.text) >
                                            double.parse(memSize)) {
                                          Toast.show(
                                              "Memory Limit Excedded Can't input this Hole",
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM);
                                        } else {
                                          memoryLeft = (double.parse(
                                                      memoryLeft) -
                                                  double.parse(holeSize.text))
                                              .toString();
                                          memoryHoles.add(MemProcess(
                                            pName: 'Hole',
                                            isHole: true,
                                            length: holeSize.text,
                                            start: startingAddress.text,
                                          ));
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        Toast.show(
                                            "Please Insert Correct Properities",
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
                                  title: Text("Insert Hole Properities"),
                                  content: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: TextField(
                                          controller: startingAddress,
                                          keyboardType: TextInputType.text,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                              labelText: "Starting Address",
                                              hintText: "Starting Address",
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
                                          controller: holeSize,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              labelText: "Size",
                                              hintText: "Size",
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
                              });
                            },
                            child: Text(
                              'Add a Hole',
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
                                setState(() {});
                                //function of showing alert
                                TextEditingController procName =
                                        TextEditingController(),
                                    numSegments = TextEditingController();
                                // set up the button
                                Widget addButton = FlatButton(
                                  child: Text("Next"),
                                  onPressed: () {
                                    setState(() {
                                      if (procName.text.isNotEmpty &&
                                          numSegments.text.isNotEmpty &&
                                          double.parse(numSegments.text) > 0) {
                                        for (var i = 0;
                                            i <= int.parse(numSegments.text);
                                            i++) {
                                          setState(() {
                                            showNextSegment(
                                                procName.text, context);
                                          });
                                        }
                                        Navigator.pop(context);
                                      } else {
                                        Toast.show(
                                            "Please Insert Correct Inputs",
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
                                  title: Text("Insert Process Properities"),
                                  content: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: TextField(
                                          controller: procName,
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
                                          controller: numSegments,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              labelText: "Number of Segments",
                                              hintText: "Number of Segments",
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
                              });
                            },
                            child: Text(
                              'Add a Process',
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
                              if (memoryProcesses.isNotEmpty) {
                                setState(() {
                                  TextEditingController dealloc =
                                      TextEditingController();
                                  Widget nextButton = FlatButton(
                                    child: Text('Deallocate'),
                                    onPressed: () {
                                      if (dealloc.text.isNotEmpty) {
                                        setState(() {
                                          for (var i = 0;
                                              i < memoryProcesses.length;
                                              i++) {
                                            if (memoryProcesses[i].pName ==
                                                dealloc.text.toString()) {
                                              memoryProcesses.removeAt(i);
                                              i = -1;
                                            }
                                          }
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                  );
                                  AlertDialog n = AlertDialog(
                                    title: Text(
                                        "Enter Process Name to Deallocate it"),
                                    content: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: TextField(
                                            controller: dealloc,
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
                                      ],
                                    ),
                                    actions: [nextButton],
                                  );

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return n;
                                    },
                                  );
                                });
                              } else {
                                Toast.show(
                                    "There are no Processes to Deallocate",
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            },
                            child: Text(
                              'Deallocate a Process',
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
                                memoryHoles.clear();
                              });
                            },
                            child: Text(
                              'Clear Holes',
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
                                memoryProcesses.clear();
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
                              titleText: 'Methods of Allocation',
                              hintText: 'Please choose a method',
                              value: _myActivity,
                              onSaved: (value) {
                                setState(() {
                                  _myActivity = value;
                                  globals.fitType = _myActivity;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  _myActivity = value;
                                  globals.fitType = _myActivity;
                                });
                              },
                              dataSource: fitTypes,
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: () {
                                //draw gant chart by choosing scheduler type
                                if (globals.fitType != '') {
                                  if (memoryProcesses.isNotEmpty ||
                                      memoryHoles.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Allocation()),
                                    );
                                  } else {
                                    Toast.show(
                                        "Please Insert at least a hole or a process",
                                        context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  }
                                } else {
                                  Toast.show(
                                      "Please Choose an Allocation Method",
                                      context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                }
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'Allocate Memory',
                                  style: TextStyle(
                                    fontSize: 16,
                                    wordSpacing: 1.5,
                                    fontWeight: FontWeight.w600,
                                  ),
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

  showNextSegment(String proc, BuildContext context) {
    TextEditingController segNamed = TextEditingController(),
        segSized = TextEditingController();
    Widget nextButton = FlatButton(
      child: Text('Next'),
      onPressed: () {
        if (segNamed.text.isNotEmpty &&
            segSized.text.isNotEmpty &&
            double.parse(segSized.text) > 0) {
          setState(() {
            memoryProcesses.add(MemProcess(
              isHole: false,
              pName: proc,
              sName: segNamed.text,
              length: segSized.text,
            ));
          });
          Navigator.pop(context);
        }
      },
    );
    AlertDialog n = AlertDialog(
      title: Text("Insert Segment Properities"),
      content: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: TextField(
              controller: segNamed,
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Segment Name",
                  hintText: "Segment Name",
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
              controller: segSized,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Segment Size",
                  hintText: "Segment Size",
                  border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
      actions: [nextButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return n;
      },
    );
  }
}

class MemProcess extends StatelessWidget {
  String pName, sName, start, length, arrival, priority;
  bool isHole;
  final Color coloring;
  MemProcess(
      {this.isHole,
      this.pName,
      this.sName,
      this.arrival,
      this.length,
      this.coloring,
      this.priority,
      this.start = '0'});
  final TextStyle words = TextStyle(fontSize: 14.0);
  @override
  Widget build(BuildContext context) {
    return isHole
        ? Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: Text("${this.start}", style: words)),
                Expanded(flex: 1, child: Text("${this.length}", style: words)),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: Text("${this.pName}", style: words)),
                Expanded(flex: 1, child: Text("${this.sName}", style: words)),
                Expanded(flex: 1, child: Text("${this.length}", style: words)),
              ],
            ),
          );
  }
}

class MemeProc extends StatelessWidget {
  String pName, sName, start, length, arrival, priority, index;
  final Color coloring;
  MemeProc(
      {this.pName,
      this.sName,
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
          Expanded(flex: 1, child: Text("${this.index}", style: words)),
          Expanded(
              flex: 2,
              child: Text("${this.pName}:${this.sName}", style: words)),
          Expanded(flex: 2, child: Text("${this.length}", style: words)),
          Expanded(flex: 2, child: Text("${this.start}", style: words)),
        ],
      ),
    );
  }
}

List<MemProcess> holes = [],
    segments = [],
    memoryProcesses1 = [],
    memoryProcesses2 = [];
List<MemeProc> segmentTable = [];
List<MemProcess> readyToDraw = [];
bool direction = true;

class Allocation extends StatefulWidget {
  //
  Allocation() : super();

  final String title = "Memory Allocation";

  @override
  AllocationState createState() => AllocationState();
}

class AllocationState extends State<Allocation> {
  //
  List<charts.Series> seriesList;
  static List<charts.Series<MemProcess, String>> memElements = [];

  bChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
      flipVerticalAxis: false,
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
                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.white),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  thickness: 4, color: charts.MaterialPalette.white))),
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      behaviors: [new charts.SeriesLegend()],
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.stacked,
      ),
      animationDuration: Duration(milliseconds: 750),
    );
  }

  bChartHorizontal() {
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
                  fontSize: 18, // size in Pts.
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

  drawingFunction() {
    for (var i = 0; i < memoryHoles.length; i++) {
      MemProcess tempH = MemProcess();
      tempH.sName = memoryHoles[i].sName;
      tempH.pName = memoryHoles[i].pName;
      tempH.isHole = memoryHoles[i].isHole;
      tempH.length = memoryHoles[i].length;
      tempH.start = memoryHoles[i].start;
      holes.add(tempH);
    }
    for (var i = 0; i < memoryProcesses.length; i++) {
      MemProcess tempS = MemProcess();
      tempS.sName = memoryProcesses[i].sName;
      tempS.pName = memoryProcesses[i].pName;
      tempS.isHole = memoryProcesses[i].isHole;
      tempS.length = memoryProcesses[i].length;
      tempS.start = memoryProcesses[i].start;
      segments.add(tempS);
      memoryProcesses1.add(tempS);
      memoryProcesses2.add(tempS);
    }
    if (globals.fitType == 'First Fit') {
      {
        holes.sort(
            (a, b) => (double.parse(a.start)).compareTo(double.parse(b.start)));
        for (var i = 0; i < segments.length; i++) {
          for (var j = 0; j < holes.length; j++) {
            if (double.parse(segments[i].length) <=
                double.parse(holes[j].length)) {
              MemProcess tempHole = MemProcess();
              MemProcess tempSegmnet = MemProcess();
              tempHole = holes[j];
              tempSegmnet = segments[i];
              tempSegmnet.start = (double.parse(tempHole.start)).toString();
              tempHole.length = (double.parse(tempHole.length) -
                      double.parse(tempSegmnet.length))
                  .toString();
              tempHole.start = (double.parse(tempSegmnet.start) +
                      double.parse(tempSegmnet.length))
                  .toString();
              if (double.parse(tempHole.length) != 0) {
                readyToDraw.add(tempSegmnet);
                segments.removeAt(i);
                memoryProcesses1.removeAt(i);
                i = -1;
                holes[j] = tempHole;
                break;
              } else {
                readyToDraw.add(tempSegmnet);
                segments.removeAt(i);
                memoryProcesses1.removeAt(i);
                i = -1;
                holes.removeAt(j);
                break;
              }
            }
          }
        }
        for (var i = 0; i < memoryProcesses2.length; i++) {
          for (var j = 0; j < readyToDraw.length; j++) {
            if (memoryProcesses2[i].pName == readyToDraw[j].pName &&
                memoryProcesses2[i].sName == readyToDraw[j].sName) {
              memoryProcesses2.removeAt(i);
              i = -1;
              break;
            }
          }
        }
        for (var i = 0; i < memoryProcesses2.length; i++) {
          for (var j = 0; j < readyToDraw.length; j++) {
            if (readyToDraw[j].pName == memoryProcesses2[i].pName) {
              MemProcess tempo = MemProcess();
              tempo.isHole = false;
              tempo.length = readyToDraw[j].length;
              tempo.pName = readyToDraw[j].pName;
              tempo.sName = readyToDraw[j].sName;
              tempo.start = readyToDraw[j].start;
              tempo.arrival = readyToDraw[j].arrival;
              tempo.priority = readyToDraw[j].priority;
              memoryProcesses2.add(tempo);
              readyToDraw[j].pName = 'Hole';
              readyToDraw[j].sName = null;
              readyToDraw[j].isHole = true;
            }
          }
        }
        int x = 0;
        for (var i = 0; i < readyToDraw.length; i++) {
          if (readyToDraw[i].pName != 'Hole' &&
              readyToDraw[i].pName != 'Busy') {
            MemeProc meme = MemeProc();
            meme.start = readyToDraw[i].start;
            meme.pName = readyToDraw[i].pName;
            meme.sName = readyToDraw[i].sName;
            meme.index = x.toString();
            meme.length = readyToDraw[i].length;
            x++;
            segmentTable.add(meme);
          }
        }
        for (var i = 0; i < holes.length; i++) {
          MemProcess temp = MemProcess();
          temp = holes[i];
          readyToDraw.add(temp);
        }
        readyToDraw.sort(
            (a, b) => (double.parse(a.start)).compareTo(double.parse(b.start)));
        if (double.parse(readyToDraw[0].start) != 0) {
          readyToDraw.insert(
              0,
              MemProcess(
                isHole: false,
                pName: 'Busy',
                length: readyToDraw[0].start,
                start: '0',
              ));
        }
        for (var i = 0; i < readyToDraw.length - 1; i++) {
          if ((double.parse(readyToDraw[i].start) +
                  double.parse(readyToDraw[i].length) !=
              double.parse(readyToDraw[i + 1].start))) {
            readyToDraw.insert(
                i + 1,
                MemProcess(
                  pName: 'Busy',
                  start: (double.parse(readyToDraw[i].start) +
                          double.parse(readyToDraw[i].length))
                      .toString(),
                  length: (double.parse(readyToDraw[i + 1].start) -
                          (double.parse(readyToDraw[i].start) +
                              double.parse(readyToDraw[i].length)))
                      .toString(),
                ));
          }
        }
        if (double.parse(readyToDraw[readyToDraw.length - 1].start) +
                double.parse(readyToDraw[readyToDraw.length - 1].length) !=
            double.parse(memSize)) {
          readyToDraw.add(MemProcess(
              pName: 'Busy',
              start: (double.parse(readyToDraw[readyToDraw.length - 1].start) +
                      double.parse(readyToDraw[readyToDraw.length - 1].length))
                  .toString(),
              length: (double.parse(memSize) -
                      (double.parse(readyToDraw[readyToDraw.length - 1].start) +
                          double.parse(
                              readyToDraw[readyToDraw.length - 1].length)))
                  .toString()));
        }
        for (var i = 0; i < readyToDraw.length; i++) {
          memoryList.add([readyToDraw[i]]);
        }
        if (!direction) {
          for (int i = 0; i < readyToDraw.length; i++) {
            if (memoryList[i][0].pName == "Busy") {
              memElements.add(charts.Series<MemProcess, String>(
                id: '${readyToDraw[i].pName}',
                domainFn: (MemProcess operation, _) => 'Memory',
                measureFn: (MemProcess operation, _) =>
                    double.parse(readyToDraw[i].length),
                data: memoryList[i],
                colorFn: (MemProcess operation, _) =>
                    charts.ColorUtil.fromDartColor(Colors.black),
                labelAccessorFn: (MemProcess operation, _) =>
                    ('${operation.pName}'),
              ));
            } else if (memoryList[i][0].pName == "Hole") {
              memElements.add(charts.Series<MemProcess, String>(
                id: '${readyToDraw[i].pName}',
                domainFn: (MemProcess operation, _) => 'Memory',
                measureFn: (MemProcess operation, _) =>
                    double.parse(readyToDraw[i].length),
                data: memoryList[i],
                colorFn: (MemProcess operation, _) =>
                    charts.ColorUtil.fromDartColor(Colors.red),
                labelAccessorFn: (MemProcess operation, _) =>
                    ('${operation.pName}'),
              ));
            } else {
              memElements.add(charts.Series<MemProcess, String>(
                id: '${readyToDraw[i].pName}: ${readyToDraw[i].sName}',
                domainFn: (MemProcess operation, _) => 'Memory',
                measureFn: (MemProcess operation, _) =>
                    double.parse(readyToDraw[i].length),
                data: memoryList[i],
                labelAccessorFn: (MemProcess operation, _) =>
                    ('${operation.pName}: ${operation.sName}'),
              ));
            }
          }
        } else {
          for (int i = 0; i < readyToDraw.length; i++) {
            if (memoryList[i][0].pName == "Busy") {
              memElements.add(charts.Series<MemProcess, String>(
                id: '${readyToDraw[i].pName}',
                seriesCategory: 'Memory',
                domainFn: (MemProcess operation, _) => 'Memory',
                measureFn: (MemProcess operation, _) =>
                    double.parse(readyToDraw[i].length),
                data: memoryList[i],
                colorFn: (MemProcess operation, _) =>
                    charts.ColorUtil.fromDartColor(Colors.black),
                labelAccessorFn: (MemProcess operation, _) =>
                    ('${operation.pName}'),
              ));
            } else if (memoryList[i][0].pName == "Hole") {
              memElements.add(charts.Series<MemProcess, String>(
                id: '${readyToDraw[i].pName}',
                seriesCategory: 'Memory',
                domainFn: (MemProcess operation, _) => 'Memory',
                measureFn: (MemProcess operation, _) =>
                    double.parse(readyToDraw[i].length),
                data: memoryList[i],
                colorFn: (MemProcess operation, _) =>
                    charts.ColorUtil.fromDartColor(Colors.red),
                labelAccessorFn: (MemProcess operation, _) =>
                    ('${operation.pName}'),
              ));
            } else {
              memElements.add(charts.Series<MemProcess, String>(
                seriesCategory: 'Memory',
                id: '${readyToDraw[i].pName}: ${readyToDraw[i].sName}',
                domainFn: (MemProcess operation, _) => 'Memory',
                measureFn: (MemProcess operation, _) =>
                    double.parse(readyToDraw[i].length),
                data: memoryList[i],
                labelAccessorFn: (MemProcess operation, _) =>
                    ('${operation.pName}: ${operation.sName}'),
              ));
            }
          }
        }
      }
    } else if (globals.fitType == 'Best Fit') {
      {
        holes.sort((a, b) =>
            (double.parse(a.length)).compareTo(double.parse(b.length)));
        for (var j = 0; j < segments.length; j++) {
          for (var i = 0; i < segments.length - 1; i++) {
            if (segments[i].pName == segments[i + 1].pName &&
                double.parse(segments[i].length) >
                    double.parse(segments[i + 1].length)) {
              MemProcess temporarySwitch = MemProcess();
              temporarySwitch.pName = segments[i + 1].pName;
              temporarySwitch.sName = segments[i + 1].sName;
              temporarySwitch.start = segments[i + 1].start;
              temporarySwitch.length = segments[i + 1].length;
              temporarySwitch.priority = segments[i + 1].priority;
              segments[i + 1] = segments[i];
              segments[i] = temporarySwitch;
              j = 0;
            }
          }
        }
        for (var i = 0; i < segments.length; i++) {
          for (var j = 0; j < holes.length; j++) {
            if (double.parse(segments[i].length) <=
                double.parse(holes[j].length)) {
              MemProcess tempHole = MemProcess();
              MemProcess tempSegmnet = MemProcess();
              tempHole = holes[j];
              tempSegmnet = segments[i];
              tempSegmnet.start = (double.parse(tempHole.start)).toString();
              tempHole.length = (double.parse(tempHole.length) -
                      double.parse(tempSegmnet.length))
                  .toString();
              tempHole.start = (double.parse(tempSegmnet.start) +
                      double.parse(tempSegmnet.length))
                  .toString();
              if (double.parse(tempHole.length) != 0) {
                readyToDraw.add(tempSegmnet);
                segments.removeAt(i);
                memoryProcesses1.removeAt(i);
                i = -1;
                holes[j] = tempHole;
                break;
              } else {
                readyToDraw.add(tempSegmnet);
                segments.removeAt(i);
                memoryProcesses1.removeAt(i);
                i = -1;
                holes.removeAt(j);
                break;
              }
            }
          }
        }
        for (var i = 0; i < memoryProcesses2.length; i++) {
          for (var j = 0; j < readyToDraw.length; j++) {
            if (memoryProcesses2[i].pName == readyToDraw[j].pName &&
                memoryProcesses2[i].sName == readyToDraw[j].sName) {
              memoryProcesses2.removeAt(i);
              i = -1;
              break;
            }
          }
        }
        for (var i = 0; i < memoryProcesses2.length; i++) {
          for (var j = 0; j < readyToDraw.length; j++) {
            if (readyToDraw[j].pName == memoryProcesses2[i].pName) {
              MemProcess tempo = MemProcess();
              tempo.isHole = false;
              tempo.length = readyToDraw[j].length;
              tempo.pName = readyToDraw[j].pName;
              tempo.sName = readyToDraw[j].sName;
              tempo.start = readyToDraw[j].start;
              tempo.arrival = readyToDraw[j].arrival;
              tempo.priority = readyToDraw[j].priority;
              memoryProcesses2.add(tempo);
              readyToDraw[j].pName = 'Hole';
              readyToDraw[j].sName = null;
              readyToDraw[j].isHole = true;
            }
          }
        }
        int x = 0;
        for (var i = 0; i < readyToDraw.length; i++) {
          if (readyToDraw[i].pName != 'Hole' &&
              readyToDraw[i].pName != 'Busy') {
            MemeProc meme = MemeProc();
            meme.start = readyToDraw[i].start;
            meme.pName = readyToDraw[i].pName;
            meme.sName = readyToDraw[i].sName;
            meme.index = x.toString();
            meme.length = readyToDraw[i].length;
            x++;
            segmentTable.add(meme);
          }
        }
        for (var i = 0; i < holes.length; i++) {
          MemProcess temp = MemProcess();
          temp = holes[i];
          readyToDraw.add(temp);
        }
        readyToDraw.sort(
            (a, b) => (double.parse(a.start)).compareTo(double.parse(b.start)));
        if (double.parse(readyToDraw[0].start) != 0) {
          readyToDraw.insert(
              0,
              MemProcess(
                isHole: false,
                pName: 'Busy',
                length: readyToDraw[0].start,
                start: '0',
              ));
        }
        for (var i = 0; i < readyToDraw.length - 1; i++) {
          if ((double.parse(readyToDraw[i].start) +
                  double.parse(readyToDraw[i].length) !=
              double.parse(readyToDraw[i + 1].start))) {
            readyToDraw.insert(
                i + 1,
                MemProcess(
                  pName: 'Busy',
                  start: (double.parse(readyToDraw[i].start) +
                          double.parse(readyToDraw[i].length))
                      .toString(),
                  length: (double.parse(readyToDraw[i + 1].start) -
                          (double.parse(readyToDraw[i].start) +
                              double.parse(readyToDraw[i].length)))
                      .toString(),
                ));
          }
        }
        if (double.parse(readyToDraw[readyToDraw.length - 1].start) +
                double.parse(readyToDraw[readyToDraw.length - 1].length) !=
            double.parse(memSize)) {
          readyToDraw.add(MemProcess(
              pName: 'Busy',
              start: (double.parse(readyToDraw[readyToDraw.length - 1].start) +
                      double.parse(readyToDraw[readyToDraw.length - 1].length))
                  .toString(),
              length: (double.parse(memSize) -
                      (double.parse(readyToDraw[readyToDraw.length - 1].start) +
                          double.parse(
                              readyToDraw[readyToDraw.length - 1].length)))
                  .toString()));
        }
        for (var i = 0; i < readyToDraw.length; i++) {
          memoryList.add([readyToDraw[i]]);
        }
        for (int i = 0; i < readyToDraw.length; i++) {
          if (memoryList[i][0].pName == "Busy") {
            memElements.add(charts.Series<MemProcess, String>(
              displayName: 'Busy',
              id: '${readyToDraw[i].pName}',
              domainFn: (MemProcess operation, _) => 'Start',
              measureFn: (MemProcess operation, _) =>
                  double.parse(readyToDraw[i].length),
              data: memoryList[i],
              colorFn: (MemProcess operation, _) =>
                  charts.ColorUtil.fromDartColor(Colors.black),
              labelAccessorFn: (MemProcess operation, _) =>
                  ('${operation.pName}'),
            ));
          } else if (memoryList[i][0].pName == "Hole") {
            memElements.add(charts.Series<MemProcess, String>(
              displayName: 'Hole',
              id: '${readyToDraw[i].pName}',
              domainFn: (MemProcess operation, _) => 'Start',
              measureFn: (MemProcess operation, _) =>
                  double.parse(readyToDraw[i].length),
              data: memoryList[i],
              colorFn: (MemProcess operation, _) =>
                  charts.ColorUtil.fromDartColor(Colors.red),
              labelAccessorFn: (MemProcess operation, _) =>
                  ('${operation.pName}'),
            ));
          } else {
            memElements.add(charts.Series<MemProcess, String>(
              displayName: '${readyToDraw[i].pName}: ${readyToDraw[i].sName}',
              id: '${readyToDraw[i].pName}: ${readyToDraw[i].sName}',
              domainFn: (MemProcess operation, _) => 'Start',
              measureFn: (MemProcess operation, _) =>
                  double.parse(readyToDraw[i].length),
              data: memoryList[i],
              labelAccessorFn: (MemProcess operation, _) =>
                  ('${operation.pName}: ${operation.sName}'),
            ));
          }
        }
      }
    }
    if (!direction) {
      seriesList = memElements;
    } else {
      seriesList = memElements.reversed.toList();
    }
  }

  @override
  void initState() {
    super.initState();
    drawingFunction();
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
          actions: [
            IconButton(
              icon: Icon(Icons.rotate_right),
              onPressed: () {
                setState(() {
                  direction = !direction;
                  seriesList.clear();
                  memElements.clear();
                  memoryList.clear();
                  memoryProcesses1.clear();
                  memoryProcesses2.clear();
                  holes.clear();
                  segments.clear();
                  segmentTable.clear();
                  readyToDraw.clear();
                  drawingFunction();
                });
              },
            )
          ],
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                seriesList.clear();
                memElements.clear();
                memoryList.clear();
                memoryProcesses1.clear();
                memoryProcesses2.clear();
                holes.clear();
                segments.clear();
                segmentTable.clear();
                readyToDraw.clear();
                globals.fitType = '';
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MemoryAllocator()),
                );
              }),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16),
                        child: Expanded(
                          child: direction
                              ? Container(
                                  child: bChart(),
                                )
                              : bChartHorizontal(),
                        ),
                      )),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 20,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 16),
                                child: Expanded(
                                  child: ListView(
                                    children: <Widget>[
                                      Text(
                                        'Segments Tables',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 16.0, top: 16.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Index",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  wordSpacing: 1.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Name",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  wordSpacing: 1.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Limit",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  wordSpacing: 1.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Base",
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
                                          itemCount: segmentTable.length,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return segmentTable[index];
                                          })
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 20,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 16),
                                child: Expanded(
                                  child: ListView(
                                    children: <Widget>[
                                      Text(
                                        'Segments Waiting',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 16.0, top: 16.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Process\nName",
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
                                                "Segment\nName",
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
                                                "Segment\nSize",
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
                                          itemCount: memoryProcesses2.length,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return memoryProcesses2[index];
                                          })
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
