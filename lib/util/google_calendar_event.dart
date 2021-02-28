import 'package:googleapis/calendar/v3.dart';

/// google calendar event extension class.
///
///
class GoogleCalendarEvent extends Event {
  static const String JAPAN_TIME_ZONE = "GMT+09:00";

  // Constructor
  GoogleCalendarEvent(String summary) {
    this.summary = summary;
    this.start = setStartDateTimeOfStart();
    this.end = setEndDateTimeOfStart();
  }

  /// Set the start date and time of the start event.
  ///
  static EventDateTime setStartDateTimeOfStart() {
    EventDateTime _start = EventDateTime();
    _start.dateTime = DateTime.now();
    _start.timeZone = JAPAN_TIME_ZONE;
    return _start;
  }

  /// Set the end date and time of the start event.
  ///
  static EventDateTime setEndDateTimeOfStart() {
    EventDateTime _end = EventDateTime();
    _end.dateTime = DateTime.now().add(Duration(hours: 1));
    _end.timeZone = JAPAN_TIME_ZONE;
    return _end;
  }

  /// Set the end date and time of the end event.
  ///
  static EventDateTime setEndDateTimeOfEnd() {
    EventDateTime _end = EventDateTime();
    _end.timeZone = JAPAN_TIME_ZONE;
    _end.dateTime = DateTime.now();
    return _end;
  }

  /// Get stat filter.
  ///
  /// Use a filter to get data for the start date one day ago
  static DateTime getStartFilter() {
    return DateTime.now().subtract(Duration(days: 1)).toUtc();
  }

  /// Get end filter.
  ///
  /// Use the filter to get the data for the end date after 1 hour
  static DateTime getEndFilter() {
    return DateTime.now().add(Duration(hours: 1)).toUtc();
  }
}
