import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/zebala/old_record_model.dart';
import 'package:bldrs/a_models/x_secondary/bldrs_model_type.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
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
      icon: RecordX.getIconByModelType(modelType),
      verse: RecordX.getVerseByModelType(modelType),
      // bigIcon: false,
      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      buttonColor: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
      iconColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
