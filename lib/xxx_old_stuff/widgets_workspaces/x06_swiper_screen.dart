// import 'package:bldrs/controllers/drafters/scalers.dart';
// import 'package:bldrs/controllers/drafters/text_generators.dart';
// import 'package:bldrs/controllers/theme/colorz.dart';
// import 'package:bldrs/controllers/theme/iconz.dart';
// import 'package:bldrs/controllers/theme/ratioz.dart';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
// import 'package:bldrs/d_providers/flyers_and_bzz/old_flyers_provider.dart';
// import 'package:bldrs/d_providers/flyers_provider.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/main_layout.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:provider/provider.dart';
//
// class SwiperScreen extends StatefulWidget {
//   @override
//   _SwiperScreenState createState() => _SwiperScreenState();
// }
//
// class _SwiperScreenState extends State<SwiperScreen> {
//   String currentSection = 'Designs';
//   bool sectionsListIsOn = false;
//   SwiperController _swiperController;
//   FlyerType _currentFlyerType;
// // -----------------------------------------------------------------------------
// @override
//   void initState() {
//     super.initState();
//   _swiperController = new SwiperController();
//   _currentFlyerType = FlyerTypeClass.flyerTypesList[0];
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _swiperController.dispose();
//     super.dispose();
//   }
// // -----------------------------------------------------------------------------
//   // void _chooseSection(String sectionName) {
//   //   setState(() {
//   //     currentSection = sectionName;
//   //     sectionsListIsOn = false;
//   //   });
//   //   print(currentSection);
//   // }
// // -----------------------------------------------------------------------------
//   void openSectionsList() {
//     print(sectionsListIsOn);
//     setState(() {
//       sectionsListIsOn == false
//           ? sectionsListIsOn = true
//           : sectionsListIsOn = false;
//     });
//   }
// // -----------------------------------------------------------------------------
// //   void _goToNextFlyer(){
// //     _swiperController.next(animation: true);
// //   }
// // -----------------------------------------------------------------------------
// //   void _goToLastFlyer(){
// //     _swiperController.previous(animation: true);
// //   }
// // -----------------------------------------------------------------------------
// //   void _swipeFlyer(SwipeDirection swipeDirection){
// //
// //   if (swipeDirection == SwipeDirection.next){
// //     _goToNextFlyer();
// //   } else if (swipeDirection == SwipeDirection.back){
// //     _goToLastFlyer();
// //   }
// //
// //   }
// // -----------------------------------------------------------------------------
// //   void _changePage(FlyerType flyerType){
// //   setState(() {
// //     _currentFlyerType = flyerType;
// //   });
// //   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
//     final double _screenWidth = Scale.superScreenWidth(context);
//     final double _screenHeight = Scale.superScreenHeight(context);
//     const double _flyerSizeFactor = 0.8;
// // -----------------------------------------------------------------------------
//     final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
// // -----------------------------------------------------------------------------
//     List<FlyerType> _flyerTypesList = FlyerTypeClass.flyerTypesList;
// // -----------------------------------------------------------------------------
//     return MainLayout(
//       sky: Sky.Night,
//       appBarType: AppBarType.Basic,
//       pageTitle: TextGenerator.flyerTypePluralStringer(context, _currentFlyerType),
//       pyramids: Iconz.DvBlankSVG,
//       // appBarBackButton: true,
//       layoutWidget: PageView.builder(
//         itemCount: _flyerTypesList.length,
//         dragStartBehavior: DragStartBehavior.down,
//         onPageChanged: (index){
//           // playSound(Soundz.NextFlyer);
//
//           setState(() {
//             _currentFlyerType = _flyerTypesList[index];
//           });
//         },
//         allowImplicitScrolling: true,
//         scrollDirection: Axis.vertical,
//         itemBuilder: (context, index){
//
//           final List<FlyerModel> _tinyFlyersOfType = _flyersProvider.get(_flyerTypesList[index]);
//
//           return
//
//             Container(
//               width: _screenWidth,
//               height: _screenHeight,
//               child: Swiper(
//                 autoplay: false,
//                 pagination: new SwiperPagination(
//                   builder: DotSwiperPaginationBuilder(
//                     color: Colorz.White255,
//                     activeColor: Colorz.Yellow255,
//                     activeSize: 8,
//                     size: 4,
//                     space: 2,
//                   ),
//                   alignment: Alignment.topCenter,
//                   margin: const EdgeInsets.only(top: 54, right: Ratioz.appBarMargin * 2, left: Ratioz.appBarMargin * 2),
//                 ),
//                 layout: SwiperLayout.DEFAULT,
//                 itemWidth: FlyerBox.width(context, _flyerSizeFactor),
//                 itemHeight: FlyerBox.height(context, FlyerBox.width(context, _flyerSizeFactor)),
//                 // control: new SwiperControl(),
//                 // transformer: ,
//                 fade: 0.1,
//                 controller: _swiperController,
//                 duration: 600,
//                 viewportFraction: 1,
//                 curve: Curves.easeInOutCirc,
//                 scale: 0.6,
//                 itemCount: _tinyFlyersOfType.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return
//
//                     Column(
//                       children: <Widget>[
//
//                         const Stratosphere(),
//
//                         FinalFlyer(
//                           flyerBoxWidth: FlyerBox.width(context, _flyerSizeFactor),
//                           flyerModel: _tinyFlyersOfType[index],
//                           goesToEditor: false,
//                         ),
//
//                         // flyerModelBuilder(
//                         //     context: context,
//                         //     tinyFlyer: _tinyFlyersOfType[index],
//                         //     flyerSizeFactor: _flyerSizeFactor,
//                         //     builder: (ctx, flyerModel){
//                         //       return NormalFlyerWidget(
//                         //         flyer: flyerModel,
//                         //         flyerSizeFactor: _flyerSizeFactor,
//                         //         onSwipeFlyer: (swipeDirection) => _swipeFlyer(swipeDirection),
//                         //       );
//                         //     }
//                         //     ),
//
//                       ],
//                     );
//
//               },
//             ),
//           );
//
//         },
//
//       ),
//     );
//   }
// }
//
//
//