part of fish_tank;

class FishTile extends StatelessWidget {
  // --------------------------------------------------------------------------
  const FishTile({
    required this.fishModel,
    required this.isSelected,
    required this.index,
    required this.onTileTap,
    required this.onEditTap,
    super.key
  });
  // --------------------
  final FishModel fishModel;
  final bool isSelected;
  final String? index;
  final Function onTileTap;
  final Function onEditTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsTileBubble(
      bubbleColor: isSelected == true ? Colorz.yellow50 : Colorz.white10,
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: Verse.plain('$index : ${fishModel.name}'),
        leadingIcon: BzTyper.getBzTypeIcon(fishModel.type),
        leadingIconSizeFactor: 0.6,
        moreButtonIcon: Flag.getCountryIcon(fishModel.countryID, showUSStateFlag: true),
        hasMoreButton: true,
        onMoreButtonTap: onEditTap,
      ),
      onTileTap: onTileTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// ID
          BldrsBox(
            height: 30,
            maxWidth: TileBubble.childWidth(context: context),
            icon: fishModel.imageURL,
            verse: Verse.plain('id : ${fishModel.id}'),
            verseWeight: VerseWeight.thin,
            color: Colorz.blue50,
            margins: const EdgeInsets.only(bottom: 3),
            onTap: () => Keyboard.copyToClipboardAndNotify(copy: fishModel.id),
          ),

          /// CONTACTS
          if (Lister.checkCanLoop(fishModel.contacts) == true)
            ContactsWrap(
              contacts: fishModel.contacts,
              spacing: 10,
              boxWidth: TileBubble.childWidth(context: context),
              rowCount: 6,
              buttonSize: 30,
              buttonColor: (ContactModel contact){
                if (contact.type == ContactType.email && fishModel.emailIsFailing == true){
                  return Colorz.red255;
                }
                else {
                  return null;
                }
              },
            ),

          /// BIO
          if (TextCheck.isEmpty(fishModel.bio) == false)
            BldrsText(
              verse: Verse.plain(fishModel.bio),
              size: 1,
              italic: true,
              centered: false,
              labelColor: Colorz.blue50,
              margin: const EdgeInsets.only(top: 5),
              weight: VerseWeight.thin,
              maxLines: 4,
            ),

          if (fishModel.emailIsFailing)
            BldrsText(
              verse: Verse.plain('Email is Failing to receive mails'),
              size: 0,
              italic: true,
              centered: false,
              color: Colorz.red255,
              leadingDot: true,
              margin: 3 ,
            ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
