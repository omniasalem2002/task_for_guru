import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_for_guru/add_profile/add_profile_screen.dart';
import 'package:task_for_guru/logic/profile_provider.dart';



class GetAllProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Set the border radius here
          ),
        ),
        title: Text(
          'Profile List',
          textAlign: TextAlign.center, // Align the title text to the center
          style: TextStyle(
            color: Colors.white, // Change the text color to white
          ),
        ),
        centerTitle: true, // Center the title horizontally
      ),
      body: FutureBuilder(

        future:  FirebaseFirestore.instance.collection('profiles').get(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: profileProvider.profiles.length,
            itemBuilder: (ctx, index) {
              final profile = profileProvider.profiles[index];
              return
                InkWell(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.yellow, width: 1.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: ListTile(
                        title: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                              profile.name

                          ),
                        ),
                        subtitle: Text('Age: ${profile.age}'),

                      ),
                    ),
                  ),
                );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddProfileScreen.routeName);
        },
      ),
    );
  }
}
