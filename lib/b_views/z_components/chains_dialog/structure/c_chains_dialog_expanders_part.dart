import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/structure/d_chain_view_browsing.dart';
import 'package:bldrs/b_views/z_components/chains_dialog/structure/e_chain_view_searching.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:flutter/material.dart';

class ChainsDialogExpandersPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsDialogExpandersPart({
    @required this.drawerWidth,
    @required this.isSearching,
    @required this.bubbleWidth,
    @required this.foundChains,
    @required this.foundPhids,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double drawerWidth;
  final double bubbleWidth;
  final ValueNotifier<bool> isSearching;
  final ValueNotifier<List<String>> foundPhids;
  final ValueNotifier<List<Chain>> foundChains;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: SizedBox(
        width: drawerWidth,
        // height: _drawerHeight - Ratioz.appBarButtonSize - ((Ratioz.appBarMargin + Ratioz.appBarPadding) * 2),
        child: ValueListenableBuilder(
          valueListenable: isSearching,
          builder: (_, bool _isSearching, Widget child){

            return ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[


                /// SEARCHING MODE
                if (_isSearching == true)
                  ChainViewSearching(
                    boxWidth: bubbleWidth,
                    foundChains: foundChains,
                    foundPhids: foundPhids,
                  ),

                /// BROWSING MODE
                if (_isSearching == false)
                  ChainViewBrowsing(
                    width: bubbleWidth,
                  ),

                const Horizon(
                  heightFactor: 4,
                ),

              ],
            );

          },
        ),
      ),
    );
  }
}
