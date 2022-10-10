import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class NoteTriggerCreator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteTriggerCreator({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return const TileBubble(
      bubbleHeaderVM: BubbleHeaderVM(
        headlineVerse: Verse(
          text: 'Trigger',
          translate: false,
        ),
        leadingIcon: Iconz.trigger,
        // leadingIconSizeFactor: 1,
        // leadingIconBoxColor: note.sendFCM == true ? Colorz.green255 : Colorz.grey50,
         ),
    );

  }
  /// --------------------------------------------------------------------------
}
