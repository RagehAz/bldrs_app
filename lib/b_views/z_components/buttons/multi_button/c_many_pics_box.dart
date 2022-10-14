import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/d_micro_pic.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ManyPicsBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ManyPicsBox({
    @required this.pics,
    @required this.size,
    Key key
  }) : super(key: key);

  final List<String> pics;
  final double size;
  /// --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    if (pics != null && pics.length >= 3){

      final double _size = size * 0.47;

      return SizedBox(
        width: size,
        height: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                MicroPic(
                  size: _size,
                  pic: pics[0],
                ),

                const Expander(),

                MicroPic(
                  size: _size,
                  pic: pics[1],
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                MicroPic(
                  size: _size,
                  pic: pics[2],
                ),

                const Expander(),

                if (pics.length == 3)
                  Container(
                    width: _size,
                    height: _size,
                    color: Colorz.nothing,
                  ),

                if (pics.length == 4)
                  MicroPic(
                    size: _size,
                    pic: pics[3],
                  ),

                if (pics.length > 4)
                  DreamBox(
                    height: _size,
                    width: _size,
                    verse: Verse.plain('+${pics.length - 3}'),
                    verseWeight: VerseWeight.thin,
                    verseScaleFactor: 0.35,
                    bubble: false,
                  ),

              ],
            ),

          ],
        ),
      );

    }

    else {
      return const SizedBox();
    }


  }
}