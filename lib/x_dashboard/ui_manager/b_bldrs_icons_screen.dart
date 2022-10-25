import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BldrsIconsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsIconsScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<BldrsIconsScreen> createState() => _BldrsIconsScreenState();
  /// --------------------------------------------------------------------------
  static Future<String> selectIcon(BuildContext context) async {

    final String _icon = await Nav.goToNewScreen(
        context: context,
        screen: const BldrsIconsScreen(),
    );

    return _icon;
  }
  /// --------------------------------------------------------------------------
}

class _BldrsIconsScreenState extends State<BldrsIconsScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<String>> _found = ValueNotifier(<String>[]);
  final ValueNotifier<String> _textHighlight = ValueNotifier(null);
  List<String> _icons;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _icons = UiProvider.proGetLocalAssetsPaths(context);
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _isSearching.dispose();
    _found.dispose();
    _textHighlight.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onSearchChanged(String text) async {

    TextCheck.triggerIsSearchingNotifier(
        text: text,
        isSearching: _isSearching
    );

    if (_isSearching.value == true){

      final List<String> _foundIcons = <String>[];

      for (final String icon in _icons){
        final bool _contains = TextCheck.stringContainsSubString(
          subString: text,
          string: icon,
        );
        if (_contains == true){
          _foundIcons.add(icon);
        }
      }

      if (Mapper.checkCanLoopList(_foundIcons) == true){
        _found.value = _foundIcons;
        _textHighlight.value = text;
      }

    }

  }
  // --------------------
  Future<void> _onIconTap(String icon) async {

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 1,
      builder: (_){
        return <Widget>[

          /// SELECT
          BottomDialog.wideButton(
              context: context,
              verse: const Verse(
                text: 'Select',
                translate: false,
                casing: Casing.upperCase,
              ),
            onTap: () async {

                await Nav.goBack(context: context, invoker: 'BldrsIconsScreen.closeDialog');

                await Nav.goBack(
                    context: context,
                    invoker: 'BldrsIconsScreen.goBack',
                    passedData: icon,
                );

            }
          ),

        ];
      }
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      pageTitleVerse: Verse.plain('UI Manager'),
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
                      onTap: _onIconTap,
                    );

                  }
              );

            }

            else {

              return IconsGridBuilder(
                icons: _icons,
                onTap: _onIconTap,
              );

            }

          },
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

class IconsGridBuilder extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const IconsGridBuilder({
    @required this.icons,
    @required this.onTap,
    this.textHighlight,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final List<String> icons;
  final ValueNotifier<String> textHighlight;
  final ValueChanged<String> onTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _gridSpacing = Ratioz.appBarMargin;

    const int _numberOfIconsInARow = 5;

    final double _iconBoxSize = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: _numberOfIconsInARow,
      boxWidth: Scale.superScreenWidth(context),
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
                onTap: () => onTap(icons[index]),
              ),

              Container(
                width: _iconBoxSize,
                height: _iconBoxSize * 0.25,
                color: Colorz.white20,
                child: SuperVerse(
                  verse: Verse.plain(TextMod.removeTextBeforeLastSpecialCharacter(icons[index], '/')),
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
  // -----------------------------------------------------------------------------
}
