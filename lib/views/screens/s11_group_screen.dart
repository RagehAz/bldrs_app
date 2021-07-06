import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/group_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/walls/group_wall.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget {
  final GroupModel groupModel;
  final FlyerType flyersType;

  GroupScreen({
    @required this.groupModel,
    @required this.flyersType,
  });

  @override
  Widget build(BuildContext context) {

    Widget _appBarKeywordButton =
    DreamBox(
      height: 40,
      verse: '${groupModel.firstKeyID}',
      bubble: false,
      color: Colorz.YellowLingerie,
      verseScaleFactor: 0.7,
      verseItalic: true,
      margins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding * 0.5),
    );


    return MainLayout(
      appBarType: AppBarType.Scrollable,

      pyramids: Iconz.DvBlankSVG,
      appBarRowWidgets: <Widget>[

        _appBarKeywordButton,

        SizedBox(
          width: Ratioz.appBarPadding * 0.5,
        ),

      ],
      sky: Sky.Night,
      layoutWidget:
      // _isLoading == true ?
      // Center(child: Loading(loading: _isLoading,))
      //     :
      GroupWall(
        groupModel: groupModel,
        flyersType: flyersType,
      ),
    );
  }
}
