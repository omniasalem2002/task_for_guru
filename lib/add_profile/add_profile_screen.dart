import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_for_guru/logic/profile_provider.dart';
import 'package:task_for_guru/models/Profile.dart';

class AddProfileScreen extends StatefulWidget {
  static const routeName = '/add-profile';
  const AddProfileScreen({Key? key}) : super(key: key);

  @override
  _AddProfileScreenState createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _nameController = TextEditingController();
  final _birthdateController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _birthdateController.text = '${pickedDate.toLocal()}'.split(' ')[0];
      });
    });
  }

  void _submitData() {
    if (_nameController.text.isEmpty || _selectedDate == null) {
      return;
    }

    final enteredName = _nameController.text;
    final enteredDate = _selectedDate!;

    final newProfile = Profile.fromBirthdate(enteredName, enteredDate);
    Provider.of<ProfileProvider>(context, listen: false).addProfile(newProfile);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: _nameController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Birthdate'),
              controller: _birthdateController,
              onTap: _presentDatePicker,
              readOnly: true,
            ),
          const  SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Add Profile'),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
