import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/z_components/buttons/keywords_buttons/f_phid_button.dart';
import 'package:flutter/material.dart';

class PhidsWrapper extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsWrapper({
    required this.phids,
    required this.width,
    required this.onPhidTap,
    required this.onPhidLongTap,
    this.margins = EdgeInsets.zero,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<String> phids;
  final double width;
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

          if (Lister.checkCanLoop(phids) == true)
          ...List<Widget>.generate(phids.length, (int index) {

            final String _phid = phids[index];

            return PhidButton(
              maxWidth: width - 20,
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
