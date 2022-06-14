import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class IconsViewerScreen extends StatefulWidget {

  const IconsViewerScreen({
    Key key
  }) : super(key: key);

  @override
  State<IconsViewerScreen> createState() => _IconsViewerScreenState();
}

class _IconsViewerScreenState extends State<IconsViewerScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<String>> _found = ValueNotifier(<String>[]);
  final ValueNotifier<String> _textHighlight = ValueNotifier(null);
  List<String> _icons;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _icons = UiProvider.proGetLocalAssetsPaths(context);
    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchChanged(String text) async {

    triggerIsSearchingNotifier(
        text: text,
        isSearching: _isSearching
    );

    if (_isSearching.value == true){

      final List<String> _foundIcons = <String>[];

      for (final String icon in _icons){
        final bool _contains = stringContainsSubString(
          subString: text,
          string: icon,
        );
        if (_contains == true){
          _foundIcons.add(icon);
        }
      }

      if (checkCanLoopList(_foundIcons) == true){
        _found.value = _foundIcons;
        _textHighlight.value = text;
      }

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: 'UI Manager',
      appBarType: AppBarType.search,
      onSearchChanged: _onSearchChanged,
      layoutWidget: Scroller(


        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (_, bool searching, Widget child){

            if (searching == true){

              return ValueListenableBuilder(
                  valueListenable: _found,
                  builder: (_, List<String> found, Widget child){

                    return IconsGridBuilder(
                      icons: found,
                      textHighlight: _textHighlight,
                    );

                  }
              );

            }

            else {

              return IconsGridBuilder(
                icons: _icons,
              );

            }

          },
        ),
      ),
    );
  }
}

class IconsGridBuilder extends StatelessWidget {

  const IconsGridBuilder({
    @required this.icons,
    this.textHighlight,
    Key key
  }) : super(key: key);

  final List<String> icons;
  final ValueNotifier<String> textHighlight;

  @override
  Widget build(BuildContext context) {

    blog('fuck');

    const double _gridSpacing = Ratioz.appBarMargin;

    const int _numberOfIconsInARow = 3;

    final double _iconBoxSize = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: _numberOfIconsInARow,
    );

    final SliverGridDelegate _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1.25,
      mainAxisExtent: _iconBoxSize * 1.25,
      crossAxisCount: _numberOfIconsInARow,
    );

    return GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: Stratosphere.bigAppBarStratosphere,
          bottom: Ratioz.horizon,
          left: Ratioz.appBarMargin,
          right: Ratioz.appBarMargin,
        ),
        gridDelegate: _gridDelegate,
        itemCount: icons.length,
        itemBuilder: (BuildContext ctx, int index) {

          return Column(
            children: <Widget>[

              DreamBox(
                height: _iconBoxSize,
                width: _iconBoxSize,
                icon: icons[index],
                corners: 0,
                color: Colorz.bloodTest,
                bubble: false,
                onTap: () => Keyboarders.copyToClipboard(
                  context: context,
                  copy: icons[index],
                ),
              ),

              Container(
                width: _iconBoxSize,
                height: _iconBoxSize * 0.25,
                color: Colorz.white20,
                child: SuperVerse(
                  verse: TextMod.removeTextBeforeLastSpecialCharacter(icons[index], '/'),
                  weight: VerseWeight.thin,
                  scaleFactor: 0.7,
                  maxLines: 2,
                  highlight: textHighlight,
                ),
              ),

            ],
          );
        });

  }
}
