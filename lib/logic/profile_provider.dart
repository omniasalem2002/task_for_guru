import 'package:flutter/material.dart';
import 'package:task_for_guru/models/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileProvider with ChangeNotifier {
  List<Profile> _profiles = [];

  List<Profile> get profiles => _profiles;

  ProfileProvider() {
    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    final snapshot = await FirebaseFirestore.instance.collection('profiles').get();
    _profiles = snapshot.docs.map((doc) {
      final data = doc.data();
      return Profile(
        name: data['name'],
        birthdate: DateTime.parse(data['birthdate']),
        age: data['age'],
      );
    }).toList();
    notifyListeners();
  }

  Future<void> addProfile(Profile profile) async {
    _profiles.add(profile);
    await FirebaseFirestore.instance.collection('profiles').add({
      'name': profile.name,
      'birthdate': profile.birthdate.toIso8601String(),
      'age': profile.age,
    });
    notifyListeners();
  }
}
