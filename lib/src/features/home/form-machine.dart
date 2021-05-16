import 'package:flutter/material.dart';
import '../../models/machine.dart';
import 'package:flutter/services.dart';

class FormMachine extends StatefulWidget {
  bool edit = false;
  Machine machine;
  final VoidCallback save;

  FormMachine({
    Key key,
    @required this.machine,
    @required this.save,
    @required this.edit,
  }) : super(key: key);

  @override
  _FormMachineState createState() => _FormMachineState();
}

class _FormMachineState extends State<FormMachine> {
  Map<String, bool> _error = {
    'name': false,
    'compression': false,
    'password': false,
    'encryption': false,
    'port': false,
    'cmd': false,
    'ip': false,
  };

  void clearValidate() {
    setState(() => _error = {
          'name': false,
          'compression': false,
          'password': false,
          'encryption': false,
          'port': false,
          'cmd': false,
          'ip': false,
        });
  }

  void validate(context) {
    clearValidate();
    FocusScope.of(context).unfocus();
    if (widget.machine.name.length == 0) {
      setState(() => _error['name'] = true);
    }
    if (widget.machine.compression.length == 0) {
      setState(() => _error['compression'] = true);
    }
    if (widget.machine.password.length == 0) {
      setState(() => _error['password'] = true);
    }
    if (widget.machine.encryption.length == 0) {
      setState(() => _error['encryption'] = true);
    }
    if (widget.machine.port == null || widget.machine.port > 65535) {
      setState(() => _error['port'] = true);
    }
    if (widget.machine.cmd.length == 0) {
      setState(() => _error['cmd'] = true);
    }
    if (widget.machine.ip.length == 0 ||
        !RegExp(r'^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\.(?!$)|$)){4}$')
            .hasMatch(widget.machine.ip)) {
      setState(() => _error['ip'] = true);
    }
    for (var value in _error.values) {
      if (value) {
        return;
      }
    }
    widget.save();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.edit ? "Edit Machine" : "Create New Machine"),
        actions: <Widget>[
          TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop()),
          TextButton(
              child: Text(widget.edit ? 'Edit' : 'Save'),
              onPressed: () => validate(context))
        ],
        content: Column(children: [
          TextField(
            autofocus: true,
            controller: TextEditingController()..text = widget.machine.name,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Name connection',
              errorText: _error['name'] ? 'Value Can\'t Be Empty' : null,
            ),
            onChanged: (value) {
              widget.machine.name = value;
            },
          ),
          TextField(
            autofocus: true,
            controller: TextEditingController()
              ..text = widget.machine.compression,
            decoration: InputDecoration(
              labelText: 'Compression',
              hintText: 'Compression type',
              errorText: _error['compression'] ? 'Value Can\'t Be Empty' : null,
            ),
            onChanged: (value) {
              widget.machine.compression = value;
            },
          ),
          TextField(
            autofocus: true,
            controller: TextEditingController()..text = widget.machine.password,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Server password',
              errorText: _error['password'] ? 'Value Can\'t Be Empty' : null,
            ),
            onChanged: (value) {
              widget.machine.password = value;
            },
          ),
          TextField(
            autofocus: true,
            controller: TextEditingController()
              ..text = widget.machine.encryption,
            decoration: InputDecoration(
              labelText: 'Encryption',
              hintText: 'Encryption type',
              errorText: _error['encryption'] ? 'Value Can\'t Be Empty' : null,
            ),
            onChanged: (value) {
              widget.machine.encryption = value;
            },
          ),
          TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ], // Only numbers can be entered
            controller: TextEditingController()
              ..text = widget.machine.port == null
                  ? ''
                  : widget.machine.port.toString(),
            decoration: InputDecoration(
                labelText: 'Port',
                hintText: 'Port server',
                errorText: _error['port'] ? 'Error in port' : null),
            onChanged: (value) {
              widget.machine.port = value.length > 0 ? int.parse(value) : null;
            },
          ),
          TextField(
            autofocus: true,
            controller: TextEditingController()..text = widget.machine.ip,
            decoration: InputDecoration(
                labelText: 'IP',
                hintText: 'IP Adress',
                errorText: _error['ip'] ? 'Only can be IP adress' : null),
            onChanged: (value) {
              widget.machine.ip = value;
            },
          ),
          TextField(
            autofocus: true,
            controller: TextEditingController()..text = widget.machine.cmd,
            decoration: InputDecoration(
                labelText: 'cmd',
                hintText: 'Custom comand',
                errorText: _error['cmd'] ? 'Value Can\'t Be Empty' : null),
            onChanged: (value) {
              widget.machine.cmd = value;
            },
          ),
        ]));
  }
}
