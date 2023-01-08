import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class PhidsViewer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsViewer({
    @required this.phids,
    @required this.pageWidth,
    @required this.onPhidTap,
    @required this.onPhidLongTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> phids;
  final double pageWidth;
  final Function(String phid) onPhidTap;
  final Function(String phid) onPhidLongTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
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

          if (phids?.isNotEmpty)
          ...List<Widget>.generate(phids?.length, (int index) {

            final String _phid = phids[index];

            return PhidButton(
              phid: _phid,
              color: Colorz.white50,
              inverseAlignment: false,
              onPhidTap: () => onPhidTap(_phid),
              onPhidLongTap: () => onPhidLongTap(_phid),
            );
          }
          ),

        ],
      ),
    );
  }
/// --------------------------------------------------------------------------
}
