part of chains;

class NoChainsFoundView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoChainsFoundView({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return const MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: Verse(
        id: '',
        translate: false,
      ),
      skyType: SkyType.blackStars,
      child: Center(
        child: NoResultFound(),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
