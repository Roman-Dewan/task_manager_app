class Urls {
  static const String _basUrl = "http://35.73.30.144:2005/api/v1";
  static const String registrationUrl = "$_basUrl/Registration";
  static const String loginUrl = "$_basUrl/Login";
  static const String createNewTaskUrl = "$_basUrl/createTask";
  static const String newTaskListUrl = "$_basUrl/listTaskByStatus/New";
  static const String taskCountUrl = "$_basUrl/taskStatusCount";
  static String updateTaskUrl(String taskId, String status) =>
      "$_basUrl/updateTaskStatus/$taskId/$status";
}
