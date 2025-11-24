import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String subtitle;
  final String imagePath;
  final DateTime date;
  final bool isRead;

  const NotificationModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.date,
    this.isRead = false,
  });

  NotificationModel copyWith({
    String? title,
    String? subtitle,
    String? imagePath,
    DateTime? date,
    bool? isRead,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [title, subtitle, imagePath, date, isRead];
}