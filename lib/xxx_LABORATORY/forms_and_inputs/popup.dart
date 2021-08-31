import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/providers/users/user_streamer.dart';
import 'package:bldrs/views/widgets/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';

class PopUpTestScreen extends StatefulWidget {
  @override
  _PopUpTestScreenState createState() => _PopUpTestScreenState();
}

class _PopUpTestScreenState extends State<PopUpTestScreen> {
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    // BarType _barType = BarType.minWithText;

    Widget _spacer = SizedBox(height: 20,);

    return MainLayout(

      layoutWidget:
      ListView(
        children: <Widget>[

          Stratosphere(),

          Dismissible(
            key: ValueKey('dd'),

            child: DreamBox(
              height: 200,
              icon: Iconz.DvRageh,
            ),
            background: Container(
              height: 20,
              color: Colorz.Yellow255,
              child: DreamBox(
                height: 20,
                width: 20,
                icon: Iconz.BxPropertiesOff,
              ),
            ),
            direction: DismissDirection.startToEnd,
            confirmDismiss: (direction){
              return showDialog(context: context, builder: (ctx) => AlertDialog(

                backgroundColor: Colorz.White10,
                title: SuperVerse(verse: 'fuck you ?',),
                content: SuperVerse(verse: 'a77a ya man',),
                actions: [
                  // FlatButton(child: Text('no'), onPressed: (){
                  //   Navigator.of(ctx).pop(false);
                  // },),
                  // FlatButton(child: Text('yes'), onPressed: (){
                  //   Navigator.of(ctx).pop(true);
                  // },),
                ],
              ));
            },
          ),

          _spacer,
          _spacer,
          _spacer,
          _spacer,
          _spacer,
          _spacer,
          _spacer,
          _spacer,
          _spacer,
          _spacer,


          Container(
            width: _screenWidth,
            alignment: Alignment.center,
            child: userModelBuilder(
              context: context,
              userID: superUserID(),
              builder: (ctx, userModel){
                return
                  Builder(
                    builder: (context){
                      return
                        Center(
                          child: Column(
                            children: <Widget>[

                              /// open
                              DreamBox(
                                // width: 100,
                                height: 40,
                                icon: Iconz.DvRageh,
                                verse: 'press',
                                onTap:

                                () => NavDialog.showNoInternetDialog(context),

                                //     () async {
                                //   Scaffold.of(context).hideCurrentSnackBar();
                                //   await Scaffold.of(context).showSnackBar(
                                //     SnackBar(
                                //       duration: Duration(seconds: 5),
                                //       backgroundColor: Colorz.Nothing,
                                //       behavior: SnackBarBehavior.fixed,
                                //       onVisible: (){
                                //         print('is visible now');
                                //       },
                                //       elevation: 0,
                                //       content: Container(
                                //         width: Scale.superScreenWidth(context),
                                //         height: Scale.navBarHeight(context: context, barType: _barType),
                                //         color: Colorz.Nothing,
                                //         alignment: Alignment.center,
                                //         child: DreamBox(
                                //           height: Scale.navBarHeight(context: context, barType: _barType),
                                //           width: Scale.navBarWidth(context: context,userModel: userModel, barType: _barType),
                                //           color: Colorz.DarkRed255,
                                //           corners: Scale.navBarCorners(context: context, barType: _barType),
                                //           verse: 'No Internet !',
                                //           verseScaleFactor: 0.8,
                                //           verseWeight: VerseWeight.bold,
                                //           verseColor: Colorz.White255,
                                //           verseShadow: true,
                                //           verseItalic: true,
                                //           bubble: false,
                                //           onTap: () => Scaffold.of(context).hideCurrentSnackBar(),
                                //         ),
                                //       ),
                                //
                                //     ),
                                //   );
                                // },

                              ),

                              _spacer,

                              /// close
                              DreamBox(
                                height: 40,
                                verse: 'Close Snackbar',
                                onTap: () async {
                                  await Scaffold.of(context).hideCurrentSnackBar();
                                },
                              ),

                            ],
                          ),
                        );
                    },
                  );
              }

            ),
          ),



        ],
      ),

    );
  }
}
