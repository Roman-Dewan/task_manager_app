import 'package:flutter/material.dart';
import 'package:module18_19/ui/screens/canceled_task_list_screen.dart';
import 'package:module18_19/ui/screens/completed_task_list_screen.dart';
import 'package:module18_19/ui/screens/new_task_list_screen.dart';
import 'package:module18_19/ui/screens/progress_task_list_screen.dart';
import 'package:module18_19/ui/widgets/tm_app_bar.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});
  static String name = "/main-bottom-nav";
  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    NewTaskListScreen(),
    CanceledTaskListScreen(),
    ProgressTaskListScreen(),
    CompletedTaskListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappBar(),
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },

        destinations: [
          NavigationDestination(icon: Icon(Icons.note_add), label: "New"),
          NavigationDestination(
            icon: Icon(Icons.access_time),
            label: "Progress",
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: "Canceled",
          ),
          NavigationDestination(icon: Icon(Icons.done), label: "Completed"),
        ],
      ),
    );
  }
}
