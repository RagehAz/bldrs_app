import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/colors/colorizer.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_back_end/h_caching/cache_ops.dart';
import 'package:flutter/material.dart';

class CachePreviewBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CachePreviewBubble({
    this.verse,
    super.key
  });
  // --------------------
  final Verse? verse;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _stripWidth = Bubble.clearWidth(context: context);
    const double _stripHeight = 30;
    // --------------------
    return Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: Verse.plain('Caches'),
          hasMoreButton: true,
          moreButtonIcon: Iconz.power,
          onMoreButtonTap: () async {

            final bool _go = await Dialogs.bottomBoolDialog(
              titleVerse: Verse.plain('Wipe Caches ?'),
            );

            if (_go == true){
              await CacheOps.wipeCaches();
            }

          },
        ),
      bubbleColor: Colorizer.createRandomColor(),
      columnChildren: <Widget>[

        /// CURRENT SIZE
        DataStrip(
          width: _stripWidth,
          height: _stripHeight,
          dataKey: 'current Size',
          dataValue: '${imageCache.currentSize} ',
          color: Colorz.yellow20,
        ),

        /// CURRENT SIZE BYTES
        DataStrip(
          width: _stripWidth,
          height: _stripHeight,
          dataKey: 'current Size Bytes',
          dataValue: '${FileSizer.calculateSize(imageCache.currentSizeBytes, FileSizeUnit.megaByte)} Mb',
          color: Colorz.yellow20,
        ),

        /// LIVE IMAGE COUNT
        DataStrip(
          width: _stripWidth,
          height: _stripHeight,
          dataKey: 'liveImageCount',
          dataValue: '${imageCache.liveImageCount} ',
          color: Colorz.yellow20,
        ),

        /// PENDING IMAGE COUNT
        DataStrip(
          width: _stripWidth,
          height: _stripHeight,
          dataKey: 'pendingImageCount',
          dataValue: '${imageCache.pendingImageCount} ',
          color: Colorz.yellow20,
        ),

        BldrsText(
          verse: verse,
          maxLines: 20,
          centered: false,
          size: 1,
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
