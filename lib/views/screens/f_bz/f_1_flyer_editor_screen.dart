import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/general/buttons/slides_counter.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class FlyerEditorScreen extends StatelessWidget {
  final BzModel bzModel;
  final bool firstTimer;
  final TinyFlyer tinyFlyer;

  FlyerEditorScreen({
    @required this.bzModel,
    @required this.firstTimer,
    @required this.tinyFlyer,
  });

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _flyerBoxWidth = _screenWidth - (Ratioz.appBarMargin * 3) - FlyerBox.editorPanelWidth();

    // double _panelWidth = _screenWidth - _flyerBoxWidth - (Ratioz.appBarMargin * 3);
    // AuthorModel _author = widget.firstTimer ?
    // AuthorModel.getAuthorFromBzByAuthorID(widget.bzModel, superUserID()) :
    // AuthorModel.getAuthorFromBzByAuthorID(widget.bzModel, _flyer.tinyAuthor.userID);
    // BoxFit _currentPicFit = _superFlyer?.boxesFits?.length == 0 ? null : _superFlyer?.boxesFits[_superFlyer?.currentSlideIndex];

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarRowWidgets: <Widget>[

        SlidesCounter(),

        Expander(),

        // PublishButton(
        //     firstTimer: firstTimer,
        //     loading: false, /// TASK : add loading to superFlyer
        //     onTap: (){
        //
        //       //widget.firstTimer ? _superFlyer.createNewFlyer : _superFlyer.updateExistingFlyer,
        //
        //       print('fuck the fucking null');
        //
        //     }
        // ),

      ],

      layoutWidget: Column(
        // physics: NeverScrollableScrollPhysics(),
        children: <Widget>[

          Stratosphere(),

          /// FLYER & PANEL ZONES
          Container(
            height: Scale.superScreenHeightWithoutSafeArea(context) - Ratioz.stratosphere,
            alignment: Alignment.center,
            child: FinalFlyer(
              flyerBoxWidth: _flyerBoxWidth,
              flyerModel: null,
              tinyFlyer: firstTimer == true ? null : tinyFlyer, // redundant
              goesToEditor: true,
              initialSlideIndex: 0,
              inEditor: true,
              bzModel: bzModel,
              onSwipeFlyer: (SwipeDirection direction){
                // print('Direction is $direction');
              },
            ),
          ),



        ],
      ),
    );
  }
}