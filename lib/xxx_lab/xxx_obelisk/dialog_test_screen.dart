import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/db/fire/ops/bz_ops.dart' as FireBzOps;
import 'package:bldrs/db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/streamers/user_streamer.dart';
import 'package:bldrs/views/widgets/general/bubbles/flyers_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/main_button.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart' as Dialogz;
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogTestScreen extends StatelessWidget {
  const DialogTestScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    // List<TinyFlyer> _designFlyers = _prof.getTinyFlyersByFlyerType(FlyerType.Design);
    final List<FlyerModel> _flyers = _flyersProvider.savedFlyers;


    return MainLayout(
      skyType: SkyType.black,
      pyramids: Iconz.dvBlankSVG,
      layoutWidget: GestureDetector(
        onTap: () async {

          final int _totalNumOfFlyers = _flyers.length;
          const int _numberOfBzz = 16;

          final bool _result = await CenterDialog.showCenterDialog(
            context: context,
            title: '',
            body: 'You Have $_totalNumOfFlyers flyers that will be deactivated that can not be retrieved',
            boolDialog: true,
            height: Scale.superScreenHeight(context) * 0.9,
            child: Column(
              children: <Widget>[

                SizedBox(
                  height: Scale.superScreenHeight(context) * 0.6,
                  child: ListView.builder(
                    itemCount: _numberOfBzz,
                    itemBuilder: (BuildContext context, int index){
                      return
                        FlyersBubble(
                          flyers: _flyers,
                          flyerSizeFactor: 0.2,
                          numberOfColumns: 2,
                          title: 'flyers',
                          numberOfRows: 1,
                          onTap: (String flyerID){
                            blog(flyerID);
                          },
                        );
                    },



                  ),
                ),

                const SuperVerse(
                  verse: 'Would you like to continue ?',
                  margin: 10,
                ),

              ],
            ),
          );

          blog('Result is $_result');

        },
        child: Container(
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenHeight(context),
          color: Colorz.bloodTest,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                userModelBuilder(
                    context: context,
                    userID: FireAuthOps.superUserID(),
                    builder: (BuildContext ctx, UserModel userModel){

                      return
                        MainButton(
                          buttonVerse: 'Bzz dialog',
                          buttonIcon: Iconz.bz,
                          function: () async {

                            /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
                            final Map<String, dynamic> _userBzzMap = await FireBzOps.readAndFilterTeamlessBzzByUserModel(
                              context: context,
                              userModel: userModel,
                            );

                            final List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
                            final List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

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
                    userID: FireAuthOps.superUserID(),
                    builder: (BuildContext ctx, UserModel userModel){

                      return
                        MainButton(
                          buttonVerse: 'flyers dialog',
                          buttonIcon: Iconz.flyer,
                          function: () async {

                            /// C - read and filter user bzz for which bzz he's the only author of to be deactivated
                            final Map<String, dynamic> _userBzzMap = await FireBzOps.readAndFilterTeamlessBzzByUserModel(
                              context: context,
                              userModel: userModel,
                            );

                            final List<BzModel> _bzzToDeactivate = _userBzzMap['bzzToDeactivate'];
                            // List<BzModel> _bzzToKeep = _userBzzMap['bzzToKeep'];

                            final List<FlyerModel> _bzzFlyers = await FireFlyerOps.readBzzFlyers(
                              context: context,
                              bzzModels: _bzzToDeactivate,
                            );

                            await Dialogz.flyersDeactivationDialog(
                              context: context,
                              bzzToDeactivate: _bzzToDeactivate,
                              flyers: _bzzFlyers,
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
