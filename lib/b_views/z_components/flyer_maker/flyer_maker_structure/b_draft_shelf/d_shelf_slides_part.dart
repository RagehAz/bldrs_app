import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/c_shelf_header_part.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ShelfSlidesPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShelfSlidesPart({
    @required this.slideZoneHeight,
    @required this.scrollController,
    @required this.mutableSlides,
    @required this.flyerHeaderController,
    @required this.onSlideTap,
    @required this.onAddNewSlides,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double slideZoneHeight;
  final ScrollController scrollController;
  final List<MutableSlide> mutableSlides;
  final TextEditingController flyerHeaderController;
  final ValueChanged<MutableSlide> onSlideTap;
  final Function onAddNewSlides;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('ShelfSlidesPart'),
      width: Scale.superScreenWidth(context),
      height: slideZoneHeight,
      child: ListView.builder(
        controller: scrollController,
        itemCount: mutableSlides.length + 2,
        scrollDirection: Axis.horizontal,
        itemExtent: ShelfSlide.flyerBoxWidth,
        physics: const BouncingScrollPhysics(),
        padding: Scale.superInsets(
          context: context,
          enRight: ShelfSlide.flyerBoxWidth * 0.5,
        ),
        itemBuilder: (ctx, index){

          final bool _atLastIndex = index == mutableSlides.length + 1;
          final bool _atPreLastIndex = index == mutableSlides.length;

          /// PRE LAST INDEX : ADD SLIDE BUTTON
          if (_atPreLastIndex == true){
            return ShelfSlide(
                mutableSlide: null,
                headline: null,
                number: index + 1,
                onTap: onAddNewSlides,
            );
          }

          /// AT LAST INDEX : SHELF BUTTONS
          else if (_atLastIndex == true){

            const double _buttonWidth = ShelfSlide.flyerBoxWidth - (Ratioz.appBarPadding * 2);

            return Container(
              width: ShelfSlide.flyerBoxWidth,
              height: slideZoneHeight,
              // color: Colorz.bloodTest,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  /// UPPER PADDING
                  const SizedBox(
                    width: _buttonWidth,
                    height: ShelfHeaderPart.shelfNumberZoneHeight + Ratioz.appBarPadding,
                  ),

                  /// DELETE
                  DreamBox(
                    verse: 'DELETE',
                    height: 50,
                    iconSizeFactor: 0.5,
                    verseWeight: VerseWeight.black,
                    width: _buttonWidth,
                    onTap: (){},
                    verseItalic: true,
                    icon: Iconz.xSmall,
                    // color: Colorz.green255,
                    verseCentered: false,
                    margins: const EdgeInsets.only(top: Ratioz.appBarPadding),
                  ),

                  /// SAVE
                  DreamBox(
                    verse: 'SAVE',
                    height: 50,
                    iconSizeFactor: 0.5,
                    verseWeight: VerseWeight.black,
                    width: _buttonWidth,
                    onTap: (){},
                    verseItalic: true,
                    icon: Iconz.terms,
                    // color: Colorz.green255,
                    verseCentered: false,
                    margins: const EdgeInsets.only(top: Ratioz.appBarPadding),
                  ),

                  const Expander(),

                  /// VIEW
                  DreamBox(
                    verse: 'VIEW',
                    height: 50,
                    iconSizeFactor: 0.5,
                    verseWeight: VerseWeight.black,
                    width: _buttonWidth,
                    onTap: (){},
                    verseItalic: true,
                    icon: Iconz.viewsIcon,
                    color: Colorz.yellow255,
                    verseColor: Colorz.black255,
                    iconColor: Colorz.black255,
                    verseCentered: false,
                    margins: const EdgeInsets.only(top: Ratioz.appBarPadding),
                  ),

                  /// PUBLISH
                  DreamBox(
                    verse: 'PUBLISH',
                    height: 50,
                    iconSizeFactor: 0.5,
                    verseWeight: VerseWeight.black,
                    width: _buttonWidth,
                    onTap: (){},
                    verseItalic: true,
                    icon: Iconz.plus,
                    color: Colorz.green255,
                    verseCentered: false,
                    margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
                  ),

                ],
              ),
            );
          }

          /// AT SLIDES INDEXES : SLIDES
          else {

            final MutableSlide _mutableSlide = mutableSlides[index];
            final bool _hasSlides = mutableSlides.isNotEmpty;

            return ShelfSlide(
                mutableSlide: _mutableSlide,
                headline: _hasSlides && index == 0 ? flyerHeaderController : null,
                number: index + 1,
                onTap: () => onSlideTap(_mutableSlide),
          );
          }

        },
      ),

    );
  }
}
