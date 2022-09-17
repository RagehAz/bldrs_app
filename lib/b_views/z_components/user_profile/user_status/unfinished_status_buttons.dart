import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class StatusButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StatusButtons({
    @required this.status,
    @required this.onSelectStatus,
    @required this.stateIndex,
    @required this.currentUserStatus,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Map<String, Object>> status;
  final Function onSelectStatus;
  final int stateIndex;
  final UserStatus currentUserStatus;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    const double _pageMargin = Ratioz.appBarMargin * 2;
    const double _abPadding = Ratioz.appBarMargin;
    // double abHeight = _screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);
    final int _numberOfButtons =
        (status[stateIndex]['buttons'] as List<Map<String, Object>>).length;
    const double _buttonSpacing = _abPadding;
    final double _buttonsZoneWidth = _screenWidth - (_pageMargin * 3);
    final double _propertyStatusBtWidth = (_buttonsZoneWidth -
            (_numberOfButtons * _buttonSpacing) -
            _buttonSpacing) /
        _numberOfButtons;
    // Alignment defaultAlignment = getTranslated(context, 'Text_Direction') == 'ltr' ? Alignment.centerLeft : Alignment.centerRight;
    final double _propertyStatusBtHeight = _screenHeight * 0.12;
    // --------------------
    return Padding(
      padding: const EdgeInsets.only(bottom: _abPadding),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ...(status[stateIndex]['buttons'] as List<Map<String, Object>>)
                  .map((Map<String, Object> x) {
                final Color _color = x['userStatus'] == UserStatus.finishing &&
                        (currentUserStatus == UserStatus.finishing ||
                            currentUserStatus == UserStatus.planning ||
                            currentUserStatus == UserStatus.building)
                    ? Colorz.yellow255
                    : currentUserStatus == x['userStatus']
                        ? Colorz.yellow255
                        : Colorz.nothing;

                final Color _verseColor =
                    x['userStatus'] == UserStatus.finishing &&
                            (currentUserStatus == UserStatus.finishing ||
                                currentUserStatus == UserStatus.planning ||
                                currentUserStatus == UserStatus.building)
                        ? Colorz.black230
                        : currentUserStatus == x['userStatus']
                            ? Colorz.black230
                            : Colorz.white255;

                final VerseWeight _verseWeight =
                    x['userStatus'] == UserStatus.finishing &&
                            (currentUserStatus == UserStatus.finishing ||
                                currentUserStatus == UserStatus.planning ||
                                currentUserStatus == UserStatus.building)
                        ? VerseWeight.black
                        : currentUserStatus == x['userStatus']
                            ? VerseWeight.black
                            : VerseWeight.thin;

                return DreamBox(
                  width: _propertyStatusBtWidth,
                  height: _propertyStatusBtHeight,
                  verse: Verse.plain(x['state']),
                  verseScaleFactor: currentUserStatus == x['userStatus'] ? 0.55 : 0.55,
                  verseMaxLines: 4,
                  onTap: () => onSelectStatus(x['userStatus']),
                  color: _color,
                  verseColor: _verseColor,
                  verseWeight: _verseWeight,
                );
              }).toList()
            ],
          ),
        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
