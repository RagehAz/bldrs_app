import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double pageMargin = Ratioz.ddAppBarMargin * 2;

    double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    int numberOfButtons = (status[stateIndex]['buttons'] as List<Map<String, Object>>).length;
    double buttonSpacing = abPadding;
    double buttonsZoneWidth = (screenWidth-(pageMargin*3));
    double propertyStatusBtWidth = (buttonsZoneWidth - (numberOfButtons*buttonSpacing) - buttonSpacing)/numberOfButtons;

    double propertyStatusBtHeight = screenHeight * 0.12;

    // Alignment defaultAlignment = getTranslated(context, 'Text_Direction') == 'ltr' ? Alignment.centerLeft : Alignment.centerRight;

    return Padding(
      padding: EdgeInsets.only(bottom: abPadding),
      child: Column(
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...(status[stateIndex]['buttons'] as List<Map<String, Object>>)
                .map(
                (x){
                  return
                      DreamBox(
                        width: propertyStatusBtWidth,
                        height: propertyStatusBtHeight,
                        verse: x['state'],
                        verseScaleFactor: currentUserStatus == x['userStatus'] ? 0.55 : 0.55,
                        verseMaxLines: 4,
                        boxFunction: () => switchUserStatus(x['userStatus']),
                        blackAndWhite: false,
                        color:
                        x['userStatus'] == UserStatus.ConstructingUser &&
                            ( currentUserStatus == UserStatus.ConstructingUser ||
                                currentUserStatus == UserStatus.PlanningUser ||
                                currentUserStatus == UserStatus.BuildingUser) ?
                        Colorz.Yellow :
                        currentUserStatus == x['userStatus'] ?
                        Colorz.Yellow :
                        Colorz.Nothing,

                        verseColor:
                        x['userStatus'] == UserStatus.ConstructingUser &&
                            ( currentUserStatus == UserStatus.ConstructingUser ||
                                currentUserStatus == UserStatus.PlanningUser ||
                                currentUserStatus == UserStatus.BuildingUser) ?
                        Colorz.BlackBlack :
                        currentUserStatus == x['userStatus'] ?
                        Colorz.BlackBlack :
                        Colorz.White,

                        verseWeight:
                        x['userStatus'] == UserStatus.ConstructingUser &&
                            ( currentUserStatus == UserStatus.ConstructingUser ||
                                currentUserStatus == UserStatus.PlanningUser ||
                                currentUserStatus == UserStatus.BuildingUser) ?
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
