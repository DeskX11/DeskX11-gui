import 'package:flutter/material.dart';
//import '../../utils/app-state-notifier.dart';
//import 'package:provider/provider.dart';
import '../../models/machine.dart';
import '../../utils/db.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Machine _machine = Machine();

  List<Machine> _machines = [];

  TextStyle _style = TextStyle(color: Colors.white, fontSize: 24);

  List<Widget> get _items => _machines.map((item) => format(item)).toList();

  Widget format(Machine item) {
    return Dismissible(
      key: Key(item.id.toString()),
      child: Padding(
          padding: EdgeInsets.fromLTRB(12, 6, 12, 4),
          child: TextButton(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(item.ip, style: _style),
                ]),
            onPressed: () => _toggle(item),
          )),
      onDismissed: (DismissDirection direction) => _delete(item),
    );
  }

  void _toggle(Machine item) async {
    item.ip = item.ip + "!";
    await DB.update(Machine.table, item);
    refresh();
  }

  void _delete(Machine item) async {
    DB.delete(Machine.table, item);
    refresh();
  }

  void _save() async {
    Navigator.of(context).pop();
    Machine item = _machine;
    await DB.insert(Machine.table, item);
    setState(() => _machine = Machine());
    refresh();
  }

  void _create(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Create New Machine"),
              actions: <Widget>[
                TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop()),
                TextButton(child: Text('Save'), onPressed: () => _save())
              ],
              content: Column(children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Compression', hintText: 'Compression type'),
                  onChanged: (value) {
                    _machine.compression = value;
                  },
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Password', hintText: 'Server password'),
                  onChanged: (value) {
                    _machine.password = value;
                  },
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Encryption', hintText: 'Encryption type'),
                  onChanged: (value) {
                    _machine.encryption = value;
                  },
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Port', hintText: 'Port server'),
                  onChanged: (value) {
                    _machine.port = int.parse(value);
                  },
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'cmd', hintText: 'Custom comand'),
                  onChanged: (value) {
                    _machine.cmd = value;
                  },
                ),
                TextField(
                  autofocus: true,
                  decoration:
                      InputDecoration(labelText: 'IP', hintText: 'IP Adress'),
                  onChanged: (value) {
                    _machine.ip = value;
                  },
                ),
              ]));
        });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(Machine.table);
    _machines = _results.map((item) => Machine.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: ListView(children: _items)));
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
