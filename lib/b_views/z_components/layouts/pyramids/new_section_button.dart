

/// PLAN : FLOATING_SECTION_BUTTON

/*

class SectionsMenu extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const SectionsMenu({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  State<SectionsMenu> createState() => _SectionsMenuState();
  // -----------------------------------------------------------------------------

  /// SIZES

  // --------------------
  static const double extraBottomMargin = 20;
  // --------------------
  static double bigHeight(BuildContext context){
    final double _screenHeight = Scale.screenHeight(context);
    return _screenHeight - PyramidsPanel.bottomMargin - 20 - 14 - extraBottomMargin;
  }
  // --------------------
  static double bigWidth(BuildContext context){
    return BldrsAppBar.width(context);
  }
  // --------------------
  static double bigCorners = BldrsAppBar.corners.topLeft.x;

}

class _SectionsMenuState extends State<SectionsMenu> {

  bool isBig = false;

  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bigHeight = SectionsMenu.bigHeight(context);
    final double _bigWidth = SectionsMenu.bigWidth(context);
    final double _smallCorner = PyramidFloatingButton.size/2;
    final double _bigCorner = SectionsMenu.bigCorners;
    // --------------------
    return GestureDetector(
      onTap: (){
        setState(() {
          isBig = !isBig;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: isBig ? _bigWidth : PyramidFloatingButton.size,
        height: isBig ? _bigHeight : PyramidFloatingButton.size,
        decoration: BoxDecoration(
          color: isBig ? Colorz.black125 : Colorz.white80,
          borderRadius: Borderers.cornerAll(context, isBig ? _bigCorner : _smallCorner),
        ),
        margin: Scale.superInsets(
          context: context,
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          bottom: isBig ? SectionsMenu.extraBottomMargin : 0,
        ),
        /// for ths shuttering button to be positioned while animation
        alignment: Alignment.bottomRight,
        child: isBig ?
        const BigSectionsMenu()
            :
        const SectionsMenuButton(),
      ),
    );
    // --------------------
  }
}

class SectionsMenuButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SectionsMenuButton({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  List<String> getPhids({
    @required BuildContext context,
  }){
    final ZonePhidsModel _phidsModels = ChainsProvider.proGetZonePhids(context: context, listen: true);
    return ZonePhidsModel.getPhidsFromZonePhidsModel(zonePhidsModel: _phidsModels);
  }
  // --------------------
  String getIcon({
    @required BuildContext context,
    @required List<String> phids,
  }){

    // final bool _canRenderImages = Mapper.checkCanLoopList(phids);
    //
    // if (_canRenderImages == true){
    //   final int _index = Numeric.createRandomIndex(listLength: phids.length - 1);
    //   return ChainsProvider.proGetPhidIcon(context: context, son: phids[_index]);
    // }
    //
    // else {
      return Iconz.keywords;
    // }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _phids = getPhids(context: context);
    // --------------------
    return ClockRebuilder(
      startTime: DateTime.now(),
      duration: const Duration(milliseconds: 300),
      builder: (int timeDifference, Widget child){

        return SuperBox(
          height: PyramidFloatingButton.size,
          width: PyramidFloatingButton.size,
          icon: getIcon(
            context: context,
            phids: _phids,
          ),
          iconSizeFactor: 0.7,
          // color: Colorz.white20,
          corners: PyramidFloatingButton.size/2,
          bubble: false,

        );
        },
    );
  }
  // -----------------------------------------------------------------------------
}

class BigSectionsMenu extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BigSectionsMenu({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = SectionsMenu.bigWidth(context);
    final double _height = SectionsMenu.bigHeight(context);

    return Container(
      width: _width,
      height: _height,
      color: Colorz.black200,
      child: Stack(
        children: <Widget>[

          // BlurLayer(
          //   width: _width,
          //   height: _width,
          //   borders: Borderers.cornerAll(context, SectionsMenu.bigCorners),
          //   blurIsOn: true,
          // ),
///---
          Consumer<ChainsProvider>(
            builder: (_, ChainsProvider chainsPro, Widget child) {

              final ZonePhidsModel _zonePhidsModel = chainsPro.zonePhidsModel;
              final List<Chain> _bldrsChains = chainsPro.zoneChains;

              final List<FlyerType> _flyerTypes = ZonePhidsModel.getFlyerTypesByZonePhids(
                zonePhidsModel: _zonePhidsModel,
                bldrsChains: _bldrsChains,
              );

              return ListView(
                scrollDirection: Axis.horizontal,
                children: [

                  FloatingList(
                  columnChildren: <Widget>[

                    ...List.generate(_flyerTypes.length, (index) {
                      final FlyerType _flyerType = _flyerTypes[index];
                      final String _phid = FlyerTyper.getFlyerTypePhid(flyerType: _flyerType);

                      return FlyerTypeButton(
                        isSelected: false,
                        icon: FlyerTyper.flyerTypeIcon(flyerType: _flyerType, isOn: true),
                        verse: Verse(
                          id: _phid,
                          translate: true,
                        ),
                        onTap: () async {
                          final String phid = await PhidsPickerScreen.goPickPhid(
                            context: context,
                            flyerType: _flyerType,
                            event: ViewingEvent.homeView,
                            onlyUseZoneChains: true,
                            // selectedPhids:
                          );

                          if (phid != null) {
                            await setActivePhidK(
                              context: context,
                              phidK: phid,
                              flyerType: _flyerType,
                            );
                            setState(() {
                              isBig = false;
                            });
                          }
                        },
                      );
                    }),

                  ],
                ),

                ],
              );
            },
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}

 */
