import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/providers/dio/dio_helper.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/testing_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioTestScreen extends StatefulWidget {


  @override
  _DioTestScreenState createState() => _DioTestScreenState();
}

class _DioTestScreenState extends State<DioTestScreen> {

  String _urlBase = 'https://newsapi.org/';
  String _urlMethod = 'v2/everything';
  String _urlQuery = 'q=tesla&from=2021-07-27&sortBy=publishedAt&apiKey=c9310946a75a41cea25af88c5d88ced5';

  @override
  void initState() {
    super.initState();

    DioHelper.init(baseURL: _urlBase);

  }

  Future<void> _getURLData() async {

    await tryAndCatch(
      context: context,
      methodName: '_getURLData',
      functions: () async {

        Response<dynamic> _response = await DioHelper.getData(
          url: _urlMethod,
          query: Mapper.getMapFromURLQuery(urlQuery: _urlQuery),
        );

        print(_response);

      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return TestingLayout(
        screenTitle: 'Dio test',
        appbarButtonVerse: 'button',
        appbarButtonOnTap: (){},
        listViewWidgets: <Widget>[

          DreamBox(
            width: 100,
            height: 50,
            verse: 'thing',
            verseScaleFactor: 0.7,
            onTap: _getURLData,
          ),

        ],
    );
  }
}
