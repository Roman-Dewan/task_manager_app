import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/ui/providers/cancelled_task_list_provider.dart';
import '../widgets/centered_progress_indicator.dart';
import '../widgets/task_card.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});
  @override
  State<CancelledTaskListScreen> createState() =>
      _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CancelledTaskListProvider>().getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CancelledTaskListProvider>(
        builder: (context, cancelledTaskListProvider, child) {
          return Visibility(
            visible:
                cancelledTaskListProvider.getCancelledTaskListInProgress ==
                false,
            replacement: CenteredProgressIndicator(),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cancelledTaskListProvider.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: cancelledTaskListProvider.cancelledTaskList[index],
                  refreshList: () {
                    cancelledTaskListProvider.getCancelledTaskList();
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
