import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/nav_bar/nav_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class NanoBzLogo extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NanoBzLogo({
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: NavBar.circleWidth * 0.47,
      width: NavBar.circleWidth * 0.47,
      child: DreamBox(
        height: NavBar.circleWidth * 0.47,
        width: NavBar.circleWidth * 0.47,
        corners: NavBar.circleWidth * 0.47 * 0.25,
        icon: bzModel.logo,
      ),
    );

  }
}

class NanoBzLogos extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NanoBzLogos({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: true);

    const double _circleWidth = NavBar.circleWidth;
    const double _buttonCircleCorner = _circleWidth * 0.5;
    const bool _shadowIsOn = true;

    return Container(
        width: _circleWidth,
        height: _circleWidth,
        alignment: Alignment.center,
        child:

        _myBzz.length == 1 ?
        DreamBox(
          width: _circleWidth,
          height: _circleWidth,
          icon: _myBzz[0].logo,
          corners: _buttonCircleCorner,
        )

            :

        _myBzz.length == 2 ?
        Stack(
          children: <Widget>[

            Positioned(
              top: 0,
              left: 0,
              child: BzLogo(
                width: _circleWidth * 0.7,
                image: _myBzz[0].logo,
                shadowIsOn: _shadowIsOn,
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: BzLogo(
                width: _circleWidth * 0.7,
                image: _myBzz[1].logo,
                shadowIsOn: _shadowIsOn,
              ),
            ),

          ],
        )

            :

        _myBzz.length == 3 ?
        SizedBox(
          width: _circleWidth,
          height: _circleWidth,
          // color: Colorz.Grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  NanoBzLogo(bzModel: _myBzz[0]),
                  NanoBzLogo(bzModel: _myBzz[1]),
                ],
              ),


              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  NanoBzLogo(bzModel: _myBzz[2]),

                  Container(
                    width: _circleWidth * 0.47,
                    height: _circleWidth * 0.47,
                    color: Colorz.nothing,
                  ),
                ],
              ),
            ],
          ),
        )

            :

        _myBzz.length == 4 ?
        Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                NanoBzLogo(bzModel: _myBzz[0]),
                NanoBzLogo(bzModel: _myBzz[1]),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NanoBzLogo(bzModel: _myBzz[2]),
                NanoBzLogo(bzModel: _myBzz[3]),
              ],
            ),
          ],
        )

            :

        Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NanoBzLogo(bzModel: _myBzz[0]),
                NanoBzLogo(bzModel: _myBzz[1]),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                NanoBzLogo(bzModel: _myBzz[2]),

                DreamBox(
                  height: _circleWidth * 0.47,
                  width: _circleWidth * 0.47,
                  verse: '+${_myBzz.length - 3}',
                  verseWeight: VerseWeight.thin,
                  verseScaleFactor: 0.35,
                  bubble: false,
                ),

              ],
            ),

          ],
        )

    );

  }

}
