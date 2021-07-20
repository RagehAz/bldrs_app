import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/panel_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';

class EditorPanel extends StatelessWidget {
  final double flyerZoneWidth;
  final AuthorModel author;
  final BoxFit boxFit;
  final double panelWidth;
  final bool showAuthor;
  final Function onAuthorTap;
  final Function onAddImage;
  final Function onDeleteImage;
  final Function onCropImage;
  final Function onResetImage;
  final Function onFitImage;
  final PageController panelController;
  final Zone zone;

  EditorPanel({
    @required this.flyerZoneWidth,
    @required this.author,
    @required this.boxFit,
    @required this.panelWidth,
    @required this.showAuthor,
    @required this.onAuthorTap,
    @required this.onAddImage,
    @required this.onDeleteImage,
    @required this.onCropImage,
    @required this.onResetImage,
    @required this.onFitImage,
    @required this.panelController,
    @required this.zone,
});
// -----------------------------------------------------------------------------
  Widget _expander(){
    return
      Expanded(child: Container(),);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // print('draft picture screen');

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    double _panelWidth = panelWidth;
    double _buttonSize = panelWidth;//_panelWidth - (Ratioz.appBarMargin * 2);

    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, flyerZoneWidth);

    double _panelButtonSize = _buttonSize * 0.8;

    double _panelHeight = _flyerZoneHeight;

    AuthorModel _author = author;

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

          /// PANEL BUTTONS ZONE
          Container(
            width: _panelWidth,
            height: _panelHeight - _authorButtonHeight,
            // color: Colorz.BloodTest,
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: panelController,
              scrollDirection: Axis.vertical,
              children: <Widget>[

                /// SLIDES PAGE BUTTONS
                Container(
                  width: _panelWidth,
                  height: _panelHeight - _authorButtonHeight,
                  // color: Colorz.BloodTest,
                  child: Column(
                    children: <Widget>[

                      /// SPACER
                      _expander(),

                      /// ADD IMAGE
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        icon:  Iconz.Plus,
                        iconSizeFactor: 0.5,
                        verse: 'Add',
                        onTap: onAddImage,
                      ),

                      /// DELETE IMAGE
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        icon:  Iconz.XSmall,
                        iconSizeFactor: 0.5,
                        verse: 'Delete',
                        onTap: onDeleteImage,
                      ),

                      PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

                      /// CROP IMAGE
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        icon:  Iconz.BxDesignsOff,
                        iconSizeFactor: 0.5,
                        verse: 'Crop',
                        onTap: onCropImage,
                      ),

                      /// RELOAD
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        icon:  Iconz.Clock,
                        iconSizeFactor: 0.5,
                        verse: 'Reset',
                        onTap: onResetImage,
                      ),

                      PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

                      /// CHANGE SLIDE BOX FIT
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        verse: 'Fit',
                        icon: _currentPicFit == BoxFit.fitWidth ? Iconz.ArrowRight : _currentPicFit == BoxFit.fitHeight ? Iconz.ArrowUp : Iconz.DashBoard,
                        iconSizeFactor: 0.35,
                        isAuthorButton: false,
                        onTap: onFitImage,
                      ),


                      /// SPACER
                      _expander(),

                      /// BOTTOM SPACING
                      // SizedBox(
                      //   //Ratioz.xxflyerBottomCorners * _flyerZoneWidth - Ratioz.appBarPadding,
                      //   height: Scale.superFlyerFooterHeight(_flyerZoneWidth),
                      // ),

                    ],
                  ),
                ),

                /// INFO PAGE BUTTONS
                Container(
                  width: _panelWidth,
                  height: _panelHeight - _authorButtonHeight,
                  // color: Colorz.White50,
                  child: Column(
                    children: <Widget>[

                      /// SPACER
                      _expander(),

                      /// Flyer type
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        icon:  Iconz.Flyer,
                        iconSizeFactor: 0.5,
                        verse: 'Type',
                        onTap: onCropImage,
                      ),

                      PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

                      /// Country
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        icon:  Flagz.getFlagByIso3(zone.countryID),
                        iconSizeFactor: 0.62,
                        verse: 'Target',
                        onTap: onCropImage,
                      ),

                      /// About
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        icon: Iconz.Info,
                        iconSizeFactor: 0.5,
                        verse: 'About',
                        onTap: onCropImage,
                      ),

                      PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

                      /// KEYWORDS
                      PanelButton(
                        size: _panelButtonSize,
                        flyerZoneWidth: flyerZoneWidth,
                        icon: Iconz.FlyerScale,
                        iconSizeFactor: 0.5,
                        verse: 'Tags',
                        onTap: onCropImage,
                      ),

                      /// SPACER
                      _expander(),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
