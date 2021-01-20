import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/flyer/header/mini_header/mini_header_items/mini_header_strip/mini_header_strip_items/bz_logo.dart';
import 'package:flutter/material.dart';

class GrowingBz extends StatelessWidget {
  final BzType bzType;
  final List<String> bzLogos;

  GrowingBz({
    @required this.bzType,
    @required this.bzLogos,
  });


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double pageMargin = Ratioz.ddAppBarMargin * 2;
    double spacings = 10;
    double logoHeight = (screenWidth - (pageMargin*4) - (spacings*4))/5;

    return InPyramidsBubble(
      centered: true,
      bubbleColor: Colorz.WhiteAir,
      columnChildren: <Widget>[

        BubbleTitle(verse: 'Trending ${bldrsTypePageTitle(bzType)}'),

        Divider(
          height: spacings,
        ),

        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: screenWidth,
            height: logoHeight,
            // color: Colorz.BloodTest,
            child: ListView.separated(
                itemCount: bzLogos.length,
                scrollDirection: Axis.horizontal,
                addAutomaticKeepAlives: true,
                separatorBuilder:  (_, _y) => SizedBox(height: logoHeight,width: spacings,),
                itemBuilder: (_, _x) {
                  return
                    BzLogo(
                      width: logoHeight,
                      image: bzLogos[_x],
                      corner: 10,
                    );
                }
            ),
          ),
        ),
      ],
    );
  }
}
