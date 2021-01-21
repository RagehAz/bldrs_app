import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/flyer/header/max_header/max_header_items/bz_pg_counter.dart';
import 'package:bldrs/views/widgets/flyer/header/max_header/max_header_items/bz_pg_verse.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/black_sky.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class RagehDashBoardScreen extends StatefulWidget {

  @override
  _RagehDashBoardScreenState createState() => _RagehDashBoardScreenState();
}

class _RagehDashBoardScreenState extends State<RagehDashBoardScreen> {
  
  String currentPage = 'Main';
  
  void pageSwitcher (String pageName){
    setState(() {
      currentPage = pageName;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    // double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      bottom: true,
      top: true,
      child: Scaffold(

        body: Stack(
          children: <Widget>[

            BlackSky(),
            
            currentPage == 'Statistics' ? 
            GeneralStatistics() : 
            MainList(pageSwitcher: pageSwitcher),

            Pyramids(
              whichPyramid: Iconz.PyramidzYellow,
            ),

          ],
        ),
      ),
    );
  }
}


class GeneralStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return ListView(

              children: <Widget>[

                // ------------------------------------------------

                BzPgVerse(
                verse: translate(context, 'Allaho_Akbar'),
                size: 5,
                flyerZoneWidth: screenWidth,
                maxLines: 1,
              ),

                Container(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  child: WebsafeSvg.asset(Iconz.BldrsNameEn),
                ),

                // ------------------------------------------------

                SuperVerse(
                  verse: 'General states :-',
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: screenWidth * 0.05,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Users',
                  count: 1,
                  icon: Iconz.NormalUser,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Businesses',
                  count: 0,
                  icon: Iconz.Bz,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'flyers',
                  count: 0,
                  icon: Iconz.Gallery,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Slides',
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                // --- SECTION SEPARATOR
                Container(
                  width: screenWidth,
                  height: screenWidth * 0.002,
                  color: Colorz.Yellow,
                  margin: EdgeInsets.only(top: screenWidth * 0.05),
                ),

                SuperVerse(
                  verse: 'Bz states :-',
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: screenWidth * 0.05,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Realtors',
                  count: 0,
                  icon: Iconz.BxPropertiesOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Property flyers',
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                // -- SEPARATOR
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenWidth * 0.001,
                    color: Colorz.YellowSmoke,
                  ),
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Designers',
                  count: 0,
                  icon: Iconz.BxDesignsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Design flyers',
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                // -- SEPARATOR
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenWidth * 0.001,
                    color: Colorz.YellowSmoke,
                  ),
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Suppliers',
                  count: 0,
                  icon: Iconz.BxEquipmentOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Product flyers',
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Equipment flyers',
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                // -- SEPARATOR
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenWidth * 0.001,
                    color: Colorz.YellowSmoke,
                  ),
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Contractors',
                  count: 0,
                  icon: Iconz.BxProjectsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Project Flyers',
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                // -- SEPARATOR
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenWidth * 0.001,
                    color: Colorz.YellowSmoke,
                  ),
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Craftsmen',
                  count: 0,
                  icon: Iconz.BxCraftsOn,
                  iconSizeFactor: 0.95,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Craft flyers',
                  count: 0,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.8,
                ),

                // ------------------------------------------------
                // --- SECTION SEPARATOR
                Container(
                  width: screenWidth,
                  height: screenWidth * 0.002,
                  color: Colorz.Yellow,
                  margin: EdgeInsets.only(top: screenWidth * 0.05),
                ),

                SuperVerse(
                  verse: 'Engagement states :-',
                  size: 3,
                  italic: true,
                  shadow: true,
                  weight: VerseWeight.black,
                  centered: false,
                  margin: screenWidth * 0.05,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Saves',
                  count: 0,
                  icon: Iconz.SaveOn,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Views',
                  count: 0,
                  icon: Iconz.Views,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Shares',
                  count: 0,
                  icon: Iconz.Share,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Follows',
                  count: 0,
                  icon: Iconz.Follow,
                  iconSizeFactor: 0.8,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Connects',
                  count: 0,
                  icon: Iconz.HandShake,
                  iconSizeFactor: 0.9,
                ),

                BzPgCounter(
                  flyerZoneWidth: screenWidth,
                  verse: 'Contact me clicks',
                  count: 0,
                  icon: Iconz.ComPhone,
                  iconSizeFactor: 0.8,
                ),

                // --- THE END
                Container(
                  width: screenWidth,
                  height: screenWidth * 0.5,
                ),

              ],
            );
  }
}

class MainList extends StatelessWidget {
  final Function pageSwitcher;
  
  MainList({@required this.pageSwitcher});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[

          // --- General Statistics
          BTMain(
            buttonVerse: 'General Statistics',
            function: () => pageSwitcher('Statistics'),
            splashColor: Colorz.Yellow,
            buttonColor: Colorz.BabyBlueSmoke,
            buttonVerseShadow: true,
            stretched: true,
            buttonIcon: '',
          ),

          // --- Send Notifications
          BTMain(
            buttonVerse: 'Send Notifications',
            function: (){print('Notifications');},
            splashColor: Colorz.Yellow,
            buttonColor: Colorz.BabyBlueSmoke,
            buttonVerseShadow: true,
            stretched: true,
            buttonIcon: '',
          ),

          // --- KEYWORD MANAGER
          BTMain(
            buttonVerse: 'Keywords Manager',
            function: (){print('Keywords');},
            splashColor: Colorz.Yellow,
            buttonColor: Colorz.BabyBlueSmoke,
            buttonVerseShadow: true,
            stretched: true,
            buttonIcon: '',
          ),

          // --- KEYWORD MANAGER
          BTMain(
            buttonVerse: 'Flyers Manager',
            function: (){print('Flyers Manager');},
            splashColor: Colorz.Yellow,
            buttonColor: Colorz.BabyBlueSmoke,
            buttonVerseShadow: true,
            stretched: true,
            buttonIcon: '',
          ),

        ],
      ),
    );
  }
}
