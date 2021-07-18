import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class PersonButton extends StatelessWidget {
  final double totalHeight;
  final String image;
  final String name;
  final String id;
  final Function onTap;

  PersonButton({
    @required this.totalHeight,
    @required this.image,
    @required this.name,
    @required this.id,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    double _imageHeight = totalHeight * 0.6 ;
    double _imageWidth = _imageHeight;

    double _nameHeight = totalHeight - _imageHeight;
    double _nameWidth = totalHeight * 0.6;

    return Container(
      width: _nameWidth,
      height: _imageHeight,
      margin: EdgeInsets.symmetric(horizontal: _imageWidth * 0.005),
      decoration: BoxDecoration(
        color: Colorz.Black20,
        borderRadius: Borderers.superBorderAll(context, _imageWidth * 0.25),
      ),
      child: Column(
        children: <Widget>[

          ///
          DreamBox(
            height: _imageHeight * 0.90,
            width: _imageWidth * 0.90,
            margins: _imageWidth * 0.05,
            icon: image,
            underLine: name,
            underLineShadowIsOn: true,
            iconRounded: false,
            bubble: false,
            onTap: () => onTap(id),
          ),

          Container(
            width: _nameWidth,
            height: _nameHeight,
            // margin: EdgeInsets.symmetric(horizontal: _nameWidth * 0.2),
            child: SuperVerse(
              verse: TextMod.trimTextAfterFirstSpecialCharacter(name, ' '),
              size: 1,
              scaleFactor: 1,
              centered: true,
              weight: VerseWeight.thin,
              maxLines: 1,
              shadow: true,
            ),
          ),

        ],
      ),
    );
  }
}
