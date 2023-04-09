import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class PhraseStrip extends StatelessWidget {
// -----------------------------------------------------------------------------
  const PhraseStrip({
    @required this.width,
    @required this.enPhrase,
    @required this.arPhrase,
    @required this.onDelete,
    @required this.onSelect,
    @required this.onEdit,
    @required this.onCopyValue,
    @required this.searchController,
    Key key
  }) : super(key: key);
// -----------------------------------------------------------------------------
  final double width;
  final Phrase enPhrase;
  final Phrase arPhrase;
  final Function onDelete;
  final Function onEdit;
  final Function onSelect;
  final ValueChanged<String> onCopyValue;
  final TextEditingController searchController;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _idsAreTheSame = enPhrase?.id == arPhrase?.id;

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: Borderers.constantCornersAll20,
        color: _idsAreTheSame ? Colorz.white20 : Colorz.red255,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: <Widget>[

          if (_idsAreTheSame == false)
            const BldrsText(
              verse: Verse(
                id: 'CAUTION : IDs Are Not The Same !!',
                translate: false,
              ),
            ),

          SizedBox(
            width: width,
            height: 30,
            child: Row(
              children: <Widget>[

                /// PHRASE ID
                SizedBox(
                  width: width - 30 - 15,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      BldrsText(
                        verse: Verse(
                          id: 'en ID : ${enPhrase?.id}',
                          translate: false,
                        ),
                        highlight: searchController,
                        labelColor: Colorz.white20,
                        size: 1,
                        scaleFactor: 1.1,
                        italic: true,
                        centered: false,
                        weight: VerseWeight.thin,
                        onTap: () => onCopyValue(enPhrase?.id),
                      ),
                    ],
                  ),
                ),

                const Expander(),

                /// EDIT PHRASE BUTTON
                BldrsBox(
                  height: 30,
                  width: 30,
                  icon: Iconz.star,
                  iconSizeFactor: 0.6,
                  onTap: () async {

                    final String title = enPhrase?.id == arPhrase?.id ?
                    arPhrase?.id
                        :
                    'enID : ${enPhrase?.id} : arID ${arPhrase?.id}';

                    await BottomDialog.showBottomDialog(
                      context: context,
                      draggable: true,
                      titleVerse: Verse.plain(title),
                      child: Column(
                        children: <Widget>[

                          BldrsText(
                            verse: Verse(
                              id: enPhrase?.value,
                              translate: false,
                            ),
                            maxLines: 5,
                            color: Colorz.yellow255,
                            weight: VerseWeight.thin,
                            margin: 5,
                          ),

                          BldrsText(
                            verse: Verse(
                              id: arPhrase?.value,
                              translate: false,
                            ),
                            maxLines: 5,
                            color: Colorz.yellow255,
                            weight: VerseWeight.thin,
                            margin: 5,
                          ),

                          const SizedBox(
                            width: 10,
                            height: 10,
                          ),

                          BldrsBox(
                            width: BottomDialog.clearWidth(context),
                            height: 40,
                            verse: const Verse(
                              id: 'Edit',
                              translate: false,
                              casing: Casing.upperCase,
                            ),
                            margins: const EdgeInsets.only(bottom: 5),
                            verseItalic: true,
                            onTap: onEdit,
                          ),

                          BldrsBox(
                            width: BottomDialog.clearWidth(context),
                            height: 40,
                            verse: const Verse(
                              id: 'Delete',
                              translate: false,
                              casing: Casing.upperCase,
                            ),
                            margins: const EdgeInsets.only(bottom: 5),
                            verseItalic: true,
                            onTap: onDelete,
                          ),

                          BldrsBox(
                            width: BottomDialog.clearWidth(context),
                            height: 40,
                            verse: const Verse(
                              id: 'Select',
                              translate: false,
                              casing: Casing.upperCase,
                            ),
                            margins: const EdgeInsets.only(bottom: 5),
                            verseItalic: true,
                            onTap: onSelect,
                          ),



                        ],

                      ),
                    );

                  },
                ),

              ],
            ),
          ),

          SizedBox(
            width: width,
            height: 35,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[

                /// EN VALUE
                BldrsText(
                  verse: Verse(
                    id: enPhrase?.value,
                    translate: false,
                  ),
                  labelColor: Colorz.white20,
                  highlight: searchController,
                  onTap: () => onCopyValue(enPhrase?.value),
                ),

                /// AR VALUE
                BldrsText(
                  verse: Verse(
                    id: arPhrase?.value,
                    translate: false,
                  ),
                  labelColor: Colorz.white20,
                  highlight: searchController,
                  onTap: () => onCopyValue(arPhrase?.value),
                ),

              ],
            ),
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
