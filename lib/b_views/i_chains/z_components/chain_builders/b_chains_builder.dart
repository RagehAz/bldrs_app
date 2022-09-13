import 'package:bldrs/b_views/i_chains/z_components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsBuilder({
    @required this.sons,
    @required this.previousPath,
    @required this.width,
    @required this.level,
    @required this.onPhidTap,
    @required this.selectedPhids,
    @required this.initiallyExpanded,
    @required this.onAddToPath,
    @required this.secondLinesType,
    @required this.onLongPress,
    this.searchText,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic sons;
  final String previousPath;
  final double width;
  final int level;
  final Function(String path, String phid) onPhidTap;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<String> searchText;
  final Function(String path) onAddToPath;
  final ChainSecondLinesType secondLinesType;
  final ValueChanged<String> onLongPress;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _sonWidth = ChainButtonBox.getSonWidth(
      parentWidth: width,
      level: level,
    );

    return SizedBox(
      key: const ValueKey<String>('ChainSonsBuilder'),
      width: width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: Ratioz.appBarPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            ...List.generate(sons?.length ?? 0, (index){

              final dynamic son = sons[index];

              return Container(
                width: _sonWidth,
                margin: const EdgeInsets.only(
                  bottom: Ratioz.appBarPadding,
                  left: Ratioz.appBarPadding,
                  right: Ratioz.appBarPadding,
                ),
                child: ChainSplitter(
                  previousPath: previousPath,
                  chainOrChainsOrSonOrSons: son,
                  width: _sonWidth,
                  onSelectPhid: onPhidTap,
                  selectedPhids: selectedPhids,
                  initiallyExpanded: initiallyExpanded,
                  level: level+1,
                  searchText: searchText,
                  onAddToPath: onAddToPath,
                  secondLinesType: secondLinesType,
                  editMode: true,
                  onLongPress: onLongPress,
                ),
              );

            }),

            if (onAddToPath != null)
            DreamBox(
              height: 60,
              width: _sonWidth,
              verse: const Verse(text: 'Add to path :', translate: false),
              secondLine: Verse(text: '$previousPath/...', translate: false),
              icon: Iconz.plus,
              iconSizeFactor: 0.5,
              verseScaleFactor: 1.2,
              secondLineScaleFactor: 1.1,
              secondLineColor: Colorz.black255,
              secondVerseMaxLines: 2,
              verseCentered: false,
              verseColor: Colorz.black255,
              color: Colorz.yellow255,
              margins: const EdgeInsets.only(
                bottom: Ratioz.appBarPadding,
                left: Ratioz.appBarPadding,
                right: Ratioz.appBarPadding,
              ),
              onTap: () => onAddToPath(previousPath),
            ),

          ],
        ),

      ),

    );

  }
  // -----------------------------------------------------------------------------
}
