import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/ui/providers/completed_task_list_provider.dart';
import '../../widgets/centered_progress_indicator.dart';
import '../../widgets/task_card.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() =>
      _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<CompletedTaskListProvider>(context, listen: false).getCompletedTaskList();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CompletedTaskListProvider>(
        builder: (context, completedTaskListProvider, child) {
          return Visibility(
            visible:
                completedTaskListProvider.getCompletedTaskListInProgress ==
                false,
            replacement: CenteredProgressIndicator(),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: completedTaskListProvider.completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: completedTaskListProvider.completedTaskList[index],
                  refreshList: () {
                    completedTaskListProvider.getCompletedTaskList();
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
