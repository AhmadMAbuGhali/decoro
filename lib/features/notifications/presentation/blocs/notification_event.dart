import 'package:equatable/equatable.dart';

import '../../data/models/notification_model.dart';

abstract class NotificationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotifications extends NotificationEvent {}

class MarkAsRead extends NotificationEvent {
  final NotificationModel item;
  MarkAsRead(this.item);

  @override
  List<Object?> get props => [item];
}

class DeleteNotification extends NotificationEvent {
  final NotificationModel item;
  DeleteNotification(this.item);

  @override
  List<Object?> get props => [item];
}