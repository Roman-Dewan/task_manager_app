import 'package:flutter/material.dart';
import '../widgets/screen_background.dart';
import '../widgets/tm_app_bar.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});
  static String name = "/add-new-task";

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                const SizedBox(height: 64),
                Text(
                  "Add New Task",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextFormField(decoration: InputDecoration(hintText: "title")),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(hintText: "Description"),
                ),
                FilledButton(
                  onPressed: _taskConfirmButton,
                  child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _taskConfirmButton() {
    debugPrint("task added confirmed.");
  }
}
