import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/dash_button/dash_button_model.dart';
import 'package:flutter/material.dart';

class DashButton extends StatelessWidget {

  const DashButton({
    @required this.size,
    @required this.dashButtonModel,
    this.color = Colorz.bloodTest,
    Key key,
  }) : super(key: key);

  final DashButtonModel dashButtonModel;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {


    return DreamBox(
      width: size,
      height: size,
      color: Colorz.bloodTest,
      onTap: () async {

        if (dashButtonModel.screen != null){
          await Nav.goToNewScreen(context, dashButtonModel.screen);
        }

      },
      subChild: Column(
        children: <Widget>[

          DreamBox(
            height: size * 0.5,
            width: size * 0.5,
            icon: dashButtonModel.icon,
            iconSizeFactor: 0.8,
            bubble: false,
            margins: size * 0.05,
          ),

          Container(
            width: size,
            height: size - (size * 0.5 + (size * 0.05 * 2)),
            padding: EdgeInsets.symmetric(horizontal: size * 0.05),
            child: SuperVerse(
              verse: dashButtonModel.verse,
              maxLines: 2,
              scaleFactor: size * 0.008,
            ),
          ),

        ],
      ),
    );
  }
}
