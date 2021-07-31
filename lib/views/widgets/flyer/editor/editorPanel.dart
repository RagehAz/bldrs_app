import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/editor/panel_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/theme/colorz.dart';

class EditorPanel extends StatelessWidget {
  final SuperFlyer superFlyer;
  final BzModel bzModel;
  final double flyerZoneWidth;
  final double panelWidth;

  EditorPanel({
    @required this.superFlyer,
    @required this.bzModel,
    @required this.flyerZoneWidth,
    @required this.panelWidth,
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

    AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(bzModel, superFlyer.authorID);

    BoxFit _currentPicFit = superFlyer.currentPicFit;

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
            color: superFlyer.flyerShowsAuthor == true ? Colorz.White80 : Colorz.White80,
            icon: _author?.authorPic,
            iconSizeFactor: 0.5,
            underLine: superFlyer.flyerShowsAuthor == true ? 'Author Shown' : 'Author Hidden',
            underLineShadowIsOn: false,
            underLineColor: superFlyer.flyerShowsAuthor == true ? Colorz.White255 : Colorz.White80,
            corners: Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * flyerZoneWidth),
            blackAndWhite: superFlyer.flyerShowsAuthor == true ? false : true,
            bubble: superFlyer.flyerShowsAuthor == true ? true : false,
            onTap: superFlyer.onShowAuthorTap,
          ),

          /// SPACER
          _expander(),

          // PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

          /// DELETE FLYER button
          if(superFlyer.editMode == true && superFlyer.firstTimer == false)
            PanelButton(
              flyerZoneWidth: flyerZoneWidth,
              icon:  Iconz.XSmall,
              iconSizeFactor: 0.5,
              verse: 'Delete',
              verseColor: Colorz.White255,

              /// TASK : if all fields are valid should be green otherWise should be inActive
              color: Colorz.Red230,
              onTap: superFlyer.onDeleteFlyer,
            ),

          /// Publish button
          if(superFlyer.editMode == true)
          PanelButton(
            flyerZoneWidth: flyerZoneWidth,
            icon:  Iconz.ArrowUp,
            iconSizeFactor: 0.5,
            verse: superFlyer.firstTimer ? 'Publish' : 'Update',
            verseColor: superFlyer.editMode ? Colorz.Black255 : Colorz.White255,

            /// TASK : if all fields are valid should be green otherWise should be inActive
            color: Colorz.Green255,
            onTap: superFlyer.onPublishFlyer,
          ),

          /// TRIGGER EDIT MODE
          PanelButton(
            flyerZoneWidth: flyerZoneWidth,
            icon: superFlyer.editMode == true ? Iconz.Gears : Iconz.Views,
            iconSizeFactor: 0.5,
            verse: superFlyer.editMode == true ? 'Editing' : 'Viewing',
            verseColor: superFlyer.editMode == true ? Colorz.Black255 : Colorz.White255,
            color: superFlyer.editMode == true ? Colorz.Yellow255 : Colorz.White80,
            onTap: superFlyer.onTriggerEditMode,
          ),


        ],
      ),
    );
  }
}
