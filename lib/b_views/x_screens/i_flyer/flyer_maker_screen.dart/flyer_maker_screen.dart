import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/buttons/remaining_slides_counter.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerMakerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerMakerScreen({
    @required this.bzModel,
    @required this.firstTimer,
    @required this.flyerModel,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final bool firstTimer;
  final FlyerModel flyerModel;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _screenWidth = Scale.superScreenWidth(context);
    // final double _flyerBoxWidth = _screenWidth - (Ratioz.appBarMargin * 3) - FlyerBox.editorPanelWidth;

    // double _panelWidth = _screenWidth - _flyerBoxWidth - (Ratioz.appBarMargin * 3);
    // AuthorModel _author = widget.firstTimer ?
    // AuthorModel.getAuthorFromBzByAuthorID(widget.bzModel, superUserID()) :
    // AuthorModel.getAuthorFromBzByAuthorID(widget.bzModel, _flyer.tinyAuthor.userID);
    // BoxFit _currentPicFit = _superFlyer?.boxesFits?.length == 0 ? null : _superFlyer?.boxesFits[_superFlyer?.currentSlideIndex];

    return MainLayout(
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pyramidsAreOn: true,

      appBarRowWidgets: const <Widget>[
        RemainingSlidesCounter(),

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

          const Stratosphere(),

          /// FLYER & PANEL ZONES
          Container(
            height: Scale.superScreenHeightWithoutSafeArea(context) -
                Ratioz.stratosphere,
            alignment: Alignment.center,
            // child: FinalFlyer(
            //   flyerBoxWidth: _flyerBoxWidth,
            //   flyerModel: firstTimer == true ? null : flyerModel,
            //   goesToEditor: true,
            //   inEditor: true,
            //   bzModel: bzModel,
            //   onSwipeFlyer: (Sliders.SwipeDirection direction) {
            //     // print('Direction is $direction');
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
