import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/main.dart';
import 'package:bldrs/views/widgets/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class TabBarTest extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return TabBarLayout(
      sky: Sky.Night,
    );
  }
}

class TabBarLayout extends StatelessWidget {
  final Sky sky;

  const TabBarLayout({
    @required this.sky,
});

  @override
  Widget build(BuildContext context) {

    Color _backgroundColor = sky == Sky.Non || sky == Sky.Black? Colorz.Black230 : Colorz.SkyDarkBlue;

    return GestureDetector(
      onTap: (){Keyboarders.minimizeKeyboardOnTapOutSide(context);},
      child: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Stack(
            children: <Widget>[

              if(sky == Sky.Non)
                Container(
                  width: Scale.superScreenWidth(context),
                  height: Scale.superScreenHeight(context),
                  color: _backgroundColor,
                ),

              Scaffold(
                backgroundColor: _backgroundColor,
                appBar: AppBar(
                  backgroundColor: Colorz.Black80,
                  // foregroundColor: Colorz.Yellow255,
                  elevation: 0,
                  actions: [],
                  leading: Container(),
                  leadingWidth: 0,
                  automaticallyImplyLeading: true,
                  flexibleSpace: Container(
                    width: Scale.superScreenWidth(context),
                    height: Ratioz.appBarSmallHeight + (Ratioz.appBarMargin * 2),
                    // color: Colorz.Blue225,
                    child: BldrsAppBar(
                      pageTitle: 'Eshta',
                      appBarType: AppBarType.Basic,
                    ),
                  ),
                  bottom: TabBar(
                    tabs: <Widget>[

                      SuperVerse(
                        verse: 'Fuck',
                      ),

                      SuperVerse(
                        verse: 'You',
                      ),

                    ],
                  ),
                ),
                body: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[

                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colorz.BloodTest,
                      ),
                    ),

                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colorz.Yellow255,
                      ),
                    ),

                  ],
                ),
              ),

            ],


          ),
        ),
      ),
    );
  }
}
