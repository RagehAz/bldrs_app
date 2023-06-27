part of bldrs_app_bar;

class LineWithSectionAndSearchButtons extends StatelessWidget {

  const LineWithSectionAndSearchButtons({
    super.key
  });
  
  @override
  Widget build(BuildContext context) {

    return const LineBox(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          child: SectionsButton(),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          child: BackAndSearchButton(
            backAndSearchAction: BackAndSearchAction.goToSearchScreen,
          ),
        ),

      ],
    );

  }

}
