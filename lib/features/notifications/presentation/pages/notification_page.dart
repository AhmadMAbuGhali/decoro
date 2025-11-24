import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notification_repository.dart';
import '../blocs/notification_bloc.dart';
import '../blocs/notification_event.dart';
import '../blocs/notification_state.dart';
import '../widgets/notification_item.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      NotificationBloc(NotificationRepository())..add(LoadNotifications()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Notification")),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final now = DateTime.now();

            final today = state.notifications
                .where((n) =>
            n.date.year == now.year &&
                n.date.month == now.month &&
                n.date.day == now.day)
                .toList();

            final yesterday = state.notifications
                .where((n) =>
            n.date.year == now.year &&
                n.date.month == now.month &&
                n.date.day == now.day - 1)
                .toList();

            return ListView(
              children: [
                if (today.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("Today",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                  ...today.map((e) => NotificationItem(item: e,
                    onRead: () {
                      context.read<NotificationBloc>().add(MarkAsRead(e));
                    },
                    onDelete: () {
                      context.read<NotificationBloc>().add(DeleteNotification(e));
                    },)),
                ],

                if (yesterday.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("Yesterday",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                  ...yesterday.map((e) => NotificationItem(item: e,
                    onRead: () {
                      context.read<NotificationBloc>().add(MarkAsRead(e));
                    },
                    onDelete: () {
                      context.read<NotificationBloc>().add(DeleteNotification(e));
                    },)),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}