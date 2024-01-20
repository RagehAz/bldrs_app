part of chains;

/// DEPRECATED
class LineWithSectionAndSearchButtons extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LineWithSectionAndSearchButtons({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _zoneHasChains = ChainsProvider.proGetThisZoneHasChains(context: context);
    final bool _loadingChains = ChainsProvider.proGetIsLoadingChains(context: context);

    if (_loadingChains == false && _zoneHasChains == false){
      return const SizedBox();
    }

    else {
      return LineBox(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
            child: SectionsButton(),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
            child: BackAndSearchButton(
              backAndSearchAction: BackAndSearchAction.goToSearchScreen,
              loading: _loadingChains,
            ),
          ),

        ],
      );
    }

  }
  // -----------------------------------------------------------------------------
}
