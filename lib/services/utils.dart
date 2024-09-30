import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Utils {
  String convertTimeStampToString(Timestamp timestamp) {
    DateTime dt = timestamp.toDate();

    // 12 Hour format:
    var d12 = DateFormat('MM/dd, hh:mm a').format(dt);
    return d12;
  }
}
