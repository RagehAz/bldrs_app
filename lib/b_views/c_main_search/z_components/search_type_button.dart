import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class SearchTypeButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchTypeButton({
    @required this.modelType,
    @required this.currentModel,
    @required this.onTap,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final ModelType modelType;
  final ModelType currentModel;
  final Function onTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isSelected = currentModel == modelType;

    return AppBarButton(
      icon: RecordModel.getIconByModelType(modelType),
      verse: RecordModel.getVerseByModelType(modelType),
      // bigIcon: false,
      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      buttonColor: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
      iconColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
