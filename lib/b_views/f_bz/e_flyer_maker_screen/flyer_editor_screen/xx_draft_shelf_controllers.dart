import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/b_slide_editor_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// EDITING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddNewSlides({
  @required BuildContext context,
  @required PicMakerType imagePickerType,
  @required ValueNotifier<bool> isLoading,
  @required ValueNotifier<DraftFlyer> draftFlyer,
  @required BzModel bzModel,
  @required bool mounted,
  @required ScrollController scrollController,
  @required double flyerWidth,
}) async {

  setNotifier(notifier: isLoading, mounted: mounted, value: true);

  final int _maxLength = Standards.getMaxSlidesCount(
    bzAccountType: bzModel.accountType,
  );

  /// A - if max images reached
  if(_maxLength <= draftFlyer.value.draftSlides.length ){
    await _showMaxSlidesReachedDialog(context, _maxLength);
  }

  /// A - if can pick more images
  else {

    // if (draftFlyer.value.firstTimer == true){
      await _addImagesForNewFlyer(
        context: context,
        mounted: mounted,
        bzModel: bzModel,
        scrollController: scrollController,
        draftFlyer: draftFlyer,
        flyerWidth: flyerWidth,
        imagePickerType: imagePickerType,
      );
    // }

    // else {
    //   await addImagesForExistingFlyer(
    //     context: context,
    //     mounted: mounted,
    //     bzModel: bzModel,
    //     scrollController: scrollController,
    //     draftFlyer: draftFlyer,
    //     flyerWidth: flyerWidth,
    //   );
    // }

  }

  setNotifier(
      notifier: isLoading,
      mounted: mounted,
      value: false,
  );


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _addImagesForNewFlyer({
  @required BuildContext context,
  @required BzModel bzModel,
  @required bool mounted,
  @required ValueNotifier<DraftFlyer> draftFlyer,
  @required ScrollController scrollController,
  @required double flyerWidth,
  @required PicMakerType imagePickerType,
}) async {

  List<Uint8List> _picked = <Uint8List>[];

  if(mounted){

    if (imagePickerType == PicMakerType.galleryImage){

      final List<Uint8List> _bytezz = await PicMaker.pickAndCropMultiplePics(
        context: context,
        // maxAssets: 10,
        aspectRatio: FlyerDim.flyerAspectRatio,
        cropAfterPick: false,
        resizeToWidth: Standards.slideWidthPixels,
      );

      if (Mapper.checkCanLoopList(_bytezz) == true){
        _picked = _bytezz;
      }

    }

    else if (imagePickerType == PicMakerType.cameraImage){

      final Uint8List _bytes = await PicMaker.shootAndCropCameraPic(
        context: context,
        // maxAssets: 10,
        aspectRatio: FlyerDim.flyerAspectRatio,
        cropAfterPick: false,
        resizeToWidth: Standards.slideWidthPixels,
      );

      if (_bytes != null){
        _picked = <Uint8List>[_bytes];
      }

    }


    /// B - if didn't pick more images
    if(_picked.isEmpty){
      // will do nothing
    }

    /// B - if made new picks
    else {

      blog('the thing is : ${_picked.length} bytes');

      final List<DraftSlide> _newMutableSlides = await DraftSlide.createDrafts(
        context: context,
        bytezz: _picked,
        existingDrafts: draftFlyer.value.draftSlides,
        headline: draftFlyer.value.headline.text,
        bzID: draftFlyer.value.bzID,
        flyerID: draftFlyer.value.id,
      );

      final List<DraftSlide> _combinedSlides = <DraftSlide>[...draftFlyer.value.draftSlides, ... _newMutableSlides];

      final DraftFlyer _newDraft = draftFlyer.value.copyWith(
        draftSlides: _combinedSlides,
      );

      setNotifier(
          notifier: draftFlyer,
          mounted: mounted,
          value: _newDraft,
      );

      await Future.delayed(Ratioz.duration150ms,() async {
        await Scrollers.scrollTo(
          controller: scrollController,
          offset: scrollController?.position?.maxScrollExtent ?? 0 - flyerWidth,
        );
      });


      // for (int i = 0; i < _picked.length; i++){
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
Future<void> addImagesForExistingFlyer({
  @required BuildContext context,
  @required BzModel bzModel,
  @required bool mounted,
  @required ValueNotifier<DraftFlyer> draftFlyer,
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
  @required DraftSlide slide,
  @required ValueNotifier<DraftFlyer> draftFlyer,
  @required bool mounted,
}) async {

  Keyboard.closeKeyboard(context);

  final DraftSlide _result = await Nav.goToNewScreen(
      context: context,
      screen: SlideEditorScreen(
        slide: slide,
        draftFlyer: draftFlyer,
      )
  );

  if (_result != null){

    final List<DraftSlide> _updatedSlides = DraftSlide.replaceSlide(
      drafts: draftFlyer.value.draftSlides,
      draft: _result,
    );

    setNotifier(
        notifier: draftFlyer,
        mounted: mounted,
        value: draftFlyer.value.copyWith(
          draftSlides: _updatedSlides,
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDeleteSlide({
  @required BuildContext context,
  @required DraftSlide draftSlide,
  @required ValueNotifier<DraftFlyer> draftFlyer,
  @required bool mounted,
}) async {

  Keyboard.closeKeyboard(context);

  final SlideModel _slide = await DraftSlide.draftToSlide(draftSlide);

  final bool _continue = await Dialogs.slideDialog(
      context: context,
      slideModel: _slide,
      titleVerse: const Verse(
        text: 'phid_delete_slide_?',
        translate: true,
      ),
  );

  if (_continue == true){

    blog('should delete not');

    final List<DraftSlide> _slides = DraftSlide.removeDraftFromDrafts(
      drafts: draftFlyer.value.draftSlides,
      draft: draftSlide,
    );

    setNotifier(
        notifier: draftFlyer,
        mounted: mounted,
        value: draftFlyer.value.copyWith(
          draftSlides: _slides,
        ),
    );

    _slide.uiImage.dispose();

  }

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
  @required ValueNotifier<DraftFlyer> draftFlyer,
  @required bool mounted,
}){

  /// DO YOU NEED THIS ?
  formKey.currentState.validate();

  setNotifier(
      notifier: draftFlyer,
      mounted: mounted,
      value: DraftFlyer.updateHeadline(
        draft: draftFlyer.value,
        newHeadline: text,
        slideIndex: 0,
      ),
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
    final String _error = '${Verse.transBake(context, 'phid_headline_cant_be_more_than')}\n'
                          '${Standards.flyerHeadlineMaxLength}';

    return _error;
  }

  /// WHEN HEADLINE LENGTH IS OK
  else {
    return null;
  }

}
// -----------------------------------------------------------------------------
