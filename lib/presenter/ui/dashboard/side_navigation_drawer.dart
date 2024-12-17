import 'package:clean_arch/common/widgets/custom_text.dart';
import 'package:clean_arch/routes.dart';
import 'package:flutter/material.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Header with round profile icon, username, and email
          const UserAccountsDrawerHeader(
            accountName: Text('Username'), // Replace with dynamic data
            accountEmail: Text('user@example.com'), // Replace with dynamic data
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(
                'U', // Placeholder for initial of username
                style: TextStyle(fontSize: 40.0, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const CustomText(text: 'Privacy Policy'),
            onTap: () {
              // Handle Privacy Policy tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const CustomText(text: 'Terms & Conditions'),
            onTap: () {
              // Handle Terms & Conditions tap
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const CustomText(text: 'Logout'),
            onTap: () {
              // Handle Logout tap
              Routes.navigateAndRemoveAll(context, Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
