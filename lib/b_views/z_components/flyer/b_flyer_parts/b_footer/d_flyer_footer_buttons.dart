import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/f_footer_button_spacer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerFooterButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooterButtons({
    @required this.flyerID,
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.onSaveFlyer,
    @required this.onReviewFlyer,
    @required this.onShareFlyer,
    @required this.inFlight,
    @required this.infoButtonType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final String flyerID;
  final bool tinyMode;
  final Function onSaveFlyer;
  final Function onReviewFlyer;
  final Function onShareFlyer;
  final bool inFlight;
  final InfoButtonType infoButtonType;
  /// --------------------------------------------------------------------------
  bool _canShowElement(){
    bool _canShow = true;
    if (tinyMode == true){
        if (infoButtonType == InfoButtonType.info){
          _canShow = false;
        }
    }
    return _canShow;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _spacer = FooterButtonSpacer(
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode
    );

    final bool _canShow = _canShowElement();

    return Positioned(
      right: Aligners.rightPositionInRightAlignmentEn(context, 0),
      left: Aligners.leftPositionInRightAlignmentEn(context, 0),
      bottom: 0,
      child: Row(
        children: <Widget>[

          if (_canShow == true)
          _spacer,

          /// SHARE
          if (_canShow == true)
            FooterButton(
            flyerBoxWidth: flyerBoxWidth,
            icon: Iconz.share,
            verse: superPhrase(context, 'phid_send'),
            isOn: false,
            tinyMode: tinyMode,
            onTap: onShareFlyer,
          ),

          if (_canShow == true)
            _spacer,

          /// COMMENT
          if (_canShow == true)
            FooterButton(
            flyerBoxWidth: flyerBoxWidth,
            icon: Iconz.utPlanning,
            verse: 'Review',
            isOn: false,
            tinyMode: tinyMode,
            onTap: onReviewFlyer,
          ),

          if (_canShow == true)
            _spacer,

          /// SAVE BUTTON
          Selector<FlyersProvider, List<FlyerModel>>(
            selector: (_, FlyersProvider flyersProvider) => flyersProvider.savedFlyers,
            builder: (_, List<FlyerModel> _savedFlyers, Widget child){

              final bool _isSaved = FlyerModel.flyersContainThisID(
                  flyerID: flyerID,
                  flyers: _savedFlyers,
              );

              return FooterButton(
                flyerBoxWidth: flyerBoxWidth,
                icon: Iconz.save,
                verse: _isSaved == true ? superPhrase(context, 'phid_saved') : superPhrase(context, 'phid_save'),
                isOn: _isSaved,
                tinyMode: tinyMode,
                onTap: onSaveFlyer,
              );

            },
          ),

          _spacer,

        ],
      ),
    );
  }
}
