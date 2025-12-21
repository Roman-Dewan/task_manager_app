class Urls {
  static const String _basUrl = "http://35.73.30.144:2005/api/v1";
  static const String registrationUrl = "$_basUrl/Registration";
  static const String loginUrl = "$_basUrl/Login";
  static const String createNewTaskUrl = "$_basUrl/createTask";
  static const String newTaskListUrl = "$_basUrl/listTaskByStatus/New";
  static const String progressTaskListUrl =
      "$_basUrl/listTaskByStatus/Progress";
  static const String cancelledTaskListUrl =
      "$_basUrl/listTaskByStatus/Cancelled";
  static const String completedTaskListUrl =
      "$_basUrl/listTaskByStatus/Completed";
  static const String taskCountUrl = "$_basUrl/taskStatusCount";
  static const String updateProfileUrl = "$_basUrl/ProfileUpdate";

  static String forgetPasswordEmail(String email) =>
      "$_basUrl/RecoverVerifyEmail/$email";

  static String updateTaskUrl(String taskId, String status) =>
      "$_basUrl/updateTaskStatus/$taskId/$status";

  static String deleteTask(String taskId) => "$_basUrl/deleteTask/$taskId";
}
