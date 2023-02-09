import 'dart:io';

import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/texting/customs/stats_line.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/lib/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';

class StatsFilesBuilder extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const StatsFilesBuilder({
    @required this.stats,
    @required this.color,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final List<FileStat> stats;
  final Color color;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        if (Mapper.checkCanLoopList(stats) == true)
          ...List.generate(stats.length, (index){

            final FileStat _stat = stats[index];
            final String type = _stat.type.toString();
            // ---
            final int size = _stat.size;
            final double _sizeMB = Filers.calculateSize(size, FileSizeUnit.kiloByte);
            final String _sizeString = Numeric.formatNumToSeparatedKilos(number: _sizeMB);
            // ---
            final String _accessed = Timers.generateString_hh_i_mm_i_ss(_stat.accessed);
            final String _changed = Timers.generateString_hh_i_mm_i_ss(_stat.changed);
            final String _modified = Timers.generateString_hh_i_mm_i_ss(_stat.modified);
            // ---
            final int _mode = _stat.mode;
            final String _modeString = _stat.modeString();
            // ---
            final double _clearWidth = Bubble.clearWidth(context: context);
            // ---
            return Bubble(
              bubbleHeaderVM: BldrsBubbleHeaderVM.bake(),
              columnChildren: <Widget>[

                /// TYPE
                StatsLine(
                  icon: Iconz.circleDot,
                  verse: Verse.plain('type : $type : modeString : $_modeString'),
                  color: color,
                ),

                /// size
                StatsLine(
                  icon: Iconz.circleDot,
                  verse: Verse.plain('Size : $_sizeString Kb : mode : $_mode'),
                  color: color,
                ),

                /// ACCESSED
                StatsLine(
                  bubbleWidth: _clearWidth,
                  icon: Iconz.circleDot,
                  verse: Verse.plain('Accesses : $_accessed'),
                  color: color,
                ),

                /// CHANGED
                StatsLine(
                    bubbleWidth: _clearWidth,
                    icon: Iconz.circleDot,
                    verse: Verse.plain('Changed : $_changed'),
                  color: color,
                ),

                /// MODIFIED
                StatsLine(
                  bubbleWidth: _clearWidth,
                  icon: Iconz.circleDot,
                  verse: Verse.plain('Modified : $_modified'),
                  color: color,
                ),

              ],
            );

          }),

      ],
    );
  }
}
