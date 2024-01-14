import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/b_views/f_bz/z_components/phid_button_clone.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:basics/helpers/widgets/layers/blur_layer.dart';
import 'package:bldrs/z_components/layouts/auto_scrolling_bar.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivePhidSelector extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ActivePhidSelector({
    required this.activePhid,
    required this.bzModel,
    required this.mounted,
    required this.onlyShowPublished,
    this.stratosphere = true,
    this.buttonHeight,
    super.key
  });
  // --------------------
  final ValueNotifier<String?> activePhid;
  final BzModel? bzModel;
  final bool mounted;
  final bool stratosphere;
  final bool onlyShowPublished;
  final double? buttonHeight;
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
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _buttonHeight = buttonHeight ?? PhidButton.getHeight();
    final double barHeight = stratosphere == true ?
    Stratosphere.bigAppBarStratosphere
        :
    _buttonHeight + 5;
    // --------------------
    final List<String> _phids = ScopeModel.getBzFlyersPhids(
      bzModel: bzModel,
      onlyShowPublished: onlyShowPublished,
    );
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

                /// ALL
                PhidButtonClone(
                  height: _buttonHeight,
                  verse: const Verse(id: 'phid_all', translate: true,),
                  icon: Iconz.flyerCollection,
                  isSelected: thePhid == null,
                  onTap: () => onSelectActivePhid(
                    mounted: mounted,
                    activePhid: activePhid,
                    phid: null,
                  ),
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
                      isSelected: thePhid == _phid,
                      onTap: () => onSelectActivePhid(
                        mounted: mounted,
                        activePhid: activePhid,
                        phid: _phid,
                      ),
                    );
                  }
                ),

                /// SCOPES
                if (Lister.checkCanLoop(_phids) == true)...List.generate(_phids.length, (index){

                  final String? _phid = bzModel?.scopes?.map.keys.toList()[index];

                  final bool _isSelected = _phid == thePhid;

                  return PhidButton(
                    phid: _phid,
                    height: _buttonHeight,
                    color: _isSelected == true ? Colorz.yellow125 : Colorz.white20,
                    margins: Scale.superInsets(
                      context: context,
                      appIsLTR: UiProvider.checkAppIsLeftToRight(),
                      enRight: 5,
                    ),
                    onPhidTap: () => onSelectActivePhid(
                      mounted: mounted,
                      activePhid: activePhid,
                      phid: _phid,
                    ),
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
                      isSelected: thePhid == _phid,
                      onTap: () => onSelectActivePhid(
                        mounted: mounted,
                        activePhid: activePhid,
                        phid: _phid,
                      ),
                    );
                  }
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

class LiveActivePhidSelector extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LiveActivePhidSelector({
    required this.mounted,
    required this.scrollController,
    required this.activePhid,
    required this.onlyShowPublished,
    required this.bzModel,
    super.key
  });
  // -----------------------------------------------------------------------------
  final bool mounted;
  final ScrollController scrollController;
  final BzModel? bzModel;
  final ValueNotifier<String?> activePhid;
  final bool onlyShowPublished;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<UiProvider, bool>(
        selector: (_, UiProvider uiProvider) => uiProvider.layoutIsVisible,
        builder: (_, bool isVisible, Widget? child) {

          return AutoScrollingBar(
            key: const ValueKey<String>('the_auto_scroll_phid_selector'),
            scrollController: scrollController,
            child: WidgetFader(
              fadeType: isVisible == false ? FadeType.fadeOut : FadeType.fadeIn,
              duration: const Duration(milliseconds: 300),
              ignorePointer: isVisible == false,
              child: ActivePhidSelector(
                bzModel: bzModel,
                mounted: mounted,
                activePhid: activePhid,
                onlyShowPublished: onlyShowPublished,
              ),
            ),
          );
        }
    );

  }
  // -----------------------------------------------------------------------------
}
