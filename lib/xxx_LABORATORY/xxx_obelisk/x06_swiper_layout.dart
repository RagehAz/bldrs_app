import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/views/widgets/buttons/add_bz_bt.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperLayout extends StatefulWidget {
  @override
  _SwiperLayoutState createState() => _SwiperLayoutState();
}

class _SwiperLayoutState extends State<SwiperLayout> {
  String currentSection = 'Designs';
  bool sectionsListIsOn = false;

  // void _chooseSection(String sectionName) {
  //   setState(() {
  //     currentSection = sectionName;
  //     sectionsListIsOn = false;
  //   });
  //   print(currentSection);
  // }

  void openSectionsList() {
    print(sectionsListIsOn);
    setState(() {
      sectionsListIsOn == false
          ? sectionsListIsOn = true
          : sectionsListIsOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<BzType> _bzTypes = [
      BzType.Developer,
      BzType.Broker,
      BzType.Manufacturer,
      BzType.Supplier,
      BzType.Designer,
      BzType.Contractor,
      BzType.Artisan,
    ];

    return MainLayout(
      sky: Sky.Night,
      appBarType: AppBarType.Main,
      pyramids: Iconz.PyramidsYellow,
      layoutWidget: Stack(
        children: <Widget>[

          // --- LAYOUT
          Column(
            children: <Widget>[
              Expanded(
                child: Swiper(
                  autoplay: false,
                  pagination: new SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      color: Colorz.White,
                      activeColor: Colorz.Yellow,
                      activeSize: 8,
                      size: 5,
                      space: 2,
                    ),
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 54, right: 25),
                  ),

                  // control: new SwiperControl(),

                  viewportFraction: 1,
                  scale: 0.6,
                  itemCount: _bzTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: screenHeight,
                      width: screenWidth,
                      // color: Colorz.Facebook,
                      margin: EdgeInsets.all(Ratioz.ddAppBarMargin * 0),
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                            // key: ,
                            delegate: SliverChildListDelegate([

                              Stratosphere(),

                              //--- PAGE TITLE
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  SuperVerse(
                                    verse: bldrsTypePageTitle(context, _bzTypes[index]),
                                    shadow: false,
                                    size: 3,
                                    maxLines: 5,
                                    weight: VerseWeight.bold,
                                    color: Colorz.White,
                                    scaleFactor: 0.85,
                                    centered: true,
                                    margin: 5,
                                  ),
                                ],
                              ),


                              // GrowingBz(
                              //   bzType: _bzTypes[index],
                              //   bzLogos: getAllBzLogosOfThisType(_bzTypes[index]),
                              // ),

                              // CollectionWithCover(
                              //   flyersDataList: flyerTypeClassifier(FlyerType.Property),
                              //   collectionTitle: 'Properties for sale around you'
                              // ),
                              //
                              // CollectionTopFlyers(
                              //   flyersDataList: flyerTypeClassifier(FlyerType.Design),
                              //   collectionTitle: 'Top Trending Flyers',
                              //   numberOfFlyers: 3,
                              // ),
                              //
                              // FlyersCompactCollection(
                              //   collectionTitle: 'Properties for sale around you',
                              //   flyersDataList: flyerTypeClassifier(FlyerType.Craft),
                              //   flyerSizeFactor: 0.20,
                              // ),
                              //
                              // FlyersCompactCollection(
                              //   collectionTitle: 'Properties for sale around you',
                              //   flyersDataList: flyerTypeClassifier(FlyerType.Product),
                              //   flyerSizeFactor: 0.3,
                              // ),

                              DreamBox(
                                height: 500,
                                width: screenWidth,
                                color: Colorz.YellowGlass,
                              ),

                              PyramidsHorizon(heightFactor: 10),
                            ]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          AddBzBt(),
        ],
      ),
    );
  }
}



