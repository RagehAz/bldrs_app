import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BldrsIconsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BldrsIconsScreen({
    this.multipleSelection = false,
    Key key
  }) : super(key: key);

  final bool multipleSelection;
  /// --------------------------------------------------------------------------
  @override
  State<BldrsIconsScreen> createState() => _BldrsIconsScreenState();
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> selectIcon(BuildContext context) async {

    final String _icon = await Nav.goToNewScreen(
        context: context,
        screen: const BldrsIconsScreen(),
    );

    return _icon;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> selectIcons(BuildContext context) async {

    final List<String> _icons = await Nav.goToNewScreen(
      context: context,
      screen: const BldrsIconsScreen(
        multipleSelection: true,
      ),
    );

    return _icons;


  }
  /// --------------------------------------------------------------------------
}

class _BldrsIconsScreenState extends State<BldrsIconsScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<String>> _found = ValueNotifier(<String>[]);
  final ValueNotifier<String> _textHighlight = ValueNotifier(null);
  List<String> _icons;
  final ValueNotifier<List<String>> _selected = ValueNotifier(<String>[]);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _icons = UiProvider.proGetLocalAssetsPaths(context);
  }
  // --------------------
  @override
  void dispose() {
    _isSearching.dispose();
    _found.dispose();
    _textHighlight.dispose();
    _selected.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  Future<void> _onIconTap(String icon) async {

    if (widget.multipleSelection == true){
      _selected.value = Stringer.addOrRemoveStringToStrings(
          strings: _selected.value,
          string: icon
      );
    }

    else {
      await Nav.goBack(
        context: context,
        invoker: 'BldrsIconsScreen.goBack',
        passedData: icon,
      );
    }


    // await BottomDialog.showButtonsBottomDialog(
    //   context: context,
    //   draggable: true,
    //   numberOfWidgets: 1,
    //   builder: (_){
    //     return <Widget>[
    //
    //       /// SELECT
    //       BottomDialog.wideButton(
    //           context: context,
    //           verse: const Verse(
    //             text: 'Select',
    //             translate: false,
    //             casing: Casing.upperCase,
    //           ),
    //         onTap: () async {
    //
    //             await Nav.goBack(context: context, invoker: 'BldrsIconsScreen.closeDialog');
    //
    //             if (widget.multipleSelection == true){
    //               _selected.value = Stringer.addOrRemoveStringToStrings(
    //                   strings: _selected.value,
    //                   string: icon
    //               );
    //             }
    //
    //             else {
    //
    //               await Nav.goBack(
    //                 context: context,
    //                 invoker: 'BldrsIconsScreen.goBack',
    //                 passedData: icon,
    //               );
    //
    //             }
    //
    //
    //         }
    //       ),
    //
    //     ];
    //   }
    // );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      pageTitleVerse: Verse.plain('UI Manager'),
      appBarType: AppBarType.search,
      onSearchChanged: _onSearchChanged,
      onBack: widget.multipleSelection == false ? null : () async {

        await Nav.goBack(
          context: context,
          invoker: 'BldrsIconsScreen.goBack',
          passedData: _selected.value,
        );

      },
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
                      selectedIcons: _selected,
                      onTap: _onIconTap,
                    );

                  }
              );

            }

            else {

              return IconsGridBuilder(
                icons: _icons,
                selectedIcons: _selected,
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
    @required this.selectedIcons,
    this.textHighlight,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final List<String> icons;
  final ValueNotifier<String> textHighlight;
  final ValueChanged<String> onTap;
  final ValueNotifier<List<String>> selectedIcons;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _gridSpacing = Ratioz.appBarMargin;

    const int _numberOfIconsInARow = 5;

    final double _iconBoxSize = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: _numberOfIconsInARow,
      boxWidth: Scale.screenWidth(context),
    );

    final SliverGridDelegate _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1.25,
      mainAxisExtent: _iconBoxSize * 1.25,
      crossAxisCount: _numberOfIconsInARow,
    );

    return ValueListenableBuilder(
        valueListenable: selectedIcons,
        builder: (_, List<String> selected, Widget child){

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

            final String icon = icons[index];
            final bool _isSelected = Stringer.checkStringsContainString(
                strings: selected,
                string: icon,
            );

            return Container(
              color: _isSelected == true ? Colorz.green255 : Colorz.white10,
              child: Column(
                children: <Widget>[

                  DreamBox(
                    height: _iconBoxSize,
                    width: _iconBoxSize,
                    icon: icon,
                    iconSizeFactor: 0.9,
                    // corners: 0,
                    // color: Colorz.bloodTest,
                    bubble: false,
                    onTap: () => onTap(icons[index]),
                  ),

                  SizedBox(
                    width: _iconBoxSize,
                    height: _iconBoxSize * 0.25,
                    // color: Colorz.white20,
                    child: SuperVerse(
                      verse: Verse.plain(TextMod.removeTextBeforeLastSpecialCharacter(icon, '/')),
                      weight: VerseWeight.thin,
                      scaleFactor: 0.7,
                      maxLines: 2,
                      highlight: textHighlight,
                    ),
                  ),

                ],
              ),
            );
          });

    });

  }
  // -----------------------------------------------------------------------------
}
