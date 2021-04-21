import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';

class DialogTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      sky: Sky.Black,
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: GestureDetector(
        onTap: () async {

          bool _result = await superDialog(
            context: context,
            title: '',
            boolDialog: null,
            height: null,
            body: 'Waiting',
            child: Loading(loading: true,),
          );

          print('Result is $_result');

        },
        child: Container(
          width: superScreenWidth(context),
          height: superScreenHeight(context),
          color: Colorz.BloodTest,

        ),
      ),
    );
  }
}
