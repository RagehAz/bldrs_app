import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class StatusButtons extends StatelessWidget {
  final List<Map<String, Object>> status;
  final Function switchUserStatus;
  final int stateIndex;
  final UserStatus currentUserStatus;

  const StatusButtons({
    @required this.status,
    @required this.switchUserStatus,
    @required this.stateIndex,
    @required this.currentUserStatus,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;
    const double _pageMargin = Ratioz.appBarMargin * 2;

    const double _abPadding = Ratioz.appBarMargin;
    // double abHeight = _screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    final int _numberOfButtons = (status[stateIndex]['buttons'] as List<Map<String, Object>>).length;
    const double _buttonSpacing = _abPadding;
    final double _buttonsZoneWidth = (_screenWidth-(_pageMargin*3));
    final double _propertyStatusBtWidth = (_buttonsZoneWidth - (_numberOfButtons*_buttonSpacing) - _buttonSpacing)/_numberOfButtons;

    final double _propertyStatusBtHeight = _screenHeight * 0.12;

    // Alignment defaultAlignment = getTranslated(context, 'Text_Direction') == 'ltr' ? Alignment.centerLeft : Alignment.centerRight;

    return Padding(
      padding: const EdgeInsets.only(bottom: _abPadding),
      child: Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ...(status[stateIndex]['buttons'] as List<Map<String, Object>>)
                .map(
                (x){

                  final Color _color = x['userStatus'] == UserStatus.finishing &&
                      ( currentUserStatus == UserStatus.finishing ||
                          currentUserStatus == UserStatus.planning ||
                          currentUserStatus == UserStatus.building) ?
                  Colorz.yellow255 :
                  currentUserStatus == x['userStatus'] ?
                  Colorz.yellow255 :
                  Colorz.nothing;

                  final _verseColor =
                  x['userStatus'] == UserStatus.finishing &&
                      ( currentUserStatus == UserStatus.finishing ||
                          currentUserStatus == UserStatus.planning ||
                          currentUserStatus == UserStatus.building) ?
                  Colorz.black230 :
                  currentUserStatus == x['userStatus'] ?
                  Colorz.black230 :
                  Colorz.white255;

                  final _verseWeight = x['userStatus'] == UserStatus.finishing &&
                      ( currentUserStatus == UserStatus.finishing ||
                          currentUserStatus == UserStatus.planning ||
                          currentUserStatus == UserStatus.building) ?
                  VerseWeight.black :
                  currentUserStatus == x['userStatus'] ?
                  VerseWeight.black :
                  VerseWeight.thin;

                  return
                      DreamBox(
                        width: _propertyStatusBtWidth,
                        height: _propertyStatusBtHeight,
                        verse: x['state'],
                        verseScaleFactor: currentUserStatus == x['userStatus'] ? 0.55 : 0.55,
                        verseMaxLines: 4,
                        onTap: () => switchUserStatus(x['userStatus']),
                        blackAndWhite: false,
                        color: _color,
                        verseColor: _verseColor,
                        verseWeight: _verseWeight,
                      );

                }
            ).toList()

            ],
          ),

            ],

       ),
    );
  }
}
