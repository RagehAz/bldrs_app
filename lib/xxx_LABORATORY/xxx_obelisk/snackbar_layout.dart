import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class SnackBarLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(
      onBldrsTap: (){
        print('kos omak ya allam');


        },
      pageTitle: 'Snack bar',
      listWidgets: <Widget>[

        Builder(
            builder:
                (context) => WideButton(
              verse: 'Fuck you',
              onTap: () async {

                print(' yel3an mayteeen ommak');

                Scaffold.of(context).openDrawer();

              },
            )
        ),



      ],
    );
  }
}
