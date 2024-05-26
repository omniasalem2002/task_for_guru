import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_for_guru/add_profile/add_profile_screen.dart';
import 'package:task_for_guru/get_all_profile/get_all_profile_view.dart';
import 'package:task_for_guru/logic/profile_provider.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform

      options: FirebaseOptions(
          appId: '1:15799592224:android:4c02c2e51e7bfa640aa345',
          messagingSenderId: '15799592224',
          projectId: 'taskguru-9843c',
          apiKey: 'key'
      )
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Profile App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GetAllProfileView(),
        routes: {
          AddProfileScreen.routeName: (context) => const AddProfileScreen(),        },
      ),
    );
  }
}


