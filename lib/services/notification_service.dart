import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/date_time_helper.dart';
import 'background_service.dart';

class NotificationService {
  Future<bool> loadReminderStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isNotif') ?? false;
  }

  Future<bool> toggleNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotif', value);

    if (value) {
      return await AndroidAlarmManager.periodic(
        const Duration(days: 1),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      await AndroidAlarmManager.cancel(1);
      return false;
    }
  }
}
