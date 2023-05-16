part of bldrs_app_bar;

class ScrollableAppBarWidgets extends StatelessWidget {

  const ScrollableAppBarWidgets({
    @required this.width,
    @required this.scrollController,
    @required this.children,
    Key key
  }) : super(key: key);

  final double width;
  final ScrollController scrollController;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Ratioz.appBarCorner - Ratioz.appBarPadding),
      child: Container(
        width: width,
        height: BldrsAppBar.clearLineHeight(context),
        alignment: Alignment.center,
        color: Colorz.white10,
        child: Mapper.checkCanLoopList(children) == false ?
        const SizedBox()
            :
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          child: SizedBox(
            width: width + Ratioz.appBarMargin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: children,
            ),
          ),
        ),
      ),
    );
  }

}
