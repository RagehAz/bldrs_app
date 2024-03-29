import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/drawing/spacing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/h_navigation/mirage/mirage.dart';
import 'package:bldrs/z_components/active_phids_selector/phid_button_clone.dart';
import 'package:bldrs/z_components/buttons/keywords_buttons/f_phid_button.dart';
import 'package:basics/components/layers/blur_layer.dart';
import 'package:basics/components/animators/auto_scrolling_bar.dart';
import 'package:bldrs/z_components/layouts/layout_visibility_listener.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class LiveActivePhidSelector extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LiveActivePhidSelector({
    required this.mounted,
    required this.scrollController,
    required this.activePhid,
    required this.onlyShowPublished,
    required this.bzModel,
    required this.hasExtraHeight,
    this.onPhidTap,
    this.appBarType = AppBarType.basic,
    super.key
  });
  // -----------------------------------------------------------------------------
  final bool mounted;
  final ScrollController scrollController;
  final BzModel? bzModel;
  final ValueNotifier<String?> activePhid;
  final bool onlyShowPublished;
  final AppBarType appBarType;
  final Function(String? phid)? onPhidTap;
  final bool hasExtraHeight;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double barHeight = Stratosphere.getStratosphereValue(
      context: context,
      appBarType: appBarType,
    ) + BldrsAppBar.clearLineHeight(context) + 5;

    return AutoScrollingBar(
      key: const ValueKey<String>('the_auto_scroll_phid_selector'),
      scrollController: scrollController,
      // height: appBarType == AppBarType.non ? Stratosphere.smallAppBarStratosphere
      //     :
      // appBarType == AppBarType.search ? Stratosphere.bigAppBarStratosphere + Stratosphere.smallAppBarStratosphere
      //     :
      // Stratosphere.bigAppBarStratosphere,
      height: barHeight,
      child: LayoutVisibilityListener(
        isOn: true,
        child: ActivePhidSelector(
          hasExtraHeight: hasExtraHeight,
          bzModel: bzModel,
          mounted: mounted,
          activePhid: activePhid,
          onlyShowPublished: onlyShowPublished,
          onPhidTap: onPhidTap,
          appBarType: appBarType,
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}

class ActivePhidSelector extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ActivePhidSelector({
    required this.activePhid,
    required this.bzModel,
    required this.mounted,
    required this.hasExtraHeight,
    required this.onlyShowPublished,
    this.appBarType = AppBarType.non,
    this.buttonHeight,
    this.onPhidTap,
    super.key
  });
  // --------------------
  final ValueNotifier<String?> activePhid;
  final BzModel? bzModel;
  final bool mounted;
  final AppBarType appBarType;
  final bool onlyShowPublished;
  final double? buttonHeight;
  final Function(String? phid)? onPhidTap;
  final bool hasExtraHeight;
  // --------------------------------------------------------------------------
  static void onSelectActivePhid({
    required String? phid,
    required ValueNotifier<String?> activePhid,
    required bool mounted,
  }){

    setNotifier(
      notifier: activePhid,
      mounted: mounted,
      value: phid,
    );



  }
  // --------------------
  static List<Widget> getButtons({
    required bool onlyShowPublished,
    required BzModel? bzModel,
    required String? activePhid,
    required Function(String? phid) onPhidTap,
    double? buttonHeight,
    Color? selectedButtonColor,
    Color? buttonColor,
  }){

    final double _buttonHeight = buttonHeight ?? PhidButton.getHeight();

    final List<String> _phids = ScopeModel.getBzFlyersPhids(
      bzModel: bzModel,
      onlyShowPublished: onlyShowPublished,
    );

    final Color _buttonColor = buttonColor ?? Colorz.white20;
    final Color _selectedButtonColor = selectedButtonColor ?? Colorz.yellow125;

    return <Widget>[

      const Spacing(),

      /// ALL
      PhidButtonClone(
        height: _buttonHeight,
        verse: const Verse(id: 'phid_all', translate: true,),
        icon: Iconz.flyerCollection,
        isSelected: activePhid == null,
        buttonColor: _buttonColor,
        selectedButtonColor: _selectedButtonColor,
        onTap: () => onPhidTap(null),
      ),

      /// PENDING
      if (
          onlyShowPublished == false
          &&
          Lister.checkCanLoop(bzModel?.publication.pendings) == true
      )
        Builder(
            builder: (context) {

              final String _phid = PublicationModel.getPublishStatePhid(PublishState.pending)!;

              return PhidButtonClone(
                verse: Verse(
                  id: _phid,
                  translate: true,
                ),
                isSelected: activePhid == _phid,
                buttonColor: _buttonColor,
                selectedButtonColor: _selectedButtonColor,
                onTap: () => onPhidTap(_phid),
              );
            }
        ),

      /// SCOPES
      if (Lister.checkCanLoop(_phids) == true)...List.generate(_phids.length, (index){

        final String? _phid = bzModel?.scopes?.map.keys.toList()[index];

        final bool _isSelected = _phid == activePhid;

        return PhidButton(
          phid: _phid,
          height: _buttonHeight,
          color: _isSelected == true ? _selectedButtonColor : _buttonColor,
          verseColor: MirageButton.getVerseColor(isDisabled: false, isSelected: _isSelected),
          margins: Scale.superInsets(
            context: getMainContext(),
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            enRight: 5,
          ),
          onPhidTap: () => onPhidTap(_phid),
        );

      }),

      /// SUSPENDED
      if (
          onlyShowPublished == false
          &&
          Lister.checkCanLoop(bzModel?.publication.suspended) == true
      )
        Builder(
            builder: (context) {

              final String _phid = PublicationModel.getPublishStatePhid(PublishState.suspended)!;

              return PhidButtonClone(
                height: _buttonHeight,
                verse: Verse(
                  id: _phid,
                  translate: true,
                ),
                isSelected: activePhid == _phid,
                buttonColor: _buttonColor,
                selectedButtonColor: _selectedButtonColor,
                onTap: () => onPhidTap(_phid),
              );
            }
        ),

      const Spacing(),

    ];

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _buttonHeight = buttonHeight ?? PhidButton.getHeight();
    // final double barHeight = stratosphere == true ?
    // Stratosphere.bigAppBarStratosphere
    //     :
    // _buttonHeight + 5;

    final double _extraHeight = hasExtraHeight ? BldrsAppBar.clearLineHeight(context) + 5 : 20;
    final double barHeight = Stratosphere.getStratosphereValue(
        context: context,
        appBarType: appBarType,
    ) + _extraHeight;
    // --------------------
    return BlurLayer(
      width: _screenWidth,
      height: barHeight,
      color: Colorz.black125,
      blurIsOn: true,
      child: ValueListenableBuilder(
          valueListenable: activePhid,
          builder: (_, String? thePhid, Widget? child) {

            return FloatingList(
              width: _screenWidth,
              scrollDirection: Axis.horizontal,
              boxAlignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(
                bottom: 5,
                left: 10,
                right: 10,
              ),
              columnChildren: <Widget>[

                ...getButtons(
                  bzModel: bzModel,
                  activePhid: thePhid,
                  onlyShowPublished: onlyShowPublished,
                  onPhidTap: (String? phid) {

                    onSelectActivePhid(
                      mounted: mounted,
                      activePhid: activePhid,
                      phid: phid,
                    );

                    onPhidTap?.call(phid);

                  },
                  buttonHeight: _buttonHeight,
                ),

              ],
            );
          }
          ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
