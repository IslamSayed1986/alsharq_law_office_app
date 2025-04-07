import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String dueDate;
  final TaskStatus status;
  final TaskPriority priority;
  final String assignedTo;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.dueDate,
    required this.status,
    required this.priority,
    required this.assignedTo,
  });
}

enum TaskPriority {
  high,
  medium,
  low;

  String get label {
    switch (this) {
      case TaskPriority.high:
        return 'عالية';
      case TaskPriority.medium:
        return 'متوسطة';
      case TaskPriority.low:
        return 'منخفضة';
    }
  }

  Color get color {
    switch (this) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }
}

enum TaskStatus {
  inProgress,
  pending,
  overdue;

  String get label {
    switch (this) {
      case TaskStatus.inProgress:
        return 'قيد التنفيذ';
      case TaskStatus.pending:
        return 'معلق';
      case TaskStatus.overdue:
        return 'متأخر';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.pending:
        return Colors.grey;
      case TaskStatus.overdue:
        return Colors.red;
    }
  }
} 