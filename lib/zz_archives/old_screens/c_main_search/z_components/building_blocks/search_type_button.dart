import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:flutter/material.dart';

class SearchTypeButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchTypeButton({
    required this.modelType,
    required this.currentModel,
    required this.onTap,
    super.key
  });
  // --------------------
  final ModelType? modelType;
  final ModelType? currentModel;
  final Function onTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isSelected = currentModel == modelType;

    return AppBarButton(
      icon: RecordTyper.getIconByModelType(modelType),
      verse: RecordTyper.getVerseByModelType(modelType),
      // bigIcon: false,
      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      buttonColor: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
      iconColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
