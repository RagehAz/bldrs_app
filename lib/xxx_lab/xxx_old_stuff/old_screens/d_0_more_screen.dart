// import 'package:bldrs/a_models/user/user_model.dart';
// import 'package:bldrs/a_models/zone/country_model.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/unfinished_night_sky.dart';
// import 'package:bldrs/d_providers/zone_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class MoreScreen extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const MoreScreen({
//     @required this.userModel,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   // final AuthOps _authOps = AuthOps();
//   final UserModel userModel;
//
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
//     final CountryModel _currentCountry = zoneProvider.currentCountry;
//
//     return MainLayout(
//       appBarType: AppBarType.basic,
//       // appBarBackButton: true,
//       skyType: SkyType.black,
//       sectionButtonIsOn: false,
//       zoneButtonIsOn: false,
//       pageTitle: 'Options',
//       pyramidsAreOn: true,
//       layoutWidget: MaxBounceNavigator(
//         child: Scroller(
//           child: ListView(
//             physics: const BouncingScrollPhysics(),
//             children: <Widget>[
//
//               // const Stratosphere(),
//
//               // TileBubble(
//               //   verse: Wordz.createBzAccount(context),
//               //   icon: Iconz.bz,
//               //   iconSizeFactor: 0.9,
//               //   btOnTap: () => Nav.goToNewScreen(context,
//               //       BzEditorScreen(firstTimer: true, userModel: userModel)),
//               // ),
//
//               // const BubblesSeparator(),
//
//               // TileBubble(
//               //   verse: Wordz.inviteFriends(context),
//               //   icon: DeviceChecker.deviceIsIOS()
//               //       ? Iconz.comApple
//               //       : DeviceChecker.deviceIsAndroid()
//               //           ? Iconz.comGooglePlay
//               //           : Iconz.share,
//               //   iconBoxColor: Colorz.black230,
//               //   btOnTap: () async {
//               //     await Launcher.shareLink(context, LinkModel.bldrsWebSiteLink);
//               //   },
//               // ),
//
//               // TileBubble(
//               //   verse: Wordz.inviteBusinesses(context),
//               //   icon: Iconz.bz,
//               //   iconBoxColor: Colorz.black230,
//               // ),
//
//               // const BubblesSeparator(),
//
//               // TileBubble(
//               //   verse: Wordz.changeCountry(context),
//               //   icon: FlagBox(countryID: _currentCountry?.id),
//               //   iconSizeFactor: 0.9,
//               //   btOnTap: () =>
//               //       Nav.goToNewScreen(context, const SelectCountryScreen()
//               //
//               //           //   /// but now we go to Egypt cities directly
//               //           // SelectCityScreen(countryID: 'egy',)
//               //
//               //           ),
//               // ),
//
//               // TileBubble(
//               //   verse: Wordz.changeLanguage(context),
//               //   icon: Iconz.language,
//               //   btOnTap: () => Nav.goToNewScreen(context, const SelectLanguageScreen()),
//               // ),
//
//               // const BubblesSeparator(),
//
//               // TileBubble(
//               //   verse: '${Wordz.about(context)} ${Wordz.bldrsShortName(context)}',
//               //   icon: Iconz.pyramidSingleYellow,
//               //   iconSizeFactor: 0.8,
//               //   btOnTap: () =>
//               //       Nav.goToNewScreen(context, const AboutBldrsScreen()),
//               // ),
//
//               // TileBubble(
//               //   verse: Wordz.feedback(context),
//               //   icon: Iconz.utSearching,
//               //   btOnTap: () => Nav.goToNewScreen(context, const FeedBack()),
//               // ),
//
//               // TileBubble(
//               //   verse: Wordz.termsRegulations(context),
//               //   icon: Iconz.terms,
//               // ),
//
//               // const BubblesSeparator(),
//
//               // TileBubble(
//               //   verse: Wordz.advertiseOnBldrs(context),
//               //   icon: Iconz.Advertise,
//               //   iconSizeFactor: 0.6,
//               // ),
//               // TileBubble(
//               //   verse: 'Get Blrs.net Marketing materials',
//               //   icon: Iconz.Marketing,
//               //   iconSizeFactor: 0.7,
//               // ),
//               // const BubblesSeparator(),
//
//               // const TileBubble(
//               //   verse: 'Open App Tutorial',
//               //   icon: Iconz.scholar,
//               // ),
//
//               // TileBubble(
//               //   verse: Wordz.whatIsFlyer(context),
//               //   icon: Iconz.flyer,
//               // ),
//
//               // TileBubble(
//               //   verse: Wordz.whoAreBldrs(context),
//               //   icon: Iconz.bz,
//               // ),
//
//               // TileBubble(
//               //   verse: Wordz.howItWorks(context),
//               //   icon: Iconz.gears,
//               // ),
//
//               // const BubblesSeparator(),
//
//               // TileBubble(
//               //   verse: Wordz.signOut(context),
//               //   icon: Iconz.exit,
//               //   btOnTap: () async {
//               //
//               //     /// CLEAR FLYERS
//               //     final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//               //     _flyersProvider.clearSavedFlyers();
//               //     _flyersProvider.clearPromotedFlyers();
//               //     _flyersProvider.clearWallFlyers();
//               //     _flyersProvider.clearLastWallFlyer();
//               //
//               //     /// CLEAR SEARCHES
//               //     final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
//               //     _searchProvider.clearSearchResult();
//               //     _searchProvider.clearSearchRecords();
//               //     _searchProvider.closeAllZoneSearches();
//               //
//               //     /// CLEAR KEYWORDS
//               //     final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
//               //     _keywordsProvider.clearAllKeywords();
//               //     _keywordsProvider.clearCurrentKeyword();
//               //     _keywordsProvider.clearCurrentSection();
//               //
//               //     /// CLEAR BZZ
//               //     final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
//               //     _bzzProvider.clearMyBzz();
//               //     _bzzProvider.clearFollowedBzz();
//               //     _bzzProvider.clearSponsors();
//               //     _bzzProvider.clearMyActiveBz();
//               //     _bzzProvider.clearActiveBzFlyers();
//               //
//               //     /// CLEAR USER
//               //     final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
//               //     _usersProvider.clearMyUserModelAndCountryAndCity();
//               //
//               //     final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
//               //     // _zoneProvider.clearAllSearchesAndSelections();
//               //     _zoneProvider.clearCurrentContinent();
//               //     _zoneProvider.clearUserCountryModel();
//               //     _zoneProvider.clearCurrentZoneAndCurrentCountryAndCurrentCity();
//               //     _zoneProvider.clearCurrentCurrencyAndAllCurrencies();
//               //     _zoneProvider.clearSearchedCountries();
//               //     _zoneProvider.clearSelectedCountryCities();
//               //     _zoneProvider.clearSearchedCities();
//               //     _zoneProvider.clearSelectedCityDistricts();
//               //     _zoneProvider.clearSearchedDistricts();
//               //
//               //     await FireAuthOps.signOut(context: context, routeToUserChecker: true);
//               //
//               //   },
//               // ),
//
//               // const Horizon(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
