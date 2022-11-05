import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/b_slide_editor_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
/*
/// GIF THING
// check this
// https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
// https://pub.dev/packages/file_picker
// Container(
//   width: 200,
//   height: 200,
//   margin: EdgeInsets.all(30),
//   color: Colorz.BloodTest,
//   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
// ),
 */
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/*
// Future<DraftFlyerModel> initializeDraftFlyerModel({
//   @required FlyerModel existingFlyer,
//   @required BzModel bzModel,
// }) async {
//   DraftFlyerModel _draft;
//
//   if (existingFlyer == null){
//
//     _draft = DraftFlyerModel.createNewDraft(
//       bzModel: bzModel,
//       authorID: AuthFireOps.superUserID(),
//     );
//
//   }
//
//   else {
//
//     _draft = await DraftFlyerModel.createDraftFromFlyer(existingFlyer);
//
//   }
//
//   return _draft;
// }
 */
// -----------------------------------------------------------------------------

/// EDITING

// --------------------
/// TESTED : WORKS PERFECT
void onDeleteSlide({
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
  @required int index,
}){

  final List<MutableSlide> _slides = draftFlyer.value.mutableSlides;

  if (Mapper.checkCanLoopList(_slides) == true){

    _slides.removeAt(index);

    draftFlyer.value = draftFlyer.value.copyWith(
      mutableSlides: _slides,
    );

  }

}
// --------------------
///
Future<void> onAddNewSlides({
  @required BuildContext context,
  @required PicMakerType imagePickerType,
  @required ValueNotifier<bool> isLoading,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
  @required BzModel bzModel,
  @required bool mounted,
  @required ScrollController scrollController,
  @required double flyerWidth,
}) async {

  isLoading.value = true;


  final int _maxLength = Standards.getMaxSlidesCount(
    bzAccountType: bzModel.accountType,
  );

  /// A - if max images reached
  if(_maxLength <= draftFlyer.value.mutableSlides.length ){
    await _showMaxSlidesReachedDialog(context, _maxLength);
  }

  /// A - if can pick more images
  else {

    if (draftFlyer.value.firstTimer == true){
      await _addImagesForNewFlyer(
        context: context,
        mounted: mounted,
        bzModel: bzModel,
        scrollController: scrollController,
        draftFlyer: draftFlyer,
        flyerWidth: flyerWidth,
        imagePickerType: imagePickerType,
      );
    }

    else {
      await _addImagesForExistingFlyer(
        context: context,
        mounted: mounted,
        bzModel: bzModel,
        scrollController: scrollController,
        draftFlyer: draftFlyer,
        flyerWidth: flyerWidth,
      );
    }

  }

  isLoading.value = false;

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _addImagesForNewFlyer({
  @required BuildContext context,
  @required BzModel bzModel,
  @required bool mounted,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
  @required ScrollController scrollController,
  @required double flyerWidth,
  @required PicMakerType imagePickerType,
}) async {

  List<File> _pickedFiles = <File>[];

  if(mounted){

    if (imagePickerType == PicMakerType.galleryImage){

      final List<FileModel> _fileModels = await PicMaker.pickAndCropMultiplePics(
        context: context,
        // maxAssets: 10,
        aspectRatio: FlyerDim.flyerAspectRatio,
        cropAfterPick: false,
        resizeToWidth: Standards.slideWidthPixels,
      );

      if (Mapper.checkCanLoopList(_fileModels) == true){
        _pickedFiles = FileModel.getFilesFromModels(_fileModels);
      }

    }

    else if (imagePickerType == PicMakerType.cameraImage){

      final FileModel _fileModel = await PicMaker.shootAndCropCameraPic(
        context: context,
        // maxAssets: 10,
        aspectRatio: FlyerDim.flyerAspectRatio,
        cropAfterPick: false,
        resizeToWidth: Standards.slideWidthPixels,
      );

      if (_fileModel != null){
        _pickedFiles = <File>[_fileModel.bytes];
      }

    }


    /// B - if didn't pick more images
    if(_pickedFiles.isEmpty){
      // will do nothing
    }

    /// B - if made new picks
    else {

      blog('the thing is : $_pickedFiles');

      final List<MutableSlide> _newMutableSlides = await MutableSlide.createMutableSlidesByFiles(
        context: context,
        files: _pickedFiles,
        existingSlides: draftFlyer.value.mutableSlides,
        headline: draftFlyer.value.headline,
      );

      final List<MutableSlide> _combinedSlides = <MutableSlide>[...draftFlyer.value.mutableSlides, ... _newMutableSlides];

      final DraftFlyerModel _newDraft = draftFlyer.value.copyWith(
        mutableSlides: _combinedSlides,
      );

      draftFlyer.value = _newDraft;

      await Future.delayed(Ratioz.duration150ms,() async {
        await Scrollers.scrollTo(
          controller: scrollController,
          offset: scrollController?.position?.maxScrollExtent ?? 0 - flyerWidth,
        );
      });


      // for (int i = 0; i < _pickedFiles.length; i++){
      //   /// for first headline
      //   if(i == 0){
      //     /// keep controller as is
      //   }
      //   /// for the nest pages
      //   else {
      //   }
      // }

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _addImagesForExistingFlyer({
  @required BuildContext context,
  @required BzModel bzModel,
  @required bool mounted,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
  @required ScrollController scrollController,
  @required double flyerWidth,
}) async {

  if(mounted) {

    blog('fuck you : no slides editing after publish,,'
        ' only delete flyer and refund credit within 24 hours');

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _showMaxSlidesReachedDialog(BuildContext context, int maxLength) async {
  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      text: 'phid_max_slides_reached',
      translate: true,
    ),
    bodyVerse: Verse(
      pseudo: 'Can not add more than $maxLength images in one flyer',
      text: 'phid_max_slides_reached_description',
      translate: true,
      variables: maxLength,
    ),

  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSlideTap({
  @required BuildContext context,
  @required MutableSlide slide,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
}) async {

  Keyboard.closeKeyboard(context);

  final MutableSlide _result = await Nav.goToNewScreen(
      context: context,
      screen: SlideEditorScreen(
        slide: slide,
      )
  );

  if (_result != null){

    final List<MutableSlide> _updatedSlides = MutableSlide.replaceSlide(
      slides: draftFlyer.value.mutableSlides,
      slide: _result,
    );

    draftFlyer.value = draftFlyer.value.copyWith(
      mutableSlides: _updatedSlides,
    );

  }


  /*

    /// TASK : bokra isa

    final bool _noChangeOccured = MutableSlide.slidesAreTheSame(slide, _result);

    if (_noChangeOccured == true){
      // do nothing
    }
    else {
      _draftFlyer.value = _draftFlyer.value.replaceSlideWith(_result);
    }


     */

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onMoreTap({
  @required BuildContext context,
  @required Function onDeleteDraft,
  @required Function onSaveDraft,
  @required Function onPublishFlyer,
}) async {

  await BottomDialog.showButtonsBottomDialog(
    context: context,
    draggable: true,
    // buttonHeight: BottomDialog.wideButtonHeight,
    numberOfWidgets: 3,
    builder: (_){

      final List<Widget> _widgets = <Widget>[

        /// DELETE
        BottomDialog.wideButton(
          context: context,
          verse: const Verse(text: 'phid_delete', translate: true),
          verseCentered: true,
          onTap: () async {
            await Nav.goBack(
              context: context,
              invoker: 'onMoreTap.delete',
            );
            onDeleteDraft();
          },
        ),

        /// SAVE DRAFT
        BottomDialog.wideButton(
          context: context,
          verse: const Verse(text: 'phid_save_draft', translate: true,),
          verseCentered: true,
          onTap: () async {
            await Nav.goBack(
              context: context,
              invoker: 'onMoreTap.save',
            );
            onSaveDraft();
          },
        ),

        /// PUBLISH
        BottomDialog.wideButton(
          context: context,
          verse: const Verse(text: 'phid_publish', translate: true),
          verseCentered: true,
          onTap: () async {
            await Nav.goBack(
              context: context,
              invoker: 'onMoreTap.Publish',
            );
            onPublishFlyer();
          },
        ),

      ];


      return _widgets;

    },
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onFlyerHeadlineChanged({
  @required String text,
  @required GlobalKey<FormState> formKey,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
}){

  /// DO YOU NEED THIS ?
  formKey.currentState.validate();

  draftFlyer.value = DraftFlyerModel.updateHeadline(
      draft: draftFlyer.value,
      newHeadline: text
  );

}
// --------------------
/// TESTED : WORKS PERFECT
String flyerHeadlineValidator({
  @required BuildContext context,
  @required String val,
}){

  /// WHEN HEADLINE EXCEEDS MAX CHAR LENGTH
  if(val.length >= Standards.flyerHeadlineMaxLength){
    return '##Only ${Standards.flyerHeadlineMaxLength} characters allowed for the flyer title';
  }

  /// WHEN HEADLINE LENGTH IS OK
  else {
    return null;
  }

}
// -----------------------------------------------------------------------------
