import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/panel_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';

class EditorPanel extends StatelessWidget {
  final double flyerZoneWidth;
  final BoxFit boxFit;
  final double panelWidth;
  final bool showAuthor;
  final Function onAuthorTap;
  final Function onTriggerEditMode;
  final Zone zone;
  final FlyerType flyerType;
  final Function onFlyerTypeTap;
  final Function onZoneTap;
  final Function onAboutTap;
  final Function onKeywordsTap;
  final DraftFlyerModel draft;

  EditorPanel({
    @required this.flyerZoneWidth,
    @required this.boxFit,
    @required this.panelWidth,
    @required this.showAuthor,
    @required this.onAuthorTap,
    @required this.onTriggerEditMode,
    @required this.zone,
    @required this.flyerType,
    @required this.onFlyerTypeTap,
    @required this.onZoneTap,
    @required this.onAboutTap,
    @required this.onKeywordsTap,
    @required this.draft,
});
// -----------------------------------------------------------------------------
  Widget _expander(){
    return
        // Container();
      Expanded(child: Container(),);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // print('draft picture screen');

    // double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    double _panelWidth = panelWidth;
    double _buttonSize = panelWidth;//_panelWidth - (Ratioz.appBarMargin * 2);

    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, flyerZoneWidth);

    double _panelButtonSize = _buttonSize * 0.8;

    double _panelHeight = _flyerZoneHeight;

    AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(draft.bzModel, draft.authorID);

    BoxFit _currentPicFit = boxFit;

    // ImageSize _originalAssetSize = _assets.length == 0 || _assets == null ? null : ImageSize(
    //   width: _assets[_draft.currentSlideIndex].originalWidth,
    //   height: _assets[_draft.currentSlideIndex].originalHeight,
    // );

    double _authorButtonHeight = Ratioz.xxflyerLogoWidth * flyerZoneWidth;

// -----------------------------------------------------------------------------

    return Container(
      width: _panelWidth,
      height: _panelHeight,
      alignment: Alignment.topCenter,
      // color: Colorz.White200,
      child: Column(
        // shrinkWrap: true,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          /// SHOW AUTHOR
          DreamBox(
            height: _authorButtonHeight,
            // margins: EdgeInsets.symmetric(vertical: (Ratioz.xxflyerHeaderMiniHeight - Ratioz.xxflyerLogoWidth) * _flyerZoneWidth / 2),
            width: _buttonSize,
            color: showAuthor == true ? Colorz.White80 : Colorz.White80,
            icon: _author.authorPic,
            iconSizeFactor: 0.5,
            underLine: showAuthor == true ? 'Author Shown' : 'Author Hidden',
            underLineShadowIsOn: false,
            underLineColor: showAuthor == true ? Colorz.White255 : Colorz.White80,
            corners: Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * flyerZoneWidth),
            blackAndWhite: showAuthor == true ? false : true,
            bubble: showAuthor == true ? true : false,
            onTap: onAuthorTap,
          ),

          /// SPACER
          _expander(),

          // PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

          /// ADD IMAGE
          PanelButton(
            flyerZoneWidth: flyerZoneWidth,
            icon:  Iconz.Gears,
            iconSizeFactor: 0.5,
            verse: draft.editMode ? 'Editing' : 'Edit',
            verseColor: draft.editMode ? Colorz.Black255 : Colorz.White255,
            color: draft.editMode ? Colorz.Yellow255 : Colorz.White80,
            onTap: onTriggerEditMode,
          ),


        ],
      ),
    );
  }
}
