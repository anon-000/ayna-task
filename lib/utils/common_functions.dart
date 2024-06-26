import 'package:timeago/timeago.dart' as time_ago;

///
/// Created by Auro on 26/06/24
///

String timeInAgoShort(DateTime dateTime) {
  return time_ago.format(dateTime, locale: 'en_short', allowFromNow: true);
}


String timeInAgoFull(DateTime dateTime) {
  return time_ago.format(dateTime, locale: 'en', allowFromNow: true);
}