import 'package:intl/intl.dart';

class DateTimeDifferenceConverter {
  static String diffToString(DateTime otherDateTime) {
    final now = DateTime.now();

    if (dateEqual(now, otherDateTime)) {
      return todayDifference(now.difference(otherDateTime));
    } else {
      return differenceMoreThenDay(otherDateTime);
    }
  }

  static String differenceMoreThenDay(DateTime otherDate) {
    final now = DateTime.now();
    final difference = now.difference(otherDate);
    if (dateEqual(now.subtract(const Duration(hours: 24)), now.subtract(difference))) {
      return 'yesterday ${DateFormat('hh:mm').format(otherDate)}';
    } else {
      return '${DateFormat('yyyy.MM.dd').format(otherDate)} ${DateFormat('hh:mm').format(otherDate)}';
    }
  }

  static String todayDifference(Duration difference) {
    if (difference.inMinutes < 1) {
      return 'few seconds ago';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }

  static bool dateEqual(DateTime dt1, DateTime dt2) {
    return (DateFormat('yyyy.MM.dd').format(dt1) ==
        DateFormat('yyyy.MM.dd').format(dt2));
  }
}
