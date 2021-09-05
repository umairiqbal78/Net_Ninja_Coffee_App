import 'package:brew_crew_coffee_app/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Update your brew settings',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            //name input
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Enter name'),
              validator: (val) => val!.isEmpty ? 'Enter your name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(
              height: 10.0,
            ),
            //Sugar DropDown
            DropdownButtonFormField(
                value: _currentSugars ?? '0',
                decoration: textInputDecoration,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar Sugars'),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() => _currentSugars = val.toString());
                }),
            Slider(
              value: (_currentStrength ?? 100).toDouble(),
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.brown[_currentStrength ?? 100],
              min: 100,
              max: 900,
              divisions: 8,
              onChanged: (val) {
                setState(() {
                  _currentStrength = val.round();
                });
              },
            ),
            //update button
            TextButton(
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink)),
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
