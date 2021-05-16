import 'package:flutter/material.dart';
import '../../models/settings.dart';
import '../../widgets/button.dart';
import 'package:flutter/services.dart';

class FormSetting extends StatefulWidget {
  Settings settings;
  final VoidCallback save;

  FormSetting({
    Key key,
    @required this.settings,
    @required this.save,
  }) : super(key: key);

  @override
  _FormSettingState createState() => _FormSettingState();
}

class _FormSettingState extends State<FormSetting> {
  Map<String, bool> _error = {
    'resolutionX': false,
    'resolutionY': false,
    'key': false,
  };

  void clearValidate() {
    setState(() => _error = {
          'resolutionX': false,
          'resolutionY': false,
          'key': false,
        });
  }

  void validate(context) {
    clearValidate();
    FocusScope.of(context).unfocus();
    if (widget.settings.resolutionX == null) {
      setState(() => _error['resolutionX'] = true);
    }
    if (widget.settings.resolutionY == null) {
      setState(() => _error['resolutionY'] = true);
    }
    if (widget.settings.key.length == 0) {
      setState(() => _error['key'] = true);
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
    return Column(children: [
      TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
        controller: TextEditingController()
          ..text = widget.settings.resolutionX == null
              ? ''
              : widget.settings.resolutionX.toString(),
        decoration: InputDecoration(
            labelText: 'resolutionX',
            hintText: 'resolutionX screen',
            errorText:
                _error['resolutionX'] ? 'Error in screen resolutionX' : null),
        onChanged: (value) {
          widget.settings.resolutionX =
              value.length > 0 ? int.parse(value) : null;
        },
      ),
      TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
        controller: TextEditingController()
          ..text = widget.settings.resolutionY == null
              ? ''
              : widget.settings.resolutionY.toString(),
        decoration: InputDecoration(
            labelText: 'resolutionY',
            hintText: 'resolutionY screen',
            errorText: _error['resolutionY'] ? 'Error in resolution' : null),
        onChanged: (value) {
          widget.settings.resolutionY =
              value.length > 0 ? int.parse(value) : null;
        },
      ),
      RawKeyboardListener(
        child: TextField(
          autofocus: true,
          controller: TextEditingController()..text = widget.settings.key,
          decoration: InputDecoration(
              labelText: 'Key to close',
              hintText: 'Key to close',
              errorText: _error['key'] ? 'Key to close error' : null),
        ),
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          var nameKey = event.data.logicalKey.debugName;
          setState(() => widget.settings.key = nameKey);
        },
      ),
      Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: ButtonWidget(
            onPressed: () => {validate(context)},
            text: "Edit",
            size: 18.0,
          )),
    ]);
  }
}
