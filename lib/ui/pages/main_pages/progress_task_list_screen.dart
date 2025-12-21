import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/ui/providers/progress_task_list_provider.dart';
import 'package:task_manage_updated/ui/widgets/centered_progress_indicator.dart';
import 'package:task_manage_updated/ui/widgets/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<ProgressTaskListProvider>(context, listen: false).getProgressTaskList();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProgressTaskListProvider>(
        builder: (context, progressTaskListProvider, child) {
          return Visibility(
            visible:
                progressTaskListProvider.getProgressTaskListInProgress == false,
            replacement: CenteredProgressIndicator(),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: progressTaskListProvider.progressTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: progressTaskListProvider.progressTaskList[index],
                  refreshList: () {
                    progressTaskListProvider.getProgressTaskList();
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
    );
  }
}
