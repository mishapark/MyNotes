import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/utilities/show_logout_dialog.dart';
import 'package:mynotes/views/login_view.dart';

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  static String id = '/notes';

  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);

                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    if (!mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginView.id,
                      (route) => false,
                    );
                  }

                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: const Text('Hello world'),
    );
  }
}
