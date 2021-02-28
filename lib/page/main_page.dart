import 'package:flutter/material.dart';
import '../model/google_calendar_model.dart';
import 'package:adobe_xd/pinned.dart';

/// Main page class.
///
/// This is the main page for registering achievements in the calendar.
/// [StatelessWidget]Inherits
class MainPage extends StatelessWidget {
  static const String PAGE_TITLE = 'Life Log';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5faf0),
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: ClipOval(
            child: Image(
              image: AssetImage('assets/images/images.png'),
            ),
          ),
        ),
        title: Text(
          PAGE_TITLE,
          style: TextStyle(
            fontFamily: 'Noto Sans',
            fontSize: 24,
            color: const Color(0xffffffff),
          ),
        ),
        backgroundColor: const Color(0xff6f9676),
      ),
      body: MainPageBody(),
    );
  }
}

/// MainPageBody class.
///
/// [StatelessWidget]Inherits
class MainPageBody extends StatelessWidget {
  static const int CATEGORY_INDEX_NAME = 0;
  static const int CATEGORY_INDEX_ICON = 1;

  @override
  Widget build(BuildContext context) {
    // Create LLifelog category widget List.
    List<Widget> categoryWidgets = makeCategoryWidgets(context);

    return Column(
      children: <Widget>[
        // description
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 30, left: 25, bottom: 10),
          child: Text(
            'ワンタッチで日々を記録しよう',
            style: TextStyle(
              fontFamily: 'Noto Sans',
              fontSize: 14,
              color: const Color(0xff2e2e2e),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
          child: Wrap(
            children: <Widget>[
              categoryWidgets[0],
              categoryWidgets[1],
              categoryWidgets[2],
              categoryWidgets[3],
            ],
          ),
        ),
      ],
    );
  }

  /// Lifelog category widget List.
  ///
  /// List of parts widgets in the Liflog category.
  /// [Widget] return category widgets list
  List<Widget> makeCategoryWidgets(BuildContext context) {
    List<Widget> categoryWidgets = [];

    List<List<dynamic>> _category = [
      ['仕事', Icons.work],
      ['睡眠', Icons.local_hotel],
      ['勉強', Icons.school],
      ['運動', Icons.fitness_center],
    ];

    _category.forEach((List<dynamic> values) {
      categoryWidgets.add(makeCategoryWidget(
        context,
        values[CATEGORY_INDEX_NAME],
        values[CATEGORY_INDEX_ICON],
      ));
    });

    return categoryWidgets;
  }

  /// Lifelog category widget.
  ///
  /// Liflog category parts widget.
  /// [String] category name
  /// [Icon] category icon
  ///
  /// [Widget] return lifelog category Widget.
  Widget makeCategoryWidget(
      BuildContext context, String categoryName, IconData icons) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 20, bottom: 20),
      width: 155,
      height: 172,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 30,
                  height: 22,
                  child: Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 22.0, 22.0),
                        size: Size(30.0, 22.0),
                        pinLeft: true,
                        pinTop: true,
                        pinBottom: true,
                        fixedWidth: true,
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(0.0, 0.0, 22.0, 22.0),
                              size: Size(22.0, 22.0),
                              pinLeft: true,
                              pinRight: true,
                              pinTop: true,
                              pinBottom: true,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                  color: const Color(0xff6f9676),
                                ),
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(5.0, 5.0, 12.0, 11.4),
                              size: Size(22.0, 22.0),
                              child: Icon(icons,
                                  color: const Color(0xffffffff), size: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  categoryName,
                  style: TextStyle(
                    fontFamily: 'Noto Sans',
                    fontSize: 16,
                    color: const Color(0xff2e2e2e),
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                makeEventButton(context, categoryName, '開始',
                    GoogleCalendarModel.BUTTON_TYPE_START),
                makeEventButton(context, categoryName, '終了',
                    GoogleCalendarModel.BUTTON_TYPE_END),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Event button widget.
  ///
  /// Start / End Button Parts Widget.
  /// [String] Category name
  /// [String] Calendar Summary.
  /// [int] 0:start 1:end
  ///
  /// [Widget] return Event button Widget.
  Widget makeEventButton(
      BuildContext context, String categoryName, String nameTitle, int type) {
    int backGroundColor = 0;
    int textColor = 0;
    switch (type) {
      case GoogleCalendarModel.BUTTON_TYPE_START:
        textColor = 0xffffffff;
        backGroundColor = 0xff6f9676;
        break;
      case GoogleCalendarModel.BUTTON_TYPE_END:
        textColor = 0xff6f9676;
        backGroundColor = 0xffffffff;
        break;
      default:
        break;
    }

    return InkWell(
      onTap: () async {
        List _result = await _registEventAction(categoryName, type);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_result[1])));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 5.0),
        child: SizedBox(
          width: 135,
          height: 40,
          child: Stack(
            children: <Widget>[
              Pinned.fromSize(
                bounds: Rect.fromLTWH(0.0, 0.0, 135.0, 40.0),
                size: Size(135.0, 40.0),
                pinLeft: true,
                pinRight: true,
                pinTop: true,
                pinBottom: true,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Color(backGroundColor),
                    border: Border.all(
                      width: 1.0,
                      color: Color(textColor),
                    ),
                  ),
                ),
              ),
              Pinned.fromSize(
                bounds: Rect.fromLTWH(54.0, 10.0, 28.0, 19.0),
                size: Size(135.0, 40.0),
                fixedWidth: true,
                fixedHeight: true,
                child: Text(
                  nameTitle,
                  style: TextStyle(
                    fontFamily: 'Noto Sans',
                    fontSize: 14,
                    color: Color(textColor),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Event registration action.
  ///
  /// [String] Calendar Summary.
  /// [int] 0:start 1:end
  _registEventAction(String summary, int type) async {
    GoogleCalendarModel googleCalendarModel = GoogleCalendarModel();
    return googleCalendarModel.registEvent(summary, type);
  }
}
