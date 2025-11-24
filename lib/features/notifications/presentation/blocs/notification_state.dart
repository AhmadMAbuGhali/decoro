import 'package:equatable/equatable.dart';
import '../../data/models/notification_model.dart';

class NotificationState extends Equatable {
  final List<NotificationModel> notifications;
  final bool isLoading;

  const NotificationState({
    this.notifications = const [],
    this.isLoading = false,
  });

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [notifications, isLoading];
}