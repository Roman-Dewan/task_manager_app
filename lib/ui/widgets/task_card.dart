import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/models/task_model.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';
import 'package:task_manage_updated/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';

class TaskCard extends StatefulWidget {
  final TaskModel taskModel;
  final VoidCallback refreshList;
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.refreshList,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _changeStatusInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        tileColor: Colors.white,
        title: Text(
          widget.taskModel.title,
          style: TextTheme.of(context).titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description),
            Text(
              "Date: ${widget.taskModel.createdDate}",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.black),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(widget.taskModel.status),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
                Visibility(
                  visible: _changeStatusInProgress == false,
                  replacement: CenteredProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _showChangeStatusDialouge();
                    },
                    icon: Icon(Icons.edit, color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeStatusDialouge() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Change Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("New"),
                trailing: _isCurrentStatus("New") ? Icon(Icons.done) : null,
                onTap: () {
                  onTapChangeTaskTitle("New");
                },
              ),
              ListTile(
                title: Text("Progress"),
                trailing: _isCurrentStatus("Progress")
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  onTapChangeTaskTitle("Progress");
                },
              ),
              ListTile(
                title: Text("Cancelled"),
                trailing: _isCurrentStatus("Cancelled")
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  onTapChangeTaskTitle("Cancelled");
                },
              ),
              ListTile(
                title: Text("Completed"),
                trailing: _isCurrentStatus("Completed")
                    ? Icon(Icons.done)
                    : null,
                onTap: () {
                  onTapChangeTaskTitle("Completed");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getChangeStatus(String status) async {
    _changeStatusInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.updateTaskUrl(widget.taskModel.id, status),
    );

    if (!mounted) return;
    if (response.isSuccess) {
      widget.refreshList();
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      showSnackBar(context, response.error);
    }
  }

  bool _isCurrentStatus(String status) {
    return widget.taskModel.status == status;
  }

  void onTapChangeTaskTitle(String status) {
    if (_isCurrentStatus(status)) return;
    Navigator.pop(context);
    setState(() {});
    _getChangeStatus(status);
  }
}
