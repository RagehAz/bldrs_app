import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/flyers_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
    // List<TinyFlyer> _designFlyers = _prof.getTinyFlyersByFlyerType(FlyerType.Design);
    List<TinyFlyer> _flyers = _prof.getAllTinyFlyers;


    return MainLayout(
      sky: Sky.Black,
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: GestureDetector(
        onTap: () async {

          int _totalNumOfFlyers = _flyers.length;
          int _numberOfBzz = 16;

          bool _result = await superDialog(
            context: context,
            title: '',
            body: 'You Have $_totalNumOfFlyers flyers that will be deactivated that can not be retrieved',
            boolDialog: true,
            height: superScreenHeight(context) * 0.9,
            child: Column(
              children: <Widget>[

                Container(
                  height: superScreenHeight(context) * 0.6,
                  child: ListView.builder(
                    itemCount: _numberOfBzz,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      return
                        FlyersBubble(
                          tinyFlyers: _flyers,
                          flyerSizeFactor: 0.2,
                          numberOfColumns: 2,
                          title: 'flyers',
                          numberOfRows: 1,
                          onTap: (value){
                            print(value);
                          },
                        );
                    },



                  ),
                ),

                SuperVerse(
                  verse: 'Would you like to continue ?',
                  margin: 10,
                ),

              ],
            ),
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
