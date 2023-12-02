import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/b_views/f_bz/z_components/phid_button_clone.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class ActivePhidSelector extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ActivePhidSelector({
    required this.activePhid,
    required this.bzModel,
    required this.mounted,
    this.stratosphere = true,
    super.key
  });
  // --------------------
  final ValueNotifier<String?> activePhid;
  final BzModel? bzModel;
  final bool mounted;
  final bool stratosphere;
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

    final double _screenWidth = Scale.screenWidth(context);
    final double barHeight = stratosphere == true ?
    Stratosphere.bigAppBarStratosphere
        :
    PhidButton.getHeight() + 5;

    // --------------------
    return BlurLayer(
      width: _screenWidth,
      height: barHeight,
      color: Colorz.black125,
      blurIsOn: true,
      child: ValueListenableBuilder(
          valueListenable: activePhid,
          builder: (_, String? thePhid, Widget? child) {

            final List<String> _phids = bzModel?.scopes?.map.keys.toList() ?? [];

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
                if (Mapper.checkCanLoopList(bzModel?.publication.pendings) == true)
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
                if (Mapper.checkCanLoopList(_phids) == true)...List.generate(_phids.length, (index){

                  final String? _phid = bzModel?.scopes?.map.keys.toList()[index];

                  final bool _isSelected = _phid == thePhid;

                  return PhidButton(
                    phid: _phid,
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
                if (Mapper.checkCanLoopList(bzModel?.publication.suspended) == true)
                Builder(
                  builder: (context) {

                    final String _phid = PublicationModel.getPublishStatePhid(PublishState.suspended)!;

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

              ],
            );
          }
          ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
