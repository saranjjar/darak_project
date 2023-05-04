import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String duTimeFormat(DateTime dt) {
  var now = DateTime.now();
  var difference = now.difference(dt);
  if (difference.inMinutes < 60) {
    return "${difference.inMinutes} m ago";
  }
  if (difference.inHours < 24) {

    return "${difference.inHours} h ago";
  }
  else if (difference.inDays < 30) {
    return "${difference.inDays} d ago";
  }
  else if (difference.inDays < 365) {
    final dtFormat = DateFormat('MM-dd');
    return dtFormat.format(dt);
  }
  else {
    final dtFormat = DateFormat('yyy-MM-dd');
    var str = dtFormat.format(dt);
    return str;
  }
}
