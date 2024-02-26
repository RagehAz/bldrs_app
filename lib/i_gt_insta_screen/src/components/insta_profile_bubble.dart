import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/drawing/spacing.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:bldrs/i_fish_tank/fish_tank.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contacts_wrap.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class InstaProfileBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const InstaProfileBubble({
    required this.profile,
    super.key
  });
  // --------------------
  final InstaProfile? profile;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _textZoneWidth = Bubble.clearWidth(context: context) - 70;
    // --------------------
    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
      ),
      columnChildren: <Widget>[

        SizedBox(
          width: Bubble.clearWidth(context: context),
          // height: 100,
          // color: Colorz.bloodTest,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              BldrsBox(
                height: 60,
                width: 60,
                corners: 35,
                icon: profile?.logo,
              ),

              const Spacing(),

              SizedBox(
                width: _textZoneWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// NAME
                    BldrsText(
                      verse: Verse.plain(profile?.name),
                      centered: false,
                    ),

                    /// followers
                    Builder(
                      builder: (context) {

                        final String? _count = Numeric.formatNumToCounterCaliber(
                          x: profile?.followers,
                          thousand: 'k',
                          million: 'M',
                        );

                        return BldrsText(
                          verse: Verse.plain(_count ?? '..'),
                          size: 0,
                          centered: false,
                        );
                      }
                    ),

                    /// BIO
                    BldrsText(
                      maxWidth: _textZoneWidth,
                      verse: Verse.plain(profile?.biography),
                      size: 1,
                      centered: false,
                      italic: true,
                      maxLines: 50,
                    ),

                    /// CONTACTS
                    if (Lister.checkCanLoop(profile?.contacts) == true)
                      ContactsWrap(
                        contacts: profile!.contacts,
                        spacing: 10,
                        boxWidth: _textZoneWidth,
                        rowCount: 6,
                        buttonSize: 20,
                      ),


                  ],
                ),
              ),

            ],
          ),
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
