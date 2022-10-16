import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/x_utilities/keyboard_model.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/f_bz/g_search_bzz_screen/search_bzz_screen.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_screen/keyboard_screen.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// POSTER

// --------------------
/// TESTED : WORKS PERFECT
void onSwitchPoster({
  @required bool value,
  @required ValueNotifier<NoteModel> noteNotifier,
}){

  /// WAS OFF => NOW IS TRUE
  if (value == true){

    noteNotifier.value = noteNotifier.value.copyWith(
      poster: const PosterModel(
        modelID: null,
        url: null,
        type: null,
        // file: null,
      ),
    );

  }

  /// WAS TRUE => NOW IS OFF
  else {
    noteNotifier.value = noteNotifier.value.nullifyField(
      poster: true,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectPosterType({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required PosterType posterType,
}) async {

  /// NO ATTACHMENT
  if (posterType == null){
    _onClearPoster(
      noteNotifier: noteNotifier,
    );
  }

  /// BZ ID
  else if (posterType == PosterType.bz){
    await _onAddBzToPoster(
      context: context,
      noteNotifier: noteNotifier,
    );
  }

  /// FLYERS IDS
  else if (posterType == PosterType.flyer){
    await _onAddFlyerToPoster(
      context: context,
      noteNotifier: noteNotifier,
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
    );
  }

  else {
    _onClearPoster(
      noteNotifier: noteNotifier,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onAddBzToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {

  final List<BzModel> _bzModels = await Nav.goToNewScreen(
    context: context,
    screen: const SearchBzzScreen(),
  );

  if (Mapper.checkCanLoopList(_bzModels) == true){

    noteNotifier.value = noteNotifier.value.copyWith(
      poster: PosterModel(
        type: PosterType.bz,
        modelID: _bzModels.first.id,
        url: null,
      ),

    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onAddFlyerToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {

  final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
    context: context,
    screen: const SavedFlyersScreen(
      selectionMode: true,
    ),
  );

  if (Mapper.checkCanLoopList(_selectedFlyers) == true){

    noteNotifier.value = noteNotifier.value.copyWith(
      poster: PosterModel(
        type: PosterType.flyer,
        modelID: _selectedFlyers.first.id,
        url: null,
      ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onAddGalleryImageToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {

  final FileModel _fileModel = await Imagers.pickAndCropSingleImage(
    context: context,
    cropAfterPick: true,
    aspectRatio: NotePosterBox.getAspectRatio(),
    resizeToWidth: NotePosterBox.standardSize.width,
  );

  if (_fileModel != null){
    noteNotifier.value = noteNotifier.value.copyWith(
      poster: PosterModel(
        type: PosterType.galleryImage,
        file: _fileModel.file,
        modelID: null,
        url: null,
      ),

    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onAddCameraImageToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {

  final FileModel _fileModel = await Imagers.shootAndCropCameraImage(
    context: context,
    cropAfterPick: true,
    aspectRatio: NotePosterBox.getAspectRatio(),
    resizeToWidth: NotePosterBox.standardSize.width,
  );

  if (_fileModel != null){
    noteNotifier.value = noteNotifier.value.copyWith(
      poster: PosterModel(
        type: PosterType.cameraImage,
        file: _fileModel.file,
        modelID: null,
        url: null,
      ),

    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onAddImageURLToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
}) async {

  final String _url = await KeyboardScreen.goToKeyboardScreen(
    context: context,
    keyboardModel: KeyboardModel.standardModel().copyWith(
      validator: (String text) => Formers.webSiteValidator(
          website: text
      ),
    ),
  );

  if (_url != null){
    noteNotifier.value = noteNotifier.value.copyWith(
      poster: PosterModel(
        type: PosterType.url,
        modelID: null,
        url: _url,
        // file: null,
      ),

    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
void _onClearPoster({
  @required ValueNotifier<NoteModel> noteNotifier,
}){

  final NoteModel _note = noteNotifier.value.nullifyField(
    poster: true,
  );

  noteNotifier.value = _note;

}
// -----------------------------------------------------------------------------
