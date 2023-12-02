import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:flutter/material.dart';

class PhidsWrapper extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsWrapper({
    required this.phids,
    required this.pageWidth,
    required this.onPhidTap,
    required this.onPhidLongTap,
    this.margins = EdgeInsets.zero,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<String> phids;
  final double pageWidth;
  final Function(String phid)? onPhidTap;
  final Function(String phid)? onPhidLongTap;
  final EdgeInsets margins;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: margins,
      child: Wrap(
        key: const ValueKey<String>('InfoPageKeywords'),
        runSpacing: Ratioz.appBarPadding,
        spacing: Ratioz.appBarPadding,
        // direction: Axis.vertical,
        // verticalDirection: VerticalDirection.down,
        // alignment: WrapAlignment.center,
        // crossAxisAlignment: WrapCrossAlignment.center,
        // runAlignment: WrapAlignment.center,
        // alignment: WrapAlignment.spaceAround,
        children: <Widget>[

          if (Mapper.checkCanLoopList(phids) == true)
          ...List<Widget>.generate(phids.length, (int index) {

            final String _phid = phids[index];

            return PhidButton(
              phid: _phid,
              color: Colorz.white50,
              inverseAlignment: false,
              onPhidTap: onPhidTap == null ? null : () => onPhidTap!(_phid),
              onPhidLongTap: onPhidLongTap == null ? null : () => onPhidLongTap!(_phid),
            );
          }
          ),

        ],
      ),
    );
  }
/// --------------------------------------------------------------------------
}
