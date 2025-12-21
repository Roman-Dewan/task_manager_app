import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/data/models/task_count_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';
import 'package:task_manage_updated/ui/providers/new_task_list_provider.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';
import '../../widgets/centered_progress_indicator.dart';
import '../../widgets/task_card.dart';
import '../activity_pages/add_new_task.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _taskCountInProgress = false;
  List<TaskCountModel> _taskCountList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTaskCountList();
      context.read<NewTaskListProvider>().getNewTaskList();
    });
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
            Consumer<NewTaskListProvider>(
              builder: (context, newTaskListProvider, child) {
                return Visibility(
                  visible:
                      newTaskListProvider.getNewTaskListInProgress == false,
                  replacement: SizedBox(
                    height: 400,
                    child: CenteredProgressIndicator(),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: newTaskListProvider.newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: newTaskListProvider.newTaskList[index],
                        refreshList: () {
                          newTaskListProvider.getNewTaskList();
                          _getTaskCountList();
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8);
                    },
                  ),
                );
              },
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
      child: Visibility(
        visible: _taskCountInProgress == false,
        replacement: CenteredProgressIndicator(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _taskCountList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              elevation: 0,
              margin: EdgeInsets.only(left: 8),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      _taskCountList[index].sum.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.black),
                    ),
                    Text(
                      _taskCountList[index].id,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // task value count
  Future<void> _getTaskCountList() async {
    _taskCountInProgress = true;

    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      Urls.taskCountUrl,
    );

    if (!mounted) return;
    if (response.isSuccess) {
      List<TaskCountModel> list = [];

      for (Map<String, dynamic> jsonData in response.body['data']) {
        list.add(TaskCountModel.fromJson(jsonData));
      }

      _taskCountList = list;
    } else {
      showSnackBar(context, response.error);
    }

    _taskCountInProgress = false;
    setState(() {});
  }
}
