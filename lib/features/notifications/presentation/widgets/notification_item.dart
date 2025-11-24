import 'package:flutter/material.dart';
import '../../data/models/notification_model.dart';

class NotificationItem extends StatefulWidget {
  final NotificationModel item;
  final VoidCallback onRead;
  final VoidCallback onDelete;

  const NotificationItem({
    super.key,
    required this.item,
    required this.onRead,
    required this.onDelete,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => widget.onDelete(),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.redAccent,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            onTap: widget.onRead,
            leading: Image.asset(widget.item.imagePath, width: 40, height: 40),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.item.title,
                    style: TextStyle(
                      fontWeight: widget.item.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                ),

                // ● نقطة unread
                if (!widget.item.isRead)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            subtitle: Text(widget.item.subtitle),
          ),
        ),
      ),
    );
  }
}