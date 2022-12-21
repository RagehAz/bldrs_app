import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/j_poster/poster_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/f_bz/g_search_bzz_screen/search_bzz_screen.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_screen/keyboard_screen.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// POSTER

// --------------------
/// TESTED : WORKS PERFECT
void onSwitchPoster({
  @required bool value,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}){

  /// WAS OFF => NOW IS TRUE
  if (value == true){

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          poster: const PosterModel(
            modelID: null,
            path: null,
            type: null,
            // file: null,
          ),
        ),
    );

  }

  /// WAS TRUE => NOW IS OFF
  else {

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.nullifyField(
          poster: true,
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectPosterType({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required PosterType posterType,
  @required bool mounted,
}) async {

  /// NO ATTACHMENT
  if (posterType == null){
    _onClearPoster(
      noteNotifier: noteNotifier,
      mounted: mounted,
    );
  }

  /// BZ ID
  else if (posterType == PosterType.bz){
    await _onAddBzToPoster(
      context: context,
      noteNotifier: noteNotifier,
      mounted: mounted,
    );
  }

  /// FLYERS IDS
  else if (posterType == PosterType.flyer){
    await _onAddFlyerToPoster(
      context: context,
      noteNotifier: noteNotifier,
      mounted: mounted,
    );
  }

  /// GALLERY IMAGE
  else if (posterType == PosterType.galleryImage){
    await _onAddGalleryImageToPoster(
      context: context,
      noteNotifier: noteNotifier,
    );
  }

  /// CAMERA IMAGE
  else if (posterType == PosterType.cameraImage){
    await _onAddCameraImageToPoster(
      context: context,
      noteNotifier: noteNotifier,
    );
  }

  else if (posterType == PosterType.url){
    await _onAddImageURLToPoster(
      context: context,
      noteNotifier: noteNotifier,
      mounted: mounted,
    );
  }

  else {
    _onClearPoster(
      noteNotifier: noteNotifier,
      mounted: mounted,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onAddBzToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}) async {

  final List<BzModel> _bzModels = await Nav.goToNewScreen(
    context: context,
    screen: const SearchBzzScreen(),
  );

  if (Mapper.checkCanLoopList(_bzModels) == true){

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          poster: PosterModel(
            type: PosterType.bz,
            modelID: _bzModels.first.id,
            path: null,
          ),
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onAddFlyerToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}) async {

  final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
    context: context,
    screen: const SavedFlyersScreen(
      selectionMode: true,
    ),
  );

  if (Mapper.checkCanLoopList(_selectedFlyers) == true){

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          poster: PosterModel(
            type: PosterType.flyer,
            modelID: _selectedFlyers.first.id,
            path: null,
          ),
        ),
    );

  }

}
// --------------------
/// TASK : TEST ME
Future<void> _onAddGalleryImageToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {

  blog('should _onAddGalleryImageToPoster');

  // final Uint8List _bytes = await PicMaker.pickAndCropSinglePic(
  //   context: context,
  //   cropAfterPick: true,
  //   aspectRatio: NotePosterBox.getAspectRatio(),
  //   resizeToWidth: NotePosterBox.standardSize.width,
  // );
  //
  // if (_bytes != null){
  //   noteNotifier.value  = noteNotifier.value.copyWith(
  //     poster: PosterModel(
  //       type: PosterType.galleryImage,
  //       modelID: null,
  //       path: null,
  //       picModel: PicModel(
  //
  //       ),
  //     ),
  //
  //   );
  // }

}
// --------------------
/// TASK : TEST ME
Future<void> _onAddCameraImageToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {

  blog('should _onAddCameraImageToPoster');

  // final FileModel _fileModel = await PicMaker.shootAndCropCameraPic(
  //   context: context,
  //   cropAfterPick: true,
  //   aspectRatio: NotePosterBox.getAspectRatio(),
  //   resizeToWidth: NotePosterBox.standardSize.width,
  // );
  //
  // if (_fileModel != null){
  //   noteNotifier.value  = noteNotifier.value.copyWith(
  //     poster: PosterModel(
  //       type: PosterType.cameraImage,
  //       picModel: _fileModel._bytes,
  //       modelID: null,
  //       path: null,
  //     ),
  //
  //   );
  // }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onAddImageURLToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}) async {

  final String _url = await KeyboardScreen.goToKeyboardScreen(
    context: context,
    keyboardModel: KeyboardModel.standardModel().copyWith(
      validator: (String text) => Formers.webSiteValidator(
          context: context,
          website: text
      ),
    ),
  );

  if (_url != null){

    setNotifier(
        notifier: noteNotifier,
        mounted: mounted,
        value: noteNotifier.value.copyWith(
          poster: PosterModel(
            type: PosterType.url,
            modelID: null,
            path: _url,
            // file: null,
          ),
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void _onClearPoster({
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}){

  final NoteModel _note = noteNotifier.value.nullifyField(
    poster: true,
  );

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: _note,
  );

}
// -----------------------------------------------------------------------------
