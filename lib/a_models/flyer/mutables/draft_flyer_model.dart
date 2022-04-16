import 'dart:io';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class DraftFlyerModel{
  /// --------------------------------------------------------------------------
  DraftFlyerModel({
    @required this.assetsSources,
    @required this.assetsFiles,
    @required this.boxesFits,
    @required this.headlinesControllers,
    @required this.state,
  });
  /// --------------------------------------------------------------------------
  List<Asset> assetsSources;
  List<File> assetsFiles;
  List<BoxFit> boxesFits;
  List<TextEditingController> headlinesControllers;
  FlyerState state;
  /// --------------------------------------------------------------------------
  static DraftFlyerModel createEmptyDraft(){

    final DraftFlyerModel _draft = DraftFlyerModel(
      assetsSources: <Asset>[],
      assetsFiles: <File>[],
      boxesFits: <BoxFit>[],
      headlinesControllers: <TextEditingController>[],
      state: FlyerState.draft,
    );

    return _draft;
  }
// -----------------------------------------------------------------------------
}
