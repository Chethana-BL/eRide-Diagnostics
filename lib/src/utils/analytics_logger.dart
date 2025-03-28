import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AnalyticsEvent {
  bikeConnected,
  bikeDisconnected,
  errorOccurred,
}

extension AnalyticsEventExtension on AnalyticsEvent {
  String get eventName {
    switch (this) {
      case AnalyticsEvent.bikeConnected:
        return "Bike Connected";
      case AnalyticsEvent.bikeDisconnected:
        return "Bike Disconnected";
      case AnalyticsEvent.errorOccurred:
        return "Error Occurred";
    }
  }
}

class AnalyticsLogger {
  static void logEvent(AnalyticsEvent event,
      {String? bikeId, String? errorMessage}) {
    final logData = {
      "event": event.eventName,
      "timestamp": DateFormat("yyyy-MM-ddTHH:mm:ssZ").format(DateTime.now()),
    };

    if (bikeId != null) {
      logData["bikeId"] = bikeId;
    }

    if (event == AnalyticsEvent.errorOccurred && errorMessage != null) {
      logData["errorMessage"] = errorMessage;
    }

    debugPrint("Analytics Event: ${jsonEncode(logData)}");
  }
}
