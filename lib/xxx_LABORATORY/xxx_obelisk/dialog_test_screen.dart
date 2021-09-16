import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/providers/users/user_streamer.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/flyers_bubble.dart';
import 'package:bldrs/views/widgets/buttons/main_button.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
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

          bool _result = await CenterDialog.showCenterDialog(
            context: context,
            title: '',
            body: 'You Have $_totalNumOfFlyers flyers that will be deactivated that can not be retrieved',
            boolDialog: true,
            height: Scale.superScreenHeight(context) * 0.9,
            child: Column(
              children: <Widget>[

                Container(
                  height: Scale.superScreenHeight(context) * 0.6,
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
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenHeight(context),
          color: Colorz.BloodTest,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                userModelBuilder(
                    context: context,
                    userID: superUserID(),
                    builder: (ctx, userModel){

                      return
                        MainButton(
                          buttonVerse: 'Bzz dialog',
                          buttonIcon: Iconz.Bz,
                          function: () async {

                            /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
                            Map<String, dynamic> _userBzzMap = await BzOps.readAndFilterTeamlessBzzByUserModel(
                              context: context,
                              userModel: userModel,
                            );

                            List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
                            List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

                            await Dialogz.bzzDeactivationDialog(
                              context: context,
                              bzzToKeep: _bzzToKeep,
                              bzzToDeactivate: _bzzToDeactivate,
                            );

                            },
                        );

              }),

                userModelBuilder(
                    context: context,
                    userID: superUserID(),
                    builder: (ctx, userModel){

                      return
                        MainButton(
                          buttonVerse: 'flyers dialog',
                          buttonIcon: Iconz.Flyer,
                          function: () async {

                            /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
                            Map<String, dynamic> _userBzzMap = await BzOps.readAndFilterTeamlessBzzByUserModel(
                              context: context,
                              userModel: userModel,
                            );

                            List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
                            // List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

                            await Dialogz.flyersDeactivationDialog(
                              context: context,
                              bzzToDeactivate: _bzzToDeactivate,
                            );

                          },
                        );

                    }),



              ]
          ),

        ),
      ),
    );
  }
}
