import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/screens/x_3_slide_full_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
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

    AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(bzModel, superFlyer?.authorID);

    // BoxFit _currentPicFit = superFlyer?.currentPicFit;

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
            onTap: superFlyer.edit.onShowAuthorTap,
          ),

          PanelButton(
            flyerZoneWidth: flyerZoneWidth,
            icon:  Iconz.Camera,
            iconSizeFactor: 0.5,
            verse: 'shot',
            verseColor: Colorz.White255,
            onTap: () async {

              bool _editModeWas = superFlyer.edit.editMode;

              if(_editModeWas == true){
                await superFlyer.edit.onTriggerEditMode();
              }

              // https://flutteragency.com/take-a-screenshot-of-the-current-widget-in-flutter/

              Uint8List _screenshot;
              ImageSize _screenShotSize;

              if(superFlyer?.screenshotsControllers?.length != 0){

                // RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
                // var image = await boundary.toImage();
                // var byteData = await image.toByteData(format: ImageByteFormat.png);
                // var pngBytes = byteData.buffer.asUint8List();

                await superFlyer.screenshotsControllers[superFlyer.currentSlideIndex].
                capture(delay: Duration(milliseconds: 10))
                    .then((imageFile) async {
                      _screenshot = imageFile;
                      String _fileName = '${superFlyer.flyerID}_${superFlyer.currentSlideIndex}';
                      File _tempFile = await Imagers.createTempEmptyFile(_fileName);
                      File _file = await Imagers.writeUint8ListOnFile(file: _tempFile, uint8list: _screenshot);
                      _screenShotSize = await ImageSize.superImageSize(_file);
                    }).catchError((onError) {
                      print(onError);
                    });
              }

              double _screenWidth = Scale.superScreenWidth(context);
              double _screenHeight = Scale.superScreenHeight(context);
              double _dialogClearHeight = BottomDialog.dialogClearHeight(
                title: 'x',
                context: context,
                overridingDialogHeight: _screenHeight * 0.5,
              );

              await BottomDialog.slideBottomDialog(
                context: context,
                title: 'Screenshot',
                height: _screenHeight * 0.8,
                draggable: true,
                child: Container(
                  width: BottomDialog.dialogClearWidth(context),
                  height: _dialogClearHeight,
                  color: Colorz.Black255,
                  child: _screenshot == null ? Container()
                      :
                  GestureDetector(
                      onTap: () async {
                        await Nav.goToNewScreen(context,
                            SlideFullScreen(
                              image: _screenshot,
                              imageSize: _screenShotSize,
                            ));
                        },
                      child: Imagers.superImageWidget(
                        _screenshot,
                        height: _dialogClearHeight,
                        width: BottomDialog.dialogClearWidth(context),
                        fit: BoxFit.fitHeight,
                      )
                  ),
                ),
              );

              if(_editModeWas == true){
                await superFlyer.edit.onTriggerEditMode();
              }
              },
          ),

              /// SPACER
          _expander(),

          // PanelButton.panelDot(panelButtonWidth: _panelButtonSize),

          /// DELETE FLYER button
          if(superFlyer.edit.editMode == true && superFlyer.edit.firstTimer == false)
            PanelButton(
              flyerZoneWidth: flyerZoneWidth,
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
            flyerZoneWidth: flyerZoneWidth,
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
            flyerZoneWidth: flyerZoneWidth,
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
