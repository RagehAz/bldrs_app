

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class GenderBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GenderBubble({
    @required this.selectedGender,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<Gender> selectedGender; /// p
  final ValueChanged<Gender> onTap;
  /// --------------------------------------------------------------------------
  static double buttonWidth(BuildContext context){
    const double _spacing = 10;
    const int _numberOfButtons = 3;
    const int _numberOfInnerSpacing = 2;

    final double _bubbleClearWidth = Bubble.clearWidth(context);

    final double _buttonWidth = (
        _bubbleClearWidth
            - (_numberOfInnerSpacing * _spacing)
    )
        / _numberOfButtons;

    return _buttonWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const List<Gender> _gendersList = UserModel.gendersList;
    final double _buttonWidth = buttonWidth(context);

    return Bubble(
      title: 'Gender',
      redDot: true,
      width: Bubble.defaultWidth(context),
      columnChildren: <Widget>[

        ValueListenableBuilder(
            valueListenable: selectedGender,
            builder: (_, Gender _selectedGender, Widget child){

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  ...List.generate(_gendersList.length,
                          (index){

                    final Gender _gender = UserModel.gendersList[index];
                    final String _genderString = UserModel.translateGender(_gender);

                    final bool _isSelected = _gender == _selectedGender;

                    final Color _buttonColor = _isSelected ?
                    Colorz.yellow255
                        :
                    Colorz.white10;

                    final Color _verseColor = _isSelected ?
                    Colorz.black255
                        :
                    Colorz.white255;

                    return DreamBox(
                      height: 50,
                      width: _buttonWidth,
                      color: _buttonColor,
                      verse: _genderString,
                      verseColor: _verseColor,
                      verseScaleFactor: 0.8,
                      onTap: () => onTap(_gender),
                    );

                  }
                  ),

                ],
              );

            }
        ),

      ],
    );
  }
}
