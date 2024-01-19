import 'dart:async';

import 'package:basics/helpers/animators/sliders.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/b_slide_editor_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// EDITING

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

  setNotifier(notifier: isLoading, mounted: mounted, value: true);

  final int _maxLength = Standards.getMaxSlidesCount(
    bzAccountType: draftFlyer.value?.bzModel?.accountType,
  );

  /// A - if max images reached
  if(_maxLength <= (draftFlyer.value?.draftSlides?.length ?? 0)){
    await _showMaxSlidesReachedDialog(context, _maxLength);
  }

  /// A - if can pick more images
  else {

    // if (draftFlyer.value.firstTimer == true){
      await _addImagesForNewFlyer(
        mounted: mounted,
        scrollController: scrollController,
        draftFlyer: draftFlyer,
        flyerBoxWidth: flyerBoxWidth,
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
  required bool mounted,
  required ValueNotifier<DraftFlyer?> draftFlyer,
  required ScrollController scrollController,
  required double flyerBoxWidth,
  required PicMakerType imagePickerType,
}) async {

  if(mounted == true && draftFlyer.value?.id != null && draftFlyer.value?.bzID != null){

    final List<String> _ownersIDs = await FlyerModel.generateFlyerOwners(
      bzID: draftFlyer.value?.bzID,
    );

    final int _maxLength = Standards.getMaxSlidesCount(
      bzAccountType: draftFlyer.value?.bzModel?.accountType,
    );

    final List<PicModel> _bigPics = await BldrsPicMaker.makePics(
      cropAfterPick: false,
      aspectRatio: FlyerDim.flyerAspectRatio(),
      compressWithQuality: Standards.slideBigQuality,
      resizeToWidth: Standards.slideBigWidth,
      assignPath: (int index) => StoragePath.flyers_flyerID_index_big(
        flyerID: draftFlyer.value!.id,
        slideIndex: index,
      )!,
      ownersIDs: _ownersIDs,
      picNameGenerator: (int index){
        return SlideModel.generateSlideID(
            flyerID: draftFlyer.value!.id,
            slideIndex: index,
            type: SlidePicType.big,
        )!;
      },
      maxAssets: _maxLength - (draftFlyer.value?.draftSlides?.length ?? 0),
    );

    /// B - if didn't pick more images
    if(_bigPics.isEmpty){
      // will do nothing
    }

    /// B - if made new picks
    else {

      final List<DraftSlide> _newDraftSlides = await DraftSlide.createDrafts(
        bigPics: _bigPics,
        existingDrafts: draftFlyer.value?.draftSlides ?? [],
        headline: draftFlyer.value?.headline?.text,
        bzID: draftFlyer.value?.bzID,
        flyerID: draftFlyer.value?.id,
        flyerBoxWidth: flyerBoxWidth,
      );

      final List<DraftSlide> _combinedSlides = <DraftSlide>[
        ...?draftFlyer.value?.draftSlides,
        ..._newDraftSlides
      ];

      DraftFlyer? _newDraft = draftFlyer.value?.copyWith(
        draftSlides: _combinedSlides,
      );

      _newDraft = DraftFlyer.updateHeadline(
        draft: _newDraft,
        updateController: false,
        slideIndex: 0,
        newHeadline: draftFlyer.value?.headline?.text,
      );

      setNotifier(
          notifier: draftFlyer,
          mounted: mounted,
          value: _newDraft,
      );

      /// AUTO OPEN FIRST SLIDE
      if (_newDraft?.draftSlides?.length == 1){
        await  onSlideTap(
          slide: _newDraft!.draftSlides!.first,
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

  }

}
// --------------------
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
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _showMaxSlidesReachedDialog(BuildContext context, int maxLength) async {
  await BldrsCenterDialog.showCenterDialog(
    titleVerse: Verse(
      id: '${getWord('phid_max_slides_is')} $maxLength',
      translate: false,
    ),
  );
}
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
      screen: SlideEditorScreen(
        slide: slide,
        draftFlyerNotifier: draftFlyer,
      ),
  );

}
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
// --------------------
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
