import 'package:decoro/features/notifications/data/models/notification_model.dart';
import '../../../../config/constants/asset_paths.dart';

class NotificationRepository {
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();

    return [
      NotificationModel(
        title: "30% Special Discount!",
        subtitle: "Special promotion only valid today",
        imagePath: AssetPaths.notifDiscount,
        date: now,
      ),
      NotificationModel(
        title: "New Member Promotion",
        subtitle: "Special promo to all Apple device",
        imagePath: AssetPaths.notifUser,
        date: now,
      ),
      NotificationModel(
        title: "Special Offer! 40% Off",
        subtitle: "Special offer for new account, valid until 20 Nov 2022",
        imagePath: AssetPaths.notifDiscount,
        date: now.subtract(const Duration(days: 1)),
      ),
      NotificationModel(
        title: "Special Offer! 50% Off",
        subtitle: "Special offer for all users",
        imagePath: AssetPaths.notifDiscount,
        date: now.subtract(const Duration(days: 1)),
      ),
      NotificationModel(
        title: "Credit Card Connected",
        subtitle: "Special promotion only valid today",
        imagePath: AssetPaths.notifCard,
        date: now.subtract(const Duration(days: 1)),
      ),
    ];
  }
}