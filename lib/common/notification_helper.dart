import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  // 1. Inisialisasi (Panggil ini di main.dart atau initState awal)
  static Future init() async {
    tz.initializeTimeZones(); // Load database waktu

    // Android Settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // Pastikan icon app (@mipmap/ic_launcher) ada di folder android/app/src/main/res/

    // iOS Settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notification.initialize(settings);
  }

  // 2. Jadwalkan Notifikasi Harian
  static Future scheduleDailyNotification(int hour, int minute) async {
    await _notification.zonedSchedule(
      1, // ID Notifikasi (unik)
      'Pengingat Harian', // Judul
      'Jangan lupa catat pengeluaranmu hari ini!', // Isi Pesan
      _nextInstanceOfTime(hour, minute), // Waktu
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel', // ID Channel
          'Daily Reminder', // Nama Channel
          channelDescription: 'Channel for daily reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents:
          DateTimeComponents.time, // Agar berulang setiap hari di jam yg sama
    );
  }

  // 3. Batalkan Notifikasi
  static Future cancelNotification() async {
    await _notification.cancel(1); // Batalkan ID 1
  }

  // Helper: Menentukan waktu notifikasi berikutnya
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    // Jika waktu sudah lewat hari ini, jadwalkan besok
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
