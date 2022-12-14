import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class PhidsSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsSelectorBubble({
    @required this.draft,
    @required this.draftNotifier,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftFlyer draft;
  final ValueNotifier<DraftFlyer> draftNotifier;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      key: const ValueKey('PhidsSelectorBubble'),
      fadeType: draft.flyerType == null ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.35,
      ignorePointer: draft.flyerType == null,
      child: Bubble(
        bubbleHeaderVM: const BubbleHeaderVM(
          headlineVerse: Verse(
            text: 'phid_keywords',
            translate: true,
          ),
        ),
        width: Bubble.bubbleWidth(context),
        columnChildren: <Widget>[

          const BulletPoints(
            bulletPoints: <Verse>[
              Verse(
                text: 'phid_add_keywords_to_help_search_filters',
                translate: true,
              ),
            ],
          ),

          /// SELECTED PHIDS
          ValueListenableBuilder(
              valueListenable: draftNotifier,
              builder: (_, DraftFlyer draft, Widget child){

                if (Mapper.checkCanLoopList(draft.keywordsIDs) == true){
                  return PhidsViewer(
                    pageWidth: Bubble.clearWidth(context),
                    phids: draft.keywordsIDs,
                    onPhidLongTap: (String phid){

                      final List<String> _newPhids = Stringer.addOrRemoveStringToStrings(
                          strings: draft.keywordsIDs,
                          string: phid,
                      );

                      draftNotifier.value = draftNotifier.value.copyWith(
                        keywordsIDs: _newPhids,
                      );

                    },
                  );
                }

                else {
                  return const SizedBox();
                }

              },
          ),

          /// ADD BUTTON
          DreamBox(
            height: PhidButton.getHeight(),
            verse: Verse(
              text: Mapper.checkCanLoopList(draft.specs) ? 'phid_edit_keywords' : 'phid_add_keywords',
              translate: true,
            ),
            bubble: false,
            color: Colorz.white20,
            verseScaleFactor: 1.5,
            verseWeight: VerseWeight.thin,
            icon: Iconz.plus,
            iconSizeFactor: 0.4,
            iconColor: Colorz.white20,
            onTap: () async {

              Keyboard.closeKeyboard(context);

              final List<String> _phids = await Nav.goToNewScreen(
                context: context,
                pageTransitionType: Nav.superHorizontalTransition(context),
                screen: PhidsPickerScreen(
                  multipleSelectionMode: true,
                  selectedPhids: draftNotifier.value.keywordsIDs,
                  chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
                    context: context,
                    flyerType: draftNotifier.value.flyerType,
                    event: ViewingEvent.flyerEditor,
                  ),
                ),
              );

              if (Mapper.checkCanLoopList(_phids) == true){

                setNotifier(
                  notifier: draftNotifier,
                  mounted: true,
                  value: draftNotifier.value.copyWith(
                    keywordsIDs: _phids,
                  ),
                );

              }

            },
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
