import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/views/widgets/general/dialogs/section_dialog/section_bubble.dart';
import 'package:bldrs/views/widgets/general/dialogs/section_dialog/section_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class DrawerDialog extends StatelessWidget {
  final double width;

  DrawerDialog({
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {

    final double _drawerWidth = 300;//Scale.superScreenWidth(context);
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

              Container(
                width: _bubbleWidth,
                alignment: Alignment.center,
                // child: ExpandingTile(
                //   group: GroupModel.getGroupBySection(section: Section.NewProperties)[0],
                //   selectedKeywords: [],
                //   onKeywordTap: (Keyword keyword){
                //     keyword.printKeyword();
                //     },
                //   onGroupTap: (){
                //     print('on gorup tap is tapped man');
                //     },
                //
                //   height: 150,
                //   // key: PageStorageKey<String>('fuck_you_bitch_mother_fucker'),
                //   icon: Iconz.DvDonaldDuck,
                //   iconSizeFactor: 0.7,
                //   initiallyExpanded: false,
                //   onExpansionChanged: (bool isExpanded){
                //     print('expansion just changed : isExpanded : ${isExpanded}');
                //   },
                //   tileWidth: _bubbleWidth,
                // ),
              ),

              /// REAL ESTATE
              SectionBubble(
                  title: 'RealEstate',
                  icon: Iconz.PyramidSingleYellow,
                  bubbleWidth: _bubbleWidth,
                  buttons: <Widget>[

                    SectionDialogButton(
                      section: Section.NewProperties,
                      inActiveMode: false,
                      dialogHeight: dialogHeight,
                    ),

                    SectionDialogButton(
                      section: Section.ResaleProperties,
                      inActiveMode: false,
                      dialogHeight: dialogHeight,
                    ),

                    SectionDialogButton(
                      section: Section.RentalProperties,
                      inActiveMode: true,
                      dialogHeight: dialogHeight,
                    ),


                  ]
              ),

              /// Construction
              SectionBubble(
                  title: 'Construction',
                  icon: Iconz.PyramidSingleYellow,
                  bubbleWidth: _bubbleWidth,
                  buttons: <Widget>[

                    SectionDialogButton(
                      section: Section.Designs,
                      inActiveMode: false,
                      dialogHeight: dialogHeight,
                    ),

                    SectionDialogButton(
                      section: Section.Projects,
                      inActiveMode: false,
                      dialogHeight: dialogHeight,
                    ),

                    SectionDialogButton(
                      section: Section.Crafts,
                      inActiveMode: false,
                      dialogHeight: dialogHeight,
                    ),

                  ]
              ),

              /// Construction
              SectionBubble(
                title: 'Supplies',
                icon: Iconz.PyramidSingleYellow,
                bubbleWidth: _bubbleWidth,
                buttons: <Widget>[

                  SectionDialogButton(
                    section: Section.Products,
                    inActiveMode: false,
                    dialogHeight: dialogHeight,
                  ),

                  SectionDialogButton(
                    section: Section.Equipment,
                    inActiveMode: false,
                    dialogHeight: dialogHeight,
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
