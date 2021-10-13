import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/specific/flyer/editor/panel_button.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/theme/colorz.dart';

class EditorPanel extends StatelessWidget {
  final SuperFlyer superFlyer;
  final BzModel bzModel;
  final double flyerBoxWidth;
  final double panelWidth;

  const EditorPanel({
    @required this.superFlyer,
    @required this.bzModel,
    @required this.flyerBoxWidth,
    @required this.panelWidth,
});
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // print('draft picture screen');

    // double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    final double _panelWidth = panelWidth;
    final double _buttonSize = panelWidth;//_panelWidth - (Ratioz.appBarMargin * 2);

    final double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);

    // double _panelButtonSize = _buttonSize * 0.8;

    final double _panelHeight = _flyerZoneHeight;

    final AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(bzModel, superFlyer?.authorID);

    // BoxFit _currentPicFit = superFlyer?.currentPicFit;

    // ImageSize _originalAssetSize = _assets.length == 0 || _assets == null ? null : ImageSize(
    //   width: _assets[_draft.currentSlideIndex].originalWidth,
    //   height: _assets[_draft.currentSlideIndex].originalHeight,
    // );

    final double _authorButtonHeight = Ratioz.xxflyerLogoWidth * flyerBoxWidth;
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
            // margins: EdgeInsets.symmetric(vertical: (Ratioz.xxflyerHeaderMiniHeight - Ratioz.xxflyerLogoWidth) * _flyerBoxWidth / 2),
            width: _buttonSize,
            color: superFlyer.flyerShowsAuthor == true ? Colorz.White80 : Colorz.White80,
            icon: _author?.pic,
            iconSizeFactor: 0.5,
            underLine: superFlyer.flyerShowsAuthor == true ? 'Author Shown' : 'Author Hidden',
            underLineShadowIsOn: false,
            underLineColor: superFlyer.flyerShowsAuthor == true ? Colorz.White255 : Colorz.White80,
            corners: Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * flyerBoxWidth),
            blackAndWhite: superFlyer.flyerShowsAuthor == true ? false : true,
            bubble: superFlyer.flyerShowsAuthor == true ? true : false,
            onTap: superFlyer.edit.onShowAuthorTap,
          ),

          /// SPACER
          const Expander(),

          // PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

          /// DELETE FLYER button
          if(superFlyer.edit.editMode == true && superFlyer.edit.firstTimer == false)
            PanelButton(
              flyerBoxWidth: flyerBoxWidth,
              icon:  Iconz.XSmall,
              iconSizeFactor: 0.5,
              verse: 'Delete',
              verseColor: Colorz.White255,

              /// TASK : if all fields are valid should be green otherWise should be inActive
              color: Colorz.Red230,
              onTap: superFlyer.edit.onDeleteFlyer,
            ),

          /// Publish button
          if(superFlyer.edit.editMode == true)
          PanelButton(
            flyerBoxWidth: flyerBoxWidth,
            icon:  Iconz.ArrowUp,
            iconSizeFactor: 0.5,
            verse: superFlyer.edit.firstTimer ? 'Publish' : 'Update',
            verseColor: superFlyer.edit.editMode ? Colorz.Black255 : Colorz.White255,

            /// TASK : if all fields are valid should be green otherWise should be inActive
            color: Colorz.Green255,
            onTap: superFlyer.edit.onPublishFlyer,
          ),

          /// TRIGGER EDIT MODE
          PanelButton(
            flyerBoxWidth: flyerBoxWidth,
            icon: superFlyer.edit.editMode == true ? Iconz.Gears : Iconz.Views,
            iconSizeFactor: 0.5,
            verse: superFlyer.edit.editMode == true ? 'Editing' : 'Viewing',
            verseColor: superFlyer.edit.editMode == true ? Colorz.Black255 : Colorz.White255,
            color: superFlyer.edit.editMode == true ? Colorz.Yellow255 : Colorz.White80,
            onTap: superFlyer.edit.onTriggerEditMode,
          ),


        ],
      ),
    );
  }
}
