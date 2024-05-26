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
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Set the border radius here
          ),
        ),
        title: Text(
          'Add Profile',
          textAlign: TextAlign.center, // Align the title text to the center
          style: TextStyle(
            color: Colors.white, // Change the text color to white
          ),
        ),
        centerTitle: true, // Center the title horizontally
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              ),
              controller: _nameController,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextField(
              decoration:  InputDecoration(labelText: 'Birthdate',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
              ),

              controller: _birthdateController,
              onTap: _presentDatePicker,
              readOnly: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
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
