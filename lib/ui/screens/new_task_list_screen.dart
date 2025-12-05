import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/models/task_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';
import '../widgets/task_card.dart';
import 'add_new_task.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _getNewTaskListInProgress = false;
  List<TaskModel> _newTaskList = [];
  @override
  void initState() {
    newTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            const SizedBox(),
            _buildTaskSummaryListView(),
            Visibility(
              visible: _getNewTaskListInProgress == false,
              replacement: Center(child: CircularProgressIndicator()),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _newTaskList.length,
                itemBuilder: (context, index) {
                  return TaskCard(taskModel: _newTaskList[index],);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTaskButton() {
    Navigator.pushNamed(context, AddNewTask.name);
  }

  // top locator bar under appbar.
  Widget _buildTaskSummaryListView() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(left: 8),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Text(
                    "12",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.black),
                  ),
                  Text("New", style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> newTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.newTaskListUrl,
    );

    if (!mounted) return;
    if (response.isSuccess) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _newTaskList = list;
    } else {
      showSnackBar(context, response.error);
    }

    _getNewTaskListInProgress = false;
    setState(() {});
  }
}
