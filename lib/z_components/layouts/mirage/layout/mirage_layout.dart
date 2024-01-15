part of mirage;

class MirageLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MirageLayout({
    this.onBack,
    this.searchController,
    this.onSearchSubmit,
    this.onPaste,
    this.onSearchChanged,
    this.searchButtonIsOn = true,
    this.searchHintVerse,
    this.loading,
    this.progressBarModel,
    this.onSearchCancelled,
    this.filtersAreOn,
    this.filters,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onBack;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final ValueChanged<String?>? onPaste;
  final ValueChanged<String?>? onSearchChanged;
  final bool searchButtonIsOn;
  final Verse? searchHintVerse;
  final ValueNotifier<bool>? loading;
  final ValueNotifier<ProgressBarModel?>? progressBarModel;
  final Function? onSearchCancelled;
  final ValueNotifier<bool?>? filtersAreOn;
  final Widget? filters;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final TabController? _controller  = HomeProvider.proGetTabController(
      context: context,
      listen: true,
    );

    return PreLayout(
      connectivitySensorIsOn: true,
      canGoBack: false,
      child: Scaffold(
        key: const ValueKey<String>('mirage_scaffold'),
        /// INSETS
        resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
        // resizeToAvoidBottomPadding: false,
        body: Stack(
          key: key,
          alignment: Alignment.topCenter,
          children: <Widget>[

            /// SKY
            const Sky(
              key: ValueKey<String>('sky'),
              skyType: SkyType.black,
              // gradientIsOn: false,
            ),

            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: BldrsTabs.getAllViewsWidgets(),
            ),

            /// LAYOUT WIDGET
            const HomeMirage(),

            // /// APP BAR
            //   BldrsAppBar(
            //     key: const ValueKey<String>('appBar'),
            //     appBarType: AppBarType.main,
            //     appBarRowWidgets: null,
            //     pageTitleVerse: null,
            //     onBack: () => PreLayout.onGoBack(
            //         onBack: onBack,
            //         canGoBack: false,
            //     ),
            //     loading: loading,
            //     progressBarModel: progressBarModel,
            //     appBarScrollController: null,
            //     sectionButtonIsOn: false,
            //     searchController: searchController,
            //     onSearchSubmit: onSearchSubmit,
            //     onPaste: onPaste,
            //     onSearchChanged: onSearchChanged,
            //     searchButtonIsOn: searchButtonIsOn,
            //     searchHintVerse: searchHintVerse,
            //     canGoBack: kDebugMode,
            //     onSearchCancelled: onSearchCancelled,
            //     listenToHideLayout: true,
            //     filtersAreOn: filtersAreOn,
            //     filters: filters,
            //   ),

            /// WEB DOWNLOAD APP PANEL\
            if (kIsWeb == true)
              const DownloadAppPanel(),

          ],
        ),

      ),
    );

  }
// -----------------------------------------------------------------------------
}
