import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/views/widgets/general/dialogs/section_dialog/section_bubble.dart';
import 'package:bldrs/views/widgets/general/dialogs/section_dialog/section_button.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/section_tile.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DrawerDialog extends StatelessWidget {
  final double width;

  DrawerDialog({
    this.width = 350,
  });

  static const double drawerEdgeDragWidth = 15;
  static const bool drawerEnableOpenDragGesture = true;
  static const Color drawerScrimColor = Colorz.black125;



  @override
  Widget build(BuildContext context) {

    final double _drawerWidth = width;
    final double _drawerHeight = Scale.superScreenHeight(context);

    final double _bubbleWidth = _drawerWidth - (Ratioz.appBarMargin * 2);
    final double dialogHeight = _drawerHeight;

    return Container(
      width: _drawerWidth,
      child: Drawer(
        key: ValueKey<String>('drawer'),
        elevation: 10,
        child: Container(
          width: _drawerWidth,
          height: _drawerHeight,
          color: Colorz.black255,
          alignment: Aligners.superTopAlignment(context),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              SuperVerse(
                verse: 'SELECT A SECTION',
                weight: VerseWeight.black,
                italic: true,
                centered: false,
                size: 3,
                margin: Ratioz.appBarMargin,
              ),

              /// REAL ESTATE
              SectionBubble(
                  title: 'RealEstate',
                  icon: Iconz.PyramidSingleYellow,
                  bubbleWidth: _bubbleWidth,
                  buttons: <Widget>[

                    SectionTile(
                      bubbleWidth: _bubbleWidth,
                      inActiveMode: false,
                      section: Section.NewProperties,
                    ),

                    MainLayout.spacer10,

                    SectionTile(
                      bubbleWidth: _bubbleWidth,
                      inActiveMode: false,
                      section: Section.ResaleProperties,
                    ),

                    MainLayout.spacer10,

                    SectionTile(
                      bubbleWidth: _bubbleWidth,
                      inActiveMode: false,
                      section: Section.RentalProperties,
                    ),

                  ]
              ),

              /// Construction
              SectionBubble(
                  title: 'Construction',
                  icon: Iconz.PyramidSingleYellow,
                  bubbleWidth: _bubbleWidth,
                  buttons: <Widget>[

                    SectionTile(
                      bubbleWidth: _bubbleWidth,
                      inActiveMode: false,
                      section: Section.Designs,
                    ),

                    MainLayout.spacer10,

                    SectionTile(
                      bubbleWidth: _bubbleWidth,
                      inActiveMode: false,
                      section: Section.Projects,
                    ),

                    MainLayout.spacer10,

                    SectionTile(
                      bubbleWidth: _bubbleWidth,
                      inActiveMode: false,
                      section: Section.Crafts,
                    ),

                  ]
              ),

              /// Construction
              SectionBubble(
                title: 'Supplies',
                icon: Iconz.PyramidSingleYellow,
                bubbleWidth: _bubbleWidth,
                buttons: <Widget>[

                  SectionTile(
                    bubbleWidth: _bubbleWidth,
                    inActiveMode: false,
                    section: Section.Products,
                  ),

                  MainLayout.spacer10,

                  SectionTile(
                    bubbleWidth: _bubbleWidth,
                    inActiveMode: false,
                    section: Section.Equipment,
                  ),

                ],
              ),

              const PyramidsHorizon(heightFactor: 0.5,),

            ],
          ),
        ),
      ),
    );
  }
}
