enum Priority { low, medium, high }

class PriorityUtil {
  /// The function `getPriorityList` returns a list of strings containing the names of all elements in
  /// the `Priority` enum.
  ///
  /// Returns:
  ///   A list of strings representing the names of the elements in the Priority enum is being returned.
  static List<String> getPriorityList() {
    List<String> priorityList = [];
    for (var element in Priority.values) {
      priorityList.add(element.name);
    }
    return priorityList;
  }

  /// The function `getPriorityCount` returns a numerical value based on the priority level provided as
  /// an argument.
  ///
  /// Args:
  ///   priority (Priority): The `getPriorityCount` method takes a parameter `priority` of type
  /// `Priority?`, which is a nullable enum type `Priority`. The method checks the value of `priority`
  /// and returns an integer based on the priority level. If `priority` is `low`, it returns 1;
  ///
  /// Returns:
  ///   The `getPriorityCount` method returns an integer value based on the priority level provided as
  /// an argument. If the priority is `low`, it returns 1. If the priority is `medium`, it returns 2. If
  /// the priority is `high`, it returns 3. If the priority is `null` or not one of the defined priority
  /// levels, it returns 0.
  static int getPriorityCount(Priority? priority) {
    if (priority == Priority.low) {
      return 1;
    } else if (priority == Priority.medium) {
      return 2;
    } else if (priority == Priority.high) {
      return 3;
    } else {
      return 0;
    }
  }
}
