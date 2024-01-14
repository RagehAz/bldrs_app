part of bldrs_app_bar;

class ScrollableAppBarWidgets extends StatelessWidget {

  const ScrollableAppBarWidgets({
    required this.width,
    required this.scrollController,
    required this.children,
    super.key
  });
  
  final double width;
  final ScrollController? scrollController;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(Ratioz.appBarCorner - Ratioz.appBarPadding),
      child: Container(
        width: width,
        height: BldrsAppBar.clearLineHeight(context),
        alignment: BldrsAligners.superInverseCenterAlignment(context),
        // color: Colorz.white10,
        child: Lister.checkCanLoop(children) == false ?
        Container(
          width: width - 20,
          height: BldrsAppBar.clearLineHeight(context),
          color: Colorz.bloodTest,
        )
            :
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          child: IntrinsicWidth(
            // stepWidth: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: children ?? [],
            ),
          ),
        ),

      ),
    );
  }

}
