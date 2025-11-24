import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:decoro/features/notifications/data/repositories/notification_repository.dart';
import '../../data/models/notification_model.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repo;

  NotificationBloc(this.repo) : super(const NotificationState()) {
    on<LoadNotifications>(_onLoad);
    on<MarkAsRead>((event, emit) {
      final updated = state.notifications.map((n) {
        if (n == event.item) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();

      emit(state.copyWith(notifications: updated));
    });

    on<DeleteNotification>((event, emit) {
      final updated = List<NotificationModel>.from(state.notifications)
        ..remove(event.item);

      emit(state.copyWith(notifications: updated));
    });
  }



  Future<void> _onLoad(
      LoadNotifications event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(isLoading: true));

    final data = await repo.getNotifications();

    emit(
      state.copyWith(
        notifications: data,
        isLoading: false,
      ),
    );
  }
}