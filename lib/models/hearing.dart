import 'package:flutter/material.dart';

class Hearing {
  final String caseNumber;
  final String title;
  final String client;
  final String date;
  final HearingStatus status;
  final int remainingDays;

  Hearing({
    required this.caseNumber,
    required this.title,
    required this.client,
    required this.date,
    required this.status,
    required this.remainingDays,
  });
}

enum HearingStatus {
  scheduled,
  completed,
  cancelled;

  String get label {
    switch (this) {
      case HearingStatus.scheduled:
        return 'مجدولة';
      case HearingStatus.completed:
        return 'مكتملة';
      case HearingStatus.cancelled:
        return 'ملغاة';
    }
  }

  Color get color {
    switch (this) {
      case HearingStatus.scheduled:
        return Colors.blue;
      case HearingStatus.completed:
        return Colors.green;
      case HearingStatus.cancelled:
        return Colors.red;
    }
  }
} 