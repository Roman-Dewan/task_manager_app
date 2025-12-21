import 'package:flutter/material.dart';
import '../../widgets/tm_app_bar.dart';
import 'cancelled_task_list_screen.dart';
import 'completed_task_list_screen.dart';
import 'new_task_list_screen.dart';
import 'progress_task_list_screen.dart';

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
    ProgressTaskListScreen(),
    CancelledTaskListScreen(),
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
            label: "Cancelled",
          ),
          NavigationDestination(icon: Icon(Icons.done), label: "Completed"),
        ],
      ),
    );
  }
}
