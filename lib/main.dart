import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'data_table_2_vs.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Theme(
              data: ThemeData(
                  iconTheme: const IconThemeData(color: Colors.white),
                  scrollbarTheme: ScrollbarThemeData(
                    thickness: WidgetStateProperty.all(5),
                    // thumbVisibility: MaterialStateProperty.all(true),
                    // thumbColor: MaterialStateProperty.all<Color>(Colors.yellow)
                  )),
              child:
                // DataTable2(
                DataTable2Vs(

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
                bottomMargin: 10,
                minWidth: 900,
                columns: const [
                  DataColumn2(
                    label: Text('Col1'),
                    size: ColumnSize.S,
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
