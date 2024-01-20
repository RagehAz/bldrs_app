part of chains;

class SpecsSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecsSelectorBubble({
    required this.draft,
    required this.bzModel,
    required this.onSpecTap,
    required this.onDeleteSpec,
    required this.onAddSpecsToDraft,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftFlyer? draft;
  final BzModel? bzModel;
  final Function({required SpecModel? value, required SpecModel? unit})? onSpecTap; // onAddSpecsToDraftTap
  final Function({required SpecModel? value, required SpecModel? unit})? onDeleteSpec;
  final Function onAddSpecsToDraft; // use this onAddSpecsToDraftTap
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      fadeType: draft?.flyerType == null ? FadeType.stillAtMin : FadeType.stillAtMax,
      min: 0.35,
      ignorePointer: draft?.flyerType == null,
      child: Bubble(
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headlineVerse: const Verse(
            id: 'phid_specifications',
            translate: true,
          ),
        ),
        width: Bubble.bubbleWidth(context: context),
        columnChildren: <Widget>[

          const BldrsBulletPoints(
            showBottomLine: false,
            bulletPoints: <Verse>[
              Verse(id: 'phid_optional_field', translate: true),
              Verse(
                pseudo: 'Add technical specification to describe flyer contents and help the search filters find your flyer',
                id: 'phid_add_spec_to_help_search_filters',
                translate: true,
              ),
            ],
          ),

          SpecsBuilder(
            pageWidth: Bubble.clearWidth(context: context),
            specs: const [], //draft?.specs,
            onSpecTap: onSpecTap,
            onDeleteSpec: onDeleteSpec,
          ),

          BldrsBox(
            height: PhidButton.getHeight(),
            verse: Verse(
              id: Lister.checkCanLoop([]) ? 'phid_edit_specs' : 'phid_add_specs',
              translate: true,
            ),
            bubble: false,
            color: Colorz.white20,
            verseScaleFactor: 1.5,
            verseWeight: VerseWeight.thin,
            icon: Iconz.plus,
            iconSizeFactor: 0.4,
            iconColor: Colorz.white20,
            onTap: onAddSpecsToDraft,
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
