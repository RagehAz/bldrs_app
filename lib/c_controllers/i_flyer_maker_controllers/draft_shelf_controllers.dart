import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/flyer_maker_screen.dart/slide_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
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
Future<DraftFlyerModel> initializeDraftFlyerModel({
  @required FlyerModel existingFlyer,
  @required BzModel bzModel,
}) async {
  DraftFlyerModel _draft;

  if (existingFlyer == null){

    _draft = DraftFlyerModel.createNewDraft(
      bzModel: bzModel,
      authorID: AuthFireOps.superUserID(),
    );

  }

  else {

    _draft = await DraftFlyerModel.createDraftFromFlyer(existingFlyer);

  }

  return _draft;
}

TextEditingController initializeHeadlineController({
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
}){

  final TextEditingController _controller = TextEditingController();

  _controller.addListener(() {

    blog('text controller : ${_controller.text}');

    if (Mapper.checkCanLoopList(draftFlyer.value.mutableSlides) == true){

      draftFlyer.value = DraftFlyerModel.updateHeadline(
        controller : _controller,
        draft: draftFlyer.value,
      );

    blog('headline is : ${draftFlyer?.value?.mutableSlides?.first?.headline?.text}');

    }


  });

  return _controller;
}
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
Future<void> onAddNewSlides({
  @required BuildContext context,
  @required ValueNotifier<bool> isLoading,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
  @required BzModel bzModel,
  @required bool mounted,
  @required ScrollController scrollController,
  @required TextEditingController headlineController,
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

    if(mounted){

      /// GET ONLY ASSETS AND IGNORE FILES
      final List<Asset> _existingAssets = MutableSlide.getAssetsFromMutableSlides(
        mutableSlides: draftFlyer.value.mutableSlides,
      );

      final List<Asset> _pickedAssets = await Imagers.takeGalleryMultiPictures(
        context: context,
        images: _existingAssets,
        mounted: mounted,
        accountType: bzModel.accountType,
      );

      /// B - if didn't pick more images
      if(_pickedAssets.isEmpty){
        // will do nothing
      }

      /// B - if made new picks
      else {

        blog('the thing is : $_pickedAssets');

        final List<MutableSlide> _newMutableSlides = await MutableSlide.createMutableSlidesByAssets(
          assets: _pickedAssets,
          existingSlides: draftFlyer.value.mutableSlides,
          headlineController: headlineController,
        );

        final List<MutableSlide> _combinedSlides = <MutableSlide>[... _newMutableSlides];

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


        // for (int i = 0; i < _pickedAssets.length; i++){
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

  isLoading.value = false;

}
// -----------------------------------------------------------------------------
Future<void> _showMaxSlidesReachedDialog(BuildContext context, int maxLength) async {
  await CenterDialog.showCenterDialog(
    context: context,
    title: 'Max. Images reached',
    body: 'Can not add more than $maxLength images in one slide',
  );
}
// -----------------------------------------------------------------------------

Future<void> onSlideTap({
  @required BuildContext context,
  @required MutableSlide slide,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
}) async {

  Keyboarders.minimizeKeyboardOnTapOutSide(context);

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
// -----------------------------------------------------------------------------
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
    builder: (BuildContext ctx, PhraseProvider phraseProvider){

      final List<Widget> _widgets = <Widget>[

        /// DELETE
        BottomDialog.wideButton(
          context: context,
          verse: superPhrase(context, 'phid_delete'),
          verseCentered: true,
          onTap: (){
            Nav.goBack(context);
            onDeleteDraft();
          },
        ),

        /// SAVE DRAFT
        BottomDialog.wideButton(
          context: context,
          verse: 'Save Draft',
          verseCentered: true,
          onTap: (){
            Nav.goBack(context);
            onSaveDraft();
          },
        ),

        /// PUBLISH
        BottomDialog.wideButton(
          context: context,
          verse: 'Publish',
          verseCentered: true,
          onTap: (){
            Nav.goBack(context);
            onPublishFlyer();
          },
        ),

      ];


      return _widgets;

    },
  );

}
// -----------------------------------------------------------------------------
void onFlyerHeadlineChanged({
  @required String val,
  @required GlobalKey<FormState> formKey,
  @required TextEditingController controller,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
}){
  formKey.currentState.validate();

  if (Mapper.checkCanLoopList(draftFlyer.value.mutableSlides) == true){
    draftFlyer.value = DraftFlyerModel.updateHeadline(
      draft: draftFlyer.value,
      controller: controller,
    );
  }

}
// -----------------------------------------------------------------------------
String flyerHeadlineValidator({
  @required BuildContext context,
  @required String val,
}){

  /// WHEN HEADLINE EXCEEDS MAX CHAR LENGTH
  if(val.length >= Standards.flyerHeadlineMaxLength){
    return 'Only ${Standards.flyerHeadlineMaxLength} characters allowed for the flyer title';
  }

  /// WHEN HEADLINE LENGTH IS OK
  else {
    return null;
  }

}
// -----------------------------------------------------------------------------
