import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/layouts/dream_list.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/filter.dart';
import 'package:bldrs/xxx_LABORATORY/flyer_browser/keyword_model.dart';
import 'package:flutter/material.dart';

class Pict{
  final String name;
  final String path;

  Pict({
    @required this.name,
    @required this.path,
  });
}

class Box{
  final Pict pic;
  final double size;

  Box({
    @required this.pic,
    @required this.size,
  });
}

class PictureTestScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    List<KeywordModel> _keywords = KeywordModel.bldrsKeywords;

    return MainLayout(
      pageTitle: 'Pictures Test',
      appBarRowWidgets: <Widget>[],
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      appBarBackButton: true,
      layoutWidget:
        Container(
          width: Scale.superScreenWidth(context),
          height: double.infinity,
          child: ListView.builder(
            itemCount: _keywords.length,
            padding: EdgeInsets.only(top: Ratioz.stratosphere),
            itemBuilder: (context, index){
              return
                DreamBox(
                  height: 80,
                  width: Scale.superScreenWidth(context)-10,
                  boxMargins: 5,
                  color: Colorz.Nothing,
                  icon: KeywordModel.getImagePath(_keywords[index].id),
                  verse: '$index : ${_keywords[index].name}',
                  verseScaleFactor: 0.6,
                  secondLine: '${_keywords[index].filterID} / ${_keywords[index].groupID} / ${_keywords[index].subGroupID}',
                  boxFunction: (){
                    print('$index : ${_keywords[index].id}');
                  },
                );
            },
          ),
        )

    );
  }
}
