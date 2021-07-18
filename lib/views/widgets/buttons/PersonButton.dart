import 'package:bldrs/controllers/drafters/borderers.dart';
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

    double _imageHeight = totalHeight / 1.6 ;
    double _imageWidth = _imageHeight;

    double _nameHeight = totalHeight - _imageHeight;
    double _nameWidth = totalHeight * 0.9;

    return Container(
      width: _nameWidth,
      height: _imageHeight,
      // margin: EdgeInsets.symmetric(horizontal: _imageWidth * 0.0),
      // decoration: BoxDecoration(
      //   color: Colorz.Black125,
      //   borderRadius: Borderers.superBorderAll(context, _imageWidth * 0.25),
      // ),
      child: Column(
        children: <Widget>[

          ///
          DreamBox(
            height: _imageHeight,
            width: _imageWidth,
            icon: image,
            underLine: name,
            underLineShadowIsOn: true,
            iconRounded: false,
            onTap: () => onTap(id),
          ),

          Container(
            width: _nameWidth,
            height: _nameHeight,
            // margin: EdgeInsets.symmetric(horizontal: _nameWidth * 0.2),
            child: SuperVerse(
              verse: name,
              size: 1,
              scaleFactor: 0.95,
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
