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
        title: const Text('Profile List'),
      ),
      body: FutureBuilder(
        future: profileProvider.fetchProfiles(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: profileProvider.profiles.length,
            itemBuilder: (ctx, index) {
              final profile = profileProvider.profiles[index];
              return ListTile(
                title: Text(profile.name),
                subtitle: Text('Age: ${profile.age}'),
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
