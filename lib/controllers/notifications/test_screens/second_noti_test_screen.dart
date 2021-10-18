import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SecondNotiTestScreen extends StatelessWidget {
  final String thing;

  const SecondNotiTestScreen({
    @required this.thing,
});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidsWhite,
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          Container(
            width: 300,
            height: 400,
            color: Colorz.bloodTest,
            child: Container(),
          ),

        ],
      ),


    );
  }
}
