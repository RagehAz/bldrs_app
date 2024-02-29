import 'dart:async';

import 'package:basics/helpers/animators/sliders.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/pic_slide_editor_screen.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// ADDING SLIDES

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddNewSlides({
  required BuildContext context,
  required PicMakerType imagePickerType,
  required ValueNotifier<bool> isLoading,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required bool mounted,
  required ScrollController scrollController,
  required double flyerBoxWidth,
}) async {

  setNotifier(
    notifier: isLoading,
    mounted: mounted,
    value: true,
  );

  final bool _maxSlidesCountReached = DraftFlyer.checkMaxSlidesCountReached(
      draftFlyer: draftFlyer.value,
  );

  /// MAX SLIDES REACHED
  if(_maxSlidesCountReached == true){
    await _showMaxSlidesReachedDialog(draftFlyer.value);
  }

  /// GALLERY PHOTO
  else if (imagePickerType == PicMakerType.galleryImage){
    await _addGalleryImagesToNewFlyer(
      mounted: mounted,
      scrollController: scrollController,
      draftFlyer: draftFlyer,
      flyerBoxWidth: flyerBoxWidth,
    );
  }

  /// CAMERA PHOTO
  else if (imagePickerType == PicMakerType.cameraImage){
    await _addCameraImageToNewFlyer(
      mounted: mounted,
      scrollController: scrollController,
      draftFlyer: draftFlyer,
      flyerBoxWidth: flyerBoxWidth,
    );
  }

  /// GALLERY VIDEO
  else if (imagePickerType == PicMakerType.galleryVideo){
    await _addGalleryVideoToNewFlyer(
      mounted: mounted,
      scrollController: scrollController,
      draftFlyer: draftFlyer,
      flyerBoxWidth: flyerBoxWidth,
    );
  }

  /// CAMERA VIDEO
  else if (imagePickerType == PicMakerType.cameraVideo){
      await _addCameraVideoToNewFlyer(
        mounted: mounted,
        scrollController: scrollController,
        draftFlyer: draftFlyer,
        flyerBoxWidth: flyerBoxWidth,
      );
    }

  setNotifier(
      notifier: isLoading,
      mounted: mounted,
      value: false,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _addGalleryImagesToNewFlyer({
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required ScrollController scrollController,
  required double flyerBoxWidth,
}) async {

  if(mounted == true && draftFlyer.value?.id != null && draftFlyer.value?.bzID != null){

    final List<PicModel> _bigPics = await BldrsPicMaker.makePics(
      cropAfterPick: false,
      aspectRatio: FlyerDim.flyerAspectRatio(),
      compressWithQuality: Standards.slideBigQuality,
      resizeToWidth: Standards.slideBigWidth,
      assignPath: (int index) => StoragePath.flyers_flyerID_index_big(
        flyerID: draftFlyer.value!.id,
        slideIndex: index,
      )!,
      ownersIDs: await FlyerModel.generateFlyerOwners(
        bzID: draftFlyer.value?.bzID,
      ),
      picNameGenerator: (int index){
        return SlideModel.generateSlideID(
            flyerID: draftFlyer.value!.id,
            slideIndex: index,
            type: SlidePicType.big,
        )!;
      },
      maxAssets: DraftFlyer.concludeMaxAssetsPossibleWhilePickingPhotos(
        draft: draftFlyer.value,
      ),
    );

    /// B - if didn't pick more images
    if(_bigPics.isEmpty){
      // will do nothing
    }

    /// B - if made new picks
    else {

      blog('_addGalleryImagesToNewFlyer ${draftFlyer.value?.draftSlides?.length} draftSlides');

      final DraftFlyer? _newDraft = await DraftFlyer.addBigPicsToDraft(
        draft: draftFlyer.value,
        flyerBoxWidth: flyerBoxWidth,
        bigPics: _bigPics,
      );

      setNotifier(
          notifier: draftFlyer,
          mounted: mounted,
          value: _newDraft,
      );

      await _openFirstSlideOrScrollToEndOfShelf(
        mounted: mounted,
        draftFlyer: draftFlyer,
        flyerBoxWidth: flyerBoxWidth,
        scrollController: scrollController,
        openEditorToLastSlide: _bigPics.length == 1,
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _addCameraImageToNewFlyer({
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required ScrollController scrollController,
  required double flyerBoxWidth,
}) async {

  if(mounted == true && draftFlyer.value?.id != null && draftFlyer.value?.bzID != null){

    final PicModel? _bigPic = await BldrsPicMaker.makePic(
      cropAfterPick: false,
      aspectRatio: FlyerDim.flyerAspectRatio(),
      compressWithQuality: Standards.slideBigQuality,
      resizeToWidth: Standards.slideBigWidth,
      assignPath: StoragePath.flyers_flyerID_index_big(
        flyerID: draftFlyer.value!.id,
        slideIndex: 0,
      )!,
      name: SlideModel.generateSlideID(
        flyerID: draftFlyer.value!.id,
        slideIndex: 0,
        type: SlidePicType.big,
      )!,
      picMakerType: PicMakerType.cameraImage,
      ownersIDs: await FlyerModel.generateFlyerOwners(
        bzID: draftFlyer.value?.bzID,
      ),
    );

    /// B - if didn't pick more images
    if(_bigPic == null){
      // will do nothing
    }

    /// B - if made new picks
    else {

      final DraftFlyer? _newDraft = await DraftFlyer.addBigPicsToDraft(
        draft: draftFlyer.value,
        flyerBoxWidth: flyerBoxWidth,
        bigPics: [_bigPic],
      );

      setNotifier(
        notifier: draftFlyer,
        mounted: mounted,
        value: _newDraft,
      );

      await _openFirstSlideOrScrollToEndOfShelf(
        mounted: mounted,
        draftFlyer: draftFlyer,
        flyerBoxWidth: flyerBoxWidth,
        scrollController: scrollController,
        openEditorToLastSlide: true,
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _addGalleryVideoToNewFlyer({
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required ScrollController scrollController,
  required double flyerBoxWidth,
}) async {

  blog('should implement : _addGalleryVideoToNewFlyer');

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _addCameraVideoToNewFlyer({
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required ScrollController scrollController,
  required double flyerBoxWidth,
}) async {

  blog('should implement : _addCameraVideoToNewFlyer');

}
// --------------------
/*
/// TESTED : WORKS PERFECT
Future<void> addImagesForExistingFlyer({
  required BuildContext context,
  required BzModel bzModel,
  required bool mounted,
  required ValueNotifier<DraftFlyer> draftFlyer,
  required ScrollController scrollController,
  required double flyerWidth,
}) async {

  if(mounted) {

    blog('fuck you : no slides editing after publish,,'
        ' only delete flyer and refund credit within 24 hours');

  }

}
 */
// -----------------------------------------------------------------------------

/// DIALOGS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _showMaxSlidesReachedDialog(DraftFlyer? draftFlyer) async {

  final int _maxLength = Standards.getMaxSlidesCount(
    bzAccountType: draftFlyer?.bzModel?.accountType,
  );

  await BldrsCenterDialog.showCenterDialog(
    titleVerse: Verse(
      id: '${getWord('phid_max_slides_is')} $_maxLength',
      translate: false,
    ),
  );

}
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSlideTap({
  required DraftSlide slide,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required bool mounted,
}) async {

  await Keyboard.closeKeyboard();

  await BldrsNav.goToNewScreen(
      pageTransitionType: Nav.superHorizontalTransition(),
      screen: PicSlideEditorScreen(
        slide: slide,
        draftFlyerNotifier: draftFlyer,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _openFirstSlideOrScrollToEndOfShelf({
  required ScrollController scrollController,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required bool mounted,
  required double flyerBoxWidth,
  required bool openEditorToLastSlide,
}) async {

  /// AUTO OPEN FIRST SLIDE
  if (draftFlyer.value?.draftSlides?.length == 1){
    await  onSlideTap(
      slide: draftFlyer.value!.draftSlides!.first,
      draftFlyer: draftFlyer,
      mounted: mounted,
    );
  }

  /// AUTO OPEN LAST SLIDE
  else if (openEditorToLastSlide == true){
    await  onSlideTap(
      slide: draftFlyer.value!.draftSlides!.last,
      draftFlyer: draftFlyer,
      mounted: mounted,
    );
  }
  /// AUTO SCROLL TO END OF SLIDES SHELF
  if (mounted == true){
    await Future.delayed(Ratioz.duration150ms,() async {
      if (mounted == true){
        await Sliders.scrollTo(
          controller: scrollController,
          offset: (scrollController.position.maxScrollExtent) - flyerBoxWidth,
        );
      }
    });
  }

}
// -----------------------------------------------------------------------------

/// DELETE SLIDE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDeleteSlide({
  required DraftSlide draftSlide,
  required ValueNotifier<DraftFlyer?>? draftFlyer,
  required bool mounted,
}) async {

  await Keyboard.closeKeyboard();

  final SlideModel? _slide = await DraftSlide.draftToSlide(
    draft: draftSlide,
    slidePicType: SlidePicType.small,
  );

  final bool _continue = await Dialogs.slideDialog(
      slideModel: _slide,
      titleVerse: const Verse(
        id: 'phid_delete_slide_?',
        translate: true,
      ),
  );

  if (_continue == true){

    blog('should delete not');

    final List<DraftSlide> _slides = DraftSlide.removeDraftFromDrafts(
      drafts: draftFlyer?.value!.draftSlides,
      draft: draftSlide,
    );

    setNotifier(
        notifier: draftFlyer,
        mounted: mounted,
        value: draftFlyer?.value?.copyWith(
          draftSlides: _slides,
        ),
    );

    _slide?.frontImage?.dispose();
    _slide?.backImage?.dispose();

  }

}
// -----------------------------------------------------------------------------

/// HEADLINE

// --------------------
/// TESTED : WORKS PERFECT
void onFlyerHeadlineChanged({
  required String text,
  required GlobalKey<FormState> formKey,
  required ValueNotifier<DraftFlyer> draftFlyer,
  required bool mounted,
  required bool updateController,
}){

  /// DO YOU NEED THIS ?
  Formers.validateForm(formKey);

  setNotifier(
      notifier: draftFlyer,
      mounted: mounted,
      value: DraftFlyer.updateHeadline(
        draft: draftFlyer.value,
        newHeadline: text,
        slideIndex: 0,
        updateController: updateController,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
String? flyerHeadlineValidator({
  required String? val,
}){

  /// WHEN HEADLINE EXCEEDS MAX CHAR LENGTH
  if(val != null && val.length >= Standards.flyerHeadlineMaxLength){
    final String _error = '${getWord('phid_headline_cant_be_more_than')}\n'
                          '${Standards.flyerHeadlineMaxLength}';

    return _error;
  }

  /// WHEN HEADLINE LENGTH IS OK
  else {
    return null;
  }

}
// -----------------------------------------------------------------------------

/// REORDER

// --------------------
/// TESTED : WORKS PERFECT
void onReorderSlide({
  required int oldIndex,
  required int newIndex,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required bool mounted,
}){
  List<DraftSlide>? _oldSlides = draftFlyer.value?.draftSlides;

  if (Lister.checkCanLoop(_oldSlides) == true) {

    final DraftSlide _slide = _oldSlides![oldIndex];
    _oldSlides.removeAt(oldIndex);
    _oldSlides.insert(newIndex, _slide.copyWith(slideIndex: newIndex,));
    _oldSlides = DraftSlide.overrideDraftsSlideIndexes(
      drafts: _oldSlides,
    );

    draftFlyer.value!.headline!.text = _oldSlides[0].headline ?? '';

  }
  setNotifier(
    notifier: draftFlyer,
    mounted: mounted,
    value: draftFlyer.value?.copyWith(
      draftSlides: _oldSlides,
    ),
  );

}
// -----------------------------------------------------------------------------

/// DEPRECATED DIALOG

// --------------------
/*
/// TESTED : WORKS PERFECT
Future<void> onMoreTap({
  required BuildContext context,
  required Function onDeleteDraft,
  required Function onSaveDraft,
  required Function onPublishFlyer,
}) async {

  await BottomDialog.showButtonsBottomDialog(
    // buttonHeight: BottomDialog.wideButtonHeight,
    numberOfWidgets: 3,
    builder: (_, __){

      final List<Widget> _widgets = <Widget>[

        /// DELETE
        BottomDialog.wideButton(
          verse: const Verse(id: 'phid_delete', translate: true),
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
          verse: const Verse(id: 'phid_save_draft', translate: true,),
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
          verse: const Verse(id: 'phid_publish', translate: true),
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
 */
// -----------------------------------------------------------------------------
