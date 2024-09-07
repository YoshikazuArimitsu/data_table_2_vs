import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _incrementCounter1000() {
    setState(() {
      _counter+=1000;
    });
  }

  void _incrementCounter10000() {
    setState(() {
      _counter+=10000;
    });
  }

  DataRow2 _row(int index) {
    return DataRow2(
      cells: <DataCell>[
        DataCell(Text('${index}, 1')),
        DataCell(Text('${index}, 2')),
        DataCell(Text('${index}, 3')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Theme(
              // Using themes to override scroll bar appearence, note that iOS scrollbars do not support color overrides
              data: ThemeData(
                  iconTheme: const IconThemeData(color: Colors.white),
                  scrollbarTheme: ScrollbarThemeData(
                    thickness: WidgetStateProperty.all(5),
                    // thumbVisibility: MaterialStateProperty.all(true),
                    // thumbColor: MaterialStateProperty.all<Color>(Colors.yellow)
                  )),
              child: DataTable2(
                // Forcing all scrollbars to be visible, alternatively themes can be used (see above)
                headingRowColor:
                    WidgetStateColor.resolveWith((states) => Colors.grey[850]!),
                headingTextStyle: const TextStyle(color: Colors.white),
                headingCheckboxTheme: const CheckboxThemeData(
                    side: BorderSide(color: Colors.white, width: 2.0)),
                //checkboxAlignment: Alignment.topLeft,
                isHorizontalScrollBarVisible: true,
                isVerticalScrollBarVisible: true,
                columnSpacing: 12,
                horizontalMargin: 12,
                sortArrowBuilder: null,
                border: TableBorder(
                    top: const BorderSide(color: Colors.black),
                    bottom: BorderSide(color: Colors.grey[300]!),
                    left: BorderSide(color: Colors.grey[300]!),
                    right: BorderSide(color: Colors.grey[300]!),
                    verticalInside: BorderSide(color: Colors.grey[300]!),
                    horizontalInside:
                        const BorderSide(color: Colors.grey, width: 1)),
                dividerThickness: 1,
                // this one will be ignored if [border] is set above
                bottomMargin: 10,
                minWidth: 900,
                columns: const [
                  DataColumn2(
                    label: Text('Col1'),
                    size: ColumnSize.S,
                    // example of fixed 1st row
                    fixedWidth: 200,
                  ),
                  DataColumn2(
                    label: Text('Col2'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Col3'),
                  ),
                ],
                empty: Center(
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.grey[200],
                        child: const Text('No data'))),
                rows: List<DataRow2>.generate(_counter, (index) => _row(index)),
              )),
        ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
          FloatingActionButton(
            onPressed: () => setState(() {
                _counter++;
            }),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
          FloatingActionButton(
            onPressed: () => setState(() {
              _counter+=1000;
            }),
            tooltip: 'Plus 1000',
            child: const Icon(Icons.one_k),
          ),
          FloatingActionButton(
            onPressed: () => setState(() {
              _counter = 0;
            }),
            tooltip: 'Clear',
            child: const Icon(Icons.clear),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ]));
  }
}
