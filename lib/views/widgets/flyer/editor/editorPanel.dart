import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/panel_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/controllers/theme/colorz.dart';

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
});

  @override
  Widget build(BuildContext context) {

    // print('draft picture screen');

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    double _panelWidth = panelWidth;
    double _buttonSize = panelWidth;//_panelWidth - (Ratioz.appBarMargin * 2);

    double _flyerZoneWidth = _screenWidth - _panelWidth - Ratioz.appBarMargin;
    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerZoneWidth);
    double _flyerSizeFactor = Scale.superFlyerSizeFactorByWidth(context, _flyerZoneWidth);

    double _panelButtonSize = _buttonSize * 0.8;

    double _panelHeight = _flyerZoneHeight;

    AuthorModel _author = author;

    BoxFit _currentPicFit = boxFit;

    // ImageSize _originalAssetSize = _assets.length == 0 || _assets == null ? null : ImageSize(
    //   width: _assets[_draft.currentSlideIndex].originalWidth,
    //   height: _assets[_draft.currentSlideIndex].originalHeight,
    // );

// ------------------------------


    return Container(
      width: _panelWidth,
      height: _panelHeight,
      alignment: Alignment.center,
      // color: Colorz.Green255,
      child: Column(
        // shrinkWrap: true,

        children: <Widget>[

          /// SHOW AUTHOR
          DreamBox(
            height: Ratioz.xxflyerLogoWidth * _flyerZoneWidth,
            margins: EdgeInsets.symmetric(vertical: (Ratioz.xxflyerHeaderMiniHeight - Ratioz.xxflyerLogoWidth) * _flyerZoneWidth / 2),
            width: _buttonSize,
            color: showAuthor == true ? Colorz.White80 : Colorz.White80,
            icon: _author.authorPic,
            underLine: showAuthor == true ? 'Author Shown' : 'Author Hidden',
            underLineShadowIsOn: false,
            underLineColor: showAuthor == true ? Colorz.White255 : Colorz.White80,
            corners: Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * _flyerZoneWidth),
            blackAndWhite: showAuthor == true ? false : true,
            bubble: showAuthor == true ? true : false,
            onTap: onAuthorTap,
          ),

          /// SPACER
          Expanded(
            child: Container(),
          ),

          /// ADD IMAGE
          PanelButton(
            size: _panelButtonSize,
            flyerZoneWidth: _flyerZoneWidth,
            icon:  Iconz.Plus,
            iconSizeFactor: 0.5,
            verse: 'Add',
            onTap: onAddImage,
          ),

          /// DELETE IMAGE
          PanelButton(
            size: _panelButtonSize,
            flyerZoneWidth: _flyerZoneWidth,
            icon:  Iconz.XSmall,
            iconSizeFactor: 0.5,
            verse: 'Delete',
            onTap: onDeleteImage,
          ),

          PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

          /// CROP IMAGE
          PanelButton(
            size: _panelButtonSize,
            flyerZoneWidth: _flyerZoneWidth,
            icon:  Iconz.BxDesignsOff,
            iconSizeFactor: 0.5,
            verse: 'Crop',
            onTap: onCropImage,
          ),

          /// RELOAD
          PanelButton(
            size: _panelButtonSize,
            flyerZoneWidth: _flyerZoneWidth,
            icon:  Iconz.Clock,
            iconSizeFactor: 0.5,
            verse: 'Reset',
            onTap: onResetImage,
          ),

          PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

          /// CHANGE SLIDE BOX FIT
          PanelButton(
            size: _panelButtonSize,
            flyerZoneWidth: _flyerZoneWidth,
            verse: 'Fit',
            icon: _currentPicFit == BoxFit.fitWidth ? Iconz.ArrowRight : _currentPicFit == BoxFit.fitHeight ? Iconz.ArrowUp : Iconz.DashBoard,
            iconSizeFactor: 0.35,
            isAuthorButton: false,
            onTap: onFitImage,
          ),

          /// BOTTOM SPACING
          SizedBox(
            //Ratioz.xxflyerBottomCorners * _flyerZoneWidth - Ratioz.appBarPadding,
            height: Scale.superFlyerFooterHeight(_flyerZoneWidth),
          ),

        ],
      ),
    );
  }
}
