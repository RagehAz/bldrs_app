import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
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
  });


  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    const double _pageMargin = Ratioz.appBarMargin * 2;

    const double _abPadding = Ratioz.appBarMargin;
    // double abHeight = _screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    int _numberOfButtons = (status[stateIndex]['buttons'] as List<Map<String, Object>>).length;
    const double _buttonSpacing = _abPadding;
    double _buttonsZoneWidth = (_screenWidth-(_pageMargin*3));
    double _propertyStatusBtWidth = (_buttonsZoneWidth - (_numberOfButtons*_buttonSpacing) - _buttonSpacing)/_numberOfButtons;

    double _propertyStatusBtHeight = _screenHeight * 0.12;

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
                  return
                      DreamBox(
                        width: _propertyStatusBtWidth,
                        height: _propertyStatusBtHeight,
                        verse: x['state'],
                        verseScaleFactor: currentUserStatus == x['userStatus'] ? 0.55 : 0.55,
                        verseMaxLines: 4,
                        boxFunction: () => switchUserStatus(x['userStatus']),
                        blackAndWhite: false,
                        color:
                        x['userStatus'] == UserStatus.Finishing &&
                            ( currentUserStatus == UserStatus.Finishing ||
                                currentUserStatus == UserStatus.PlanningTalking ||
                                currentUserStatus == UserStatus.Building) ?
                        Colorz.Yellow :
                        currentUserStatus == x['userStatus'] ?
                        Colorz.Yellow :
                        Colorz.Nothing,

                        verseColor:
                        x['userStatus'] == UserStatus.Finishing &&
                            ( currentUserStatus == UserStatus.Finishing ||
                                currentUserStatus == UserStatus.PlanningTalking ||
                                currentUserStatus == UserStatus.Building) ?
                        Colorz.BlackBlack :
                        currentUserStatus == x['userStatus'] ?
                        Colorz.BlackBlack :
                        Colorz.White,

                        verseWeight:
                        x['userStatus'] == UserStatus.Finishing &&
                            ( currentUserStatus == UserStatus.Finishing ||
                                currentUserStatus == UserStatus.PlanningTalking ||
                                currentUserStatus == UserStatus.Building) ?
                        VerseWeight.black :
                        currentUserStatus == x['userStatus'] ?
                        VerseWeight.black :
                        VerseWeight.thin,

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
