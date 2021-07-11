import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';

class PopUpTestScreen extends StatefulWidget {
  @override
  _PopUpTestScreenState createState() => _PopUpTestScreenState();
}

class _PopUpTestScreenState extends State<PopUpTestScreen> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return MainLayout(

      layoutWidget:
      ListView(
        children: [
          Container(
            width: screenWidth,
            height: screenWidth,
            alignment: Alignment.center,
            child: Builder(

              builder: (context) =>

                  Center(
                    child: IconButton(
                      iconSize: 40,
                      icon: DreamBox(
                        // width: 100,
                        height: 40,
                        icon: Iconz.DvRageh,
                      ),
                      onPressed: (){
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colorz.White10,
                              elevation: 0,
                              content: SuperVerse(
                                verse: 'wtf',
                                labelColor: Colorz.BloodTest,
                              ),
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'koko',
                                onPressed: (){},
                              ),

                            ));
                      },
                    ),
                  ),
            ),
          ),

          Dismissible(
            key: ValueKey('dd'),

            child: DreamBox(
              height: 200,
              icon: Iconz.DvRageh,
            ),
            background: Container(
              height: 20,
              color: Colorz.Yellow225,
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
                  FlatButton(child: Text('no'), onPressed: (){
                    Navigator.of(ctx).pop(false);
                  },),
                  FlatButton(child: Text('yes'), onPressed: (){
                    Navigator.of(ctx).pop(true);
                  },),
                ],
              ));
            },
          )

        ],
      ),

    );
  }
}
