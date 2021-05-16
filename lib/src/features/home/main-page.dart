import 'package:flutter/material.dart';
//import '../../utils/app-state-notifier.dart';
//import 'package:provider/provider.dart';
import '../../models/machine.dart';
import '../../utils/db.dart';
import '../../widgets/button.dart';
import './form-machine.dart';
import 'dart:convert';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Machine _machine = Machine();

  List<Machine> _machines = [];

  List<Widget> get _items => _machines.map((item) => format(item)).toList();

  Machine _content = Machine();

  Widget format(Machine item) {
    return Dismissible(
      key: Key(item.id.toString()),
      child: Padding(
          padding: EdgeInsets.fromLTRB(12, 6, 12, 4),
          child: OutlinedButton(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(
                        "NAME: " +
                            item.name +
                            "\nIP " +
                            item.ip +
                            ":" +
                            item.port.toString(),
                        style: new TextStyle(
                          fontSize: 14.0,
                        ),
                      )),
                    ])),
            onPressed: () => _toggle(item),
          )),
      onDismissed: (DismissDirection direction) => _delete(item),
      background: Container(color: Colors.pink),
    );
  }

  void _toggle(Machine item) async {
    _content = item;
    refresh();
  }

  void _delete(Machine item) async {
    DB.delete(Machine.table, item);
    _content = Machine();
    refresh();
  }

  void _save() async {
    Navigator.of(context).pop();
    Machine item = _machine;
    await DB.insert(Machine.table, item);
    setState(() => _machine = Machine());
    refresh();
  }

  void _update() async {
    Navigator.of(context).pop();
    Machine item = _content;
    await DB.update(Machine.table, item);
    refresh();
  }

  void _create(BuildContext context, {bool edit = false}) {
    if (!edit) {
      _machine = Machine();
      print('test');
      print(_machine.name);
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FormMachine(
              machine: _machine,
              save: () => edit ? _update() : _save(),
              edit: edit);
        });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(Machine.table);
    setState(() {
      _machines = _results.map((item) => Machine.fromMap(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: Column(children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Icon(
                      Icons.create_new_folder,
                      size: 25,
                    ),
                    onPressed: () => {_create(context)},
                  )),
              Expanded(child: ListView(children: _items))
            ])),
        Expanded(
            flex: 2,
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  child: _content.id == null
                      ? Column(children: [
                          Text(
                            "Create or select server",
                            style: new TextStyle(
                              fontSize: 16.0,
                            ),
                          )
                        ])
                      : Row(children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Column(children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: ButtonWidget(
                                      onPressed: () => {
                                        _machine = _content,
                                        _create(context, edit: true)
                                      },
                                      text: "Edit",
                                      size: 18.0,
                                    )),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\nNAME: " + _content.name,
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    )),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\nIP " +
                                          _content.ip +
                                          ":" +
                                          _content.port.toString(),
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    )),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\nCompression: " + _content.compression,
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    )),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\nPassword: " + _content.password,
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    )),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\nEncryption: " + _content.encryption,
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    )),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\nCMD: " + _content.cmd,
                                      textAlign: TextAlign.left,
                                      style: new TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    )),
                              ])),
                          Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                  child: Image.memory(
                                    Base64Decoder().convert(_content.pic),
                                    width: 250,
                                  )),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: ButtonWidget(
                                    onPressed: () => {},
                                    text: "Connect",
                                    size: 18.0,
                                  ))
                            ],
                          )
                        ]))
            ]))
      ],
    ));
  }
}

// class MainPage extends StatefulWidget {
//   final String text;
//   MainPage({Key key, @required this.text}) : super(key: key);

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(children: [
//           Row(children: [
//             TextButton(
//               child: Text('View Details'),
//               onPressed: () {
//                 Navigator.pushNamed(
//                   context,
//                   '/details/1',
//                 );
//               },
//             ),
//             Switch(
//               value: Provider.of<AppStateNotifier>(context).isDarkMode,
//               onChanged: (value) {
//                 Provider.of<AppStateNotifier>(context, listen: false)
//                     .updateTheme(value);
//               },
//             ),
//             Text(widget.text)
//           ])
//         ]),
//       ),
//     );
//   }
// }
