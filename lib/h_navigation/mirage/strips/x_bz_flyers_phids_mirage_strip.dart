part of mirage;
// ignore_for_file: unused_element

class _BzFlyersPhidsMirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _BzFlyersPhidsMirageStrip({
    required this.thisMirage,
    super.key
  });
  // --------------------
  final MirageModel thisMirage;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BzModel? _bzModel = HomeProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );
    // --------------------
    final String? _activePhid = HomeProvider.proGetMyBzFlyersActivePhid(
      context: context,
      listen: true,
    );
    // --------------------
    return _MirageStripScrollableList(
      mirageModel: thisMirage,
      columnChildren: <Widget>[

        ...ActivePhidSelector.getButtons(
          bzModel: _bzModel,
          activePhid: _activePhid,
          selectedButtonColor: MirageModel.selectedButtonColor,
          buttonColor: MirageModel.buttonColor,
          onlyShowPublished: false,
          onPhidTap: (String? phid) => HomeProvider.proSetMyBzFlyersActivePhid(
            notify: true,
            phid: phid,
          ),
          buttonHeight: MirageButton.getHeight,
        ),

      ],
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
