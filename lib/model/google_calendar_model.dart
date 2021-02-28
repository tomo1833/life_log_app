import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

import 'google_auth_model.dart';
import '../util/google_http_client.dart';
import '../util/google_calendar_event.dart';

/// Google calendar Model Class.
///
/// Google Calendar API Class for access and event registration.
class GoogleCalendarModel {
  static const String BUTTON_TITLE_START = '開始';
  static const String BUTTON_TITLE_END = '終了';
  static const int BUTTON_TYPE_START = 0;
  static const int BUTTON_TYPE_END = 1;

  // constructor
  GoogleCalendarModel();

  /// Event
  ///
  /// Register google Calendar API authentication and start / end event.
  /// [String] Calendar Summary.
  /// [int] 0:start 1:end
  Future<List> registEvent(String summary, int type) async {
    // Trigger the authentication flow
    GoogleSignInAccount googleUser =
        await GoogleAuthModel().googleSignIn.signIn();

    // Get user authentication header information from request
    GoogleHttpClient client = GoogleHttpClient(await googleUser.authHeaders);

    // Calendar API instance generation
    CalendarApi calendar = CalendarApi(client);

    // Registration destination calendar ID
    String calendarId = "primary";

    Event event;

     var _result = [];

    switch (type) {
      case BUTTON_TYPE_START:
        event = GoogleCalendarEvent(summary);
        await calendar.events.insert(event, calendarId).then((value) {
          if (value.status == "confirmed") {
            _result[0] = true;
            _result[1] = 'カレンダーに登録しました。';
            print('Successful addition of events');
          } else {
            _result[0] = false;
            _result[1] = 'カレンダーに登録できませんでした';
            print("Event addition failure");
          }
        });
        break;
      case BUTTON_TYPE_END:
        DateTime startFilter = GoogleCalendarEvent.getStartFilter();
        DateTime endFilter = DateTime.now().add(Duration(hours: 1)).toUtc();

        // Get the event list with the same title
        // from 1 day before the start to 1 hour after the end
        Events targetEvent = await calendar.events.list(
          calendarId,
          maxResults: 1,
          orderBy: 'startTime',
          singleEvents: true,
          timeMin: startFilter,
          timeMax: endFilter,
          q: summary,
        );

        int count = 0;
        // set hit event
        targetEvent.items.forEach((value) {
          event = value;
          count++;
        });

        if (count == 0) {
          _result[0] = true;
          _result[1] = '終了時間を更新するイベントがありませんでした。';
          return _result;
        }
        // set end time to now
        event.end = GoogleCalendarEvent.setEndDateTimeOfEnd();

        // event update
        await calendar.events.update(event, calendarId, event.id).then((value) {
          if (value.status == "confirmed") {
            _result[0] = true;
            _result[1] = 'カレンダーに登録しました。';
            print('Successful addition of events');
          } else {
            _result[0] = false;
            _result[1] = 'カレンダーに登録できませんでした';
            print("Event addition failure");
          }
        });
        break;
      default:
        break;
    }
    return _result;
  }
}
