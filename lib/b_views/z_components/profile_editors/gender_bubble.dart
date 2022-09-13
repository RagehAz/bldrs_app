import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class GenderBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GenderBubble({
    @required this.onTap,
    @required this.userModel,
    @required this.canValidate,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<Gender> onTap;
  final UserModel userModel;
  final bool canValidate;
  /// --------------------------------------------------------------------------
  static double buttonWidth(BuildContext context){
    const double _spacing = 10;
    const int _numberOfButtons = 2;
    const int _numberOfInnerSpacing = _numberOfButtons - 1;

    final double _bubbleClearWidth = Bubble.clearWidth(context);

    final double _buttonWidth =
        (_bubbleClearWidth - (_numberOfInnerSpacing * _spacing))
            /
            _numberOfButtons;

    return _buttonWidth;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const List<Gender> _gendersList = UserModel.gendersList;
    final double _buttonWidth = buttonWidth(context);
    // --------------------
    return Bubble(
      bubbleColor: Colorizer.ValidatorColor(
        canErrorize: canValidate,
        validator: () => Formers.genderValidator(
          userModel: userModel,
          canValidate: canValidate,
        ),
      ),
      headerViewModel: const BubbleHeaderVM(
        // headlineVerse: 'phid_gender',
        redDot: true,
      ),
      width: Bubble.bubbleWidth(context),
      columnChildren: <Widget>[

        /// BUTTONS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            ...List.generate(_gendersList.length,
                    (index){

                  final Gender _gender = UserModel.gendersList[index];
                  final String _genderPhid = UserModel.getGenderPhid(_gender);
                  final String _genderIcon = UserModel.genderIcon(_gender);

                  final bool _isSelected = _gender == userModel.gender;

                  final Color _buttonColor = _isSelected ?
                  Colorz.yellow255
                      :
                  Colorz.white10;

                  final Color _verseColor = _isSelected ?
                  Colorz.black255
                      :
                  Colorz.white255;

                  return DreamBox(
                    icon: _genderIcon,
                    iconSizeFactor: 0.6,
                    iconColor: _verseColor,
                    height: 50,
                    width: _buttonWidth,
                    color: _buttonColor,
                    verse: Verse(
                      text: _genderPhid,
                      translate: true,
                    ),
                    verseColor: _verseColor,
                    verseScaleFactor: 1.2,
                    verseCentered: false,
                    onTap: () => onTap(_gender),
                  );

                }
            ),

          ],
        ),

        /// VALIDATOR
        SuperValidator(
          width: Bubble.clearWidth(context),
          validator: () => Formers.genderValidator(
            userModel: userModel,
            canValidate: canValidate,
          ),
          // autoValidate: true,
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
