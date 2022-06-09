import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/nav_bar/bzz_button/e_nano_bz_logo.dart';
import 'package:bldrs/b_views/z_components/nav_bar/components/note_red_dot.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ManyBzzButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ManyBzzButton({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            NanoBzLogo(
              bzModel: _myBzz[0],
            ),

            const Expander(),

            NanoBzLogo(
              bzModel: _myBzz[1],
            ),

          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            NanoBzLogo(
              bzModel: _myBzz[2],
            ),

            const Expander(),

            if (_myBzz.length == 3)
              Container(
                width: NanoBzLogo.size,
                height: NanoBzLogo.size,
                color: Colorz.nothing,
              ),

            if (_myBzz.length == 4)
              NanoBzLogo(
                bzModel: _myBzz[3],
              ),

            if (_myBzz.length > 4)
              NoteRedDotWrapper(
                redDotIsOn: true,
                count: 0,
                shrinkChild: true,
                isNano: true,
                childWidth: NanoBzLogo.size,
                child: DreamBox(
                  height: NanoBzLogo.size,
                  width: NanoBzLogo.size,
                  verse: '+${_myBzz.length - 3}',
                  verseWeight: VerseWeight.thin,
                  verseScaleFactor: 0.35,
                  bubble: false,
                ),
              ),

          ],
        ),

      ],
    );

  }
}
