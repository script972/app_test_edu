import 'package:intl/intl.dart';

class DateUtil {
  DateTime nowTime = DateTime.now();
  static final DateFormat globalAppDateFormat =
      DateFormat('dd EEEEE yy', 'en_US');

  late int hourTimeNow =
      int.parse(DateFormat('HOUR').format(nowTime).substring(0, 2));
  late String dayOfWeek = DateFormat('EEEE').format(nowTime);
}
