import 'package:flutter/material.dart';

class FlyerEditor {
  /// editor functions
  final Function onAddImages; // FlyerEditor
  final Function onDeleteSlide; // FlyerEditor
  final Function onCropImage; // FlyerEditor
  final Function onResetImage; // FlyerEditor
  final Function onFitImage; // FlyerEditor
  final Function onFlyerTypeTap; // FlyerEditor
  final Function onZoneTap; // FlyerEditor
  final Function onEditInfoTap; // FlyerEditor
  final Function onEditKeywordsTap; // FlyerEditor
  final Function onEditSpecsTap;
  final Function onShowAuthorTap; // FlyerEditor
  final Function onTriggerEditMode; // FlyerEditor
  final Function onPublishFlyer; // FlyerEditor
  final Function onDeleteFlyer; // FlyerEditor
  final Function onUnPublishFlyer; // FlyerEditor
  final Function onRepublishFlyer; // FlyerEditor
  /// editor data
  bool firstTimer; // FlyerEditor
  bool editMode; // FlyerEditor
  bool canDelete;

  FlyerEditor({
    /// editor functions
    @required this.onAddImages,
    @required this.onDeleteSlide,
    @required this.onCropImage,
    @required this.onResetImage,
    @required this.onFitImage,
    @required this.onFlyerTypeTap,
    @required this.onZoneTap,
    @required this.onEditInfoTap,
    @required this.onEditKeywordsTap,
    @required this.onEditSpecsTap,
    @required this.onShowAuthorTap,
    @required this.onTriggerEditMode,
    @required this.onPublishFlyer,
    @required this.onDeleteFlyer,
    @required this.onUnPublishFlyer,
    @required this.onRepublishFlyer,
    /// editor data
    @required this.firstTimer,
    @required this.editMode,
    @required this.canDelete,
  });

}
