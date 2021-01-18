import 'package:bldrs/ambassadors/database/db_contacts/db_phone.dart';
import 'package:bldrs/models/contact_model.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/providers/combined_models/co_author.dart';
import 'package:bldrs/providers/combined_models/coflyer_provider.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/ambassadors/db_brain/db_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/providers/combined_models/co_flyer.dart';

String fankoooooosha(){return 'fankoooooosha';}

  bool                wrongEntry  = false; /// emptyDB switch for testing is here [emptyDB]
  String              flyerID     = wrongEntry ?  'f008d'          : 'f008'            ;
  String              userID      = wrongEntry ?  'u01f'           : 'u21'             ;
  int                 index       = wrongEntry ?  100              : 0                 ;
  String              authorID    = wrongEntry ?  'au02w'          : 'au21'            ;
  String              bzID        = wrongEntry ?  'pp1w'           : 'br1'             ;
  List<ContactModel>  phonesList  = wrongEntry ?  dbPhones         : dbPhones          ;
  String              slideID     = wrongEntry ?  's001x'          : 's097'            ;
  String              originID    = wrongEntry ?  'o001xxx'        : 'o001'            ;
  FlyerType           flyerType   = wrongEntry ?  FlyerType.Design : FlyerType.Design  ;
  List<CoFlyer>       coFlyers    = wrongEntry ?  getCoFlyersByFlyerType(flyerType) : getCoFlyersByFlyerType(flyerType) ;

String returnInputs(){
  return 'flyerID: $flyerID, UserID: $userID, index: $index,authorID: $authorID, slideID: $slideID, originID: $originID';
}




List<Map<String, Object>> dbGetters = [

        {'fnID': 'g01', 'color': Colorz.Yellow, 'functionName': 'getUserByUserID(userID)', 'function': getUserByUserID(userID)},
        {'fnID': 'g02', 'color': Colorz.Yellow, 'functionName': 'getUserByUserID(userID)?.name', 'function': getUserByUserID(userID)?.name},

        {'fnID': 'g03', 'color': Colorz.Yellow, 'functionName': 'getContactsFromContactsByOwnerID(phonesList, bzID)', 'function': getContactsFromContactsByOwnerID(phonesList, bzID)},

        {'fnID': 'g04', 'color': Colorz.Yellow, 'functionName': 'getContactsByOwnerID(userID)', 'function': getContactsByOwnerID(userID)},

        {'fnID': 'g05', 'color': Colorz.Yellow, 'functionName': 'getUserLocationByUserID(userID)', 'function': getUserLocationByUserID(userID)},
        {'fnID': 'g06', 'color': Colorz.Yellow, 'functionName': 'getUserLocationByUserID(userID)?.longitude', 'function': getUserLocationByUserID(userID)?.longitude},

        {'fnID': 'g07', 'color': Colorz.Yellow, 'functionName': 'getCoUserByUserID(userID)', 'function': getCoUserByUserID(userID)},
        {'fnID': 'g08', 'color': Colorz.Yellow, 'functionName': 'getCoUserByUserID(userID)?.user?.name', 'function': getCoUserByUserID(userID)?.user?.name},

        {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g10', 'color': Colorz.Yellow, 'functionName': 'getAuthorByAuthorID(authorID)', 'function': getAuthorByAuthorID(authorID)},
        {'fnID': 'g11', 'color': Colorz.Yellow, 'functionName': 'getAuthorByAuthorID(authorID)?.bzId', 'function': getAuthorByAuthorID(authorID)?.bzId},

        {'fnID': 'g12', 'color': Colorz.Yellow, 'functionName': 'getConnectionsByAuthorID(authorID)', 'function': getConnectionsByAuthorID(authorID)},

        {'fnID': 'g13', 'color': Colorz.Yellow, 'functionName': 'getCoAuthorByAuthorID(authorID)', 'function': getCoAuthorByAuthorID(authorID)},
        {'fnID': 'g14', 'color': Colorz.Yellow, 'functionName': 'getCoAuthorByAuthorID(authorID)?.coUser?.user?.name', 'function': getCoAuthorByAuthorID(authorID)?.coUser?.user?.name},

        {'fnID': 'g15', 'color': Colorz.Yellow, 'functionName': 'getAllCoAuthors()', 'function': getAllCoAuthors()},

        {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g17', 'color': Colorz.Yellow, 'functionName': 'getBzByBzID(bzID)', 'function': getBzByBzID(bzID)},
        {'fnID': 'g18', 'color': Colorz.Yellow, 'functionName': 'getBzByBzID(bzID)?.bzName', 'function': getBzByBzID(bzID)?.bzName},

        {'fnID': 'g19', 'color': Colorz.Yellow, 'functionName': 'getBzByAuthorID(authorID)', 'function': getBzByAuthorID(authorID)},
        {'fnID': 'g20', 'color': Colorz.Yellow, 'functionName': 'getBzByAuthorID(authorID)?.bzName', 'function': getBzByAuthorID(authorID)?.bzName},

        {'fnID': 'g21', 'color': Colorz.Yellow, 'functionName': 'getAllBzz()', 'function': getAllBzz()},

        {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g23', 'color': Colorz.Yellow, 'functionName': 'getLocationByBzID(bzID)', 'function': getLocationByBzID(bzID)},
        {'fnID': 'g24', 'color': Colorz.Yellow, 'functionName': 'getLocationByBzID(bzID)?.longitude', 'function': getLocationByBzID(bzID)?.longitude},

        {'fnID': 'g25', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g26', 'color': Colorz.Yellow, 'functionName': 'getFollowsByBzID(bzID)', 'function': getFollowsByBzID(bzID)},

    {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g27', 'color': Colorz.Yellow, 'functionName': 'getCoAuthorsByBzID(bzID)', 'function': getCoAuthorsByBzID(bzID)},

        {'fnID': 'g28', 'color': Colorz.Yellow, 'functionName': 'getContactsByBzId(bzID)', 'function': getContactsByBzId(bzID)},

        {'fnID': 'g29', 'color': Colorz.Yellow, 'functionName': 'getCoBzByAuthorID(authorID)', 'function': getCoBzByAuthorID(authorID)},
        {'fnID': 'g30', 'color': Colorz.Yellow, 'functionName': 'getCoBzByAuthorID(authorID)?.bz?.bzName', 'function': getCoBzByAuthorID(authorID)?.bz?.bzName},

        {'fnID': 'g31', 'color': Colorz.Yellow, 'functionName': 'getCoBzByBzID(bzID)', 'function': getCoBzByBzID(bzID)},
        {'fnID': 'g32', 'color': Colorz.Yellow, 'functionName': 'getCoBzByBzID(bzID)?.bz?.bzScope', 'function': getCoBzByBzID(bzID)?.bz?.bzScope},

        {'fnID': 'g33', 'color': Colorz.Yellow, 'functionName': 'getAllCoBz()', 'function': getAllCoBz()},

    {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g34', 'color': Colorz.Yellow, 'functionName': 'getSlideBySlideID(slideID)', 'function': getSlideBySlideID(slideID)},
        {'fnID': 'g35', 'color': Colorz.Yellow, 'functionName': 'getSlideBySlideID(slideID)', 'function': getSlideBySlideID(slideID)?.headline},

        {'fnID': 'g36', 'color': Colorz.Yellow, 'functionName': 'getReferencesBySlideID(slideID)', 'function': getReferencesBySlideID(slideID)},

        {'fnID': 'g37', 'color': Colorz.Yellow, 'functionName': 'getOriginByOriginID(originID)', 'function': getOriginByOriginID(originID)},
        {'fnID': 'g38', 'color': Colorz.Yellow, 'functionName': 'getOriginByOriginID(originID)?.originName', 'function': getOriginByOriginID(originID)?.originName},

        {'fnID': 'g39', 'color': Colorz.Yellow, 'functionName': 'getOriginsIDsBySlideID(slideID)', 'function': getOriginsIDsBySlideID(slideID)},

        {'fnID': 'g40', 'color': Colorz.Yellow, 'functionName': 'getOriginsBySlideID(slideID)', 'function': getOriginsBySlideID(slideID)},

        {'fnID': 'g41', 'color': Colorz.Yellow, 'functionName': 'getCallsBySlideID(slideID)', 'function': getCallsBySlideID(slideID)},
        {'fnID': 'g42', 'color': Colorz.Yellow, 'functionName': 'getCallsBySlideID(slideID)?.length', 'function': getCallsBySlideID(slideID)?.length},

        {'fnID': 'g43', 'color': Colorz.Yellow, 'functionName': 'getSharesBySlideID(slideID)', 'function': getSharesBySlideID(slideID)},
        {'fnID': 'g44', 'color': Colorz.Yellow, 'functionName': 'getSharesBySlideID(slideID)?.length', 'function': getSharesBySlideID(slideID)?.length},

        {'fnID': 'g45', 'color': Colorz.Yellow, 'functionName': 'getHoruseeBySlideID(slideID)', 'function': getHoruseeBySlideID(slideID)},
        {'fnID': 'g46', 'color': Colorz.Yellow, 'functionName': 'getHoruseeBySlideID(slideID)?.length', 'function': getHoruseeBySlideID(slideID)?.length},

        {'fnID': 'g47', 'color': Colorz.Yellow, 'functionName': 'getSavesBySlideID(slideID)', 'function': getSavesBySlideID(slideID)},
        {'fnID': 'g48', 'color': Colorz.Yellow, 'functionName': 'getSavesBySlideID(slideID)?.length', 'function': getSavesBySlideID(slideID)?.length},

        {'fnID': 'g49', 'color': Colorz.Yellow, 'functionName': 'getBondsBySlideId(slideID)', 'function': getBondsBySlideId(slideID)},

        {'fnID': 'g50', 'color': Colorz.Yellow, 'functionName': 'getCoSlideBySlideID(slideID)', 'function': getCoSlideBySlideID(slideID)},
        {'fnID': 'g51', 'color': Colorz.Yellow, 'functionName': 'getCoSlideBySlideID(slideID)?.savesCount', 'function': getCoSlideBySlideID(slideID)?.savesCount},
        {'fnID': 'g52', 'color': Colorz.Yellow, 'functionName': 'getCoSlideBySlideID(slideID)?.sharesCount', 'function': getCoSlideBySlideID(slideID)?.sharesCount},
        {'fnID': 'g53', 'color': Colorz.Yellow, 'functionName': 'getCoSlideBySlideID(slideID)?.horuseeCount', 'function': getCoSlideBySlideID(slideID)?.horuseeCount},

    {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g54', 'color': Colorz.Yellow, 'functionName': 'getFlyerByFlyerID(flyerID)', 'function': getFlyerByFlyerID(flyerID)},
        {'fnID': 'g55', 'color': Colorz.Yellow, 'functionName': 'getFlyerByFlyerID(flyerID)?.flyerID', 'function': getFlyerByFlyerID(flyerID)?.flyerID},

        {'fnID': 'g56', 'color': Colorz.Yellow, 'functionName': 'getFlyerLocationByFlyerID(flyerID)', 'function': getFlyerLocationByFlyerID(flyerID)},
        {'fnID': 'g57', 'color': Colorz.Yellow, 'functionName': 'getFlyerLocationByFlyerID(flyerID)?.ownerID', 'function': getFlyerLocationByFlyerID(flyerID)?.ownerID},

        {'fnID': 'g58', 'color': Colorz.Yellow, 'functionName': 'getSlidesIDsByFlyerID(flyerID)', 'function': getSlidesIDsByFlyerID(flyerID)},

        {'fnID': 'g59', 'color': Colorz.Yellow, 'functionName': 'getCoSlidesByFlyerID(flyerID)', 'function': getCoSlidesByFlyerID(flyerID)},

        {'fnID': 'g60', 'color': Colorz.Yellow, 'functionName': 'getAuthorIDByFlyerID(flyerID)', 'function': getAuthorIDByFlyerID(flyerID)},

        {'fnID': 'g61', 'color': Colorz.Yellow, 'functionName': 'getCoBzByFlyerID(flyerID)', 'function': getCoBzByFlyerID(flyerID)},
        {'fnID': 'g62', 'color': Colorz.Yellow, 'functionName': 'getCoBzByFlyerID(flyerID)?.bz?.bzName', 'function': getCoBzByFlyerID(flyerID)?.bz?.bzName},

        {'fnID': 'g63', 'color': Colorz.Yellow, 'functionName': 'getCoFlyerByFlyerID(flyerID)', 'function': getCoFlyerByFlyerID(flyerID)},
        {'fnID': 'g64', 'color': Colorz.Yellow, 'functionName': 'getCoFlyerByFlyerID(flyerID)?.coBz?.bz?.bzName', 'function': getCoFlyerByFlyerID(flyerID)?.coBz?.bz?.bzName},

        {'fnID': 'g65', 'color': Colorz.Yellow, 'functionName': 'getFlyersIDsByAuthorID(authorID', 'function': getFlyersIDsByAuthorID(authorID)},

        {'fnID': 'g66', 'color': Colorz.Yellow, 'functionName': 'getCoFlyersByAuthorID(authorID)', 'function': getCoFlyersByAuthorID(authorID)},

        {'fnID': 'g67', 'color': Colorz.Yellow, 'functionName': 'getFlyersIDsByFlyerType(flyerType)', 'function': getFlyersIDsByFlyerType(flyerType)},

        {'fnID': 'g68', 'color': Colorz.Yellow, 'functionName': 'getCoFlyersByFlyerType(flyerType)', 'function': getCoFlyersByFlyerType(flyerType)},

        {'fnID': 'g69', 'color': Colorz.Yellow, 'functionName': 'getAllCoFlyers()', 'function': getAllCoFlyers()},

        {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g70', 'color': Colorz.Yellow, 'functionName': 'getSavedSlidesIDsByUserID(userID)', 'function': getSavedSlidesIDsByUserID(userID)},

        {'fnID': 'g71', 'color': Colorz.Yellow, 'functionName': 'getFlyerIDBySlideID(slideID)', 'function': getFlyerIDBySlideID(slideID)},

        {'fnID': 'g72', 'color': Colorz.Yellow, 'functionName': 'getCoFlyerBySlideID(slideID)', 'function': getCoFlyerBySlideID(slideID)},

        {'fnID': 'g73', 'color': Colorz.Yellow, 'functionName': 'getSavedCoFlyersByUserID(userID)', 'function': getSavedCoFlyersByUserID(userID)},

        {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},

        {'fnID': 'g74', 'color': Colorz.Nothing, 'functionName': 'getAllUsers()', 'function': getAllUsers()},
        {'fnID': 'g75', 'color': Colorz.Nothing, 'functionName': 'getBzIDByAuthorID(authorID)', 'function': getBzIDByAuthorID(authorID)},
        {'fnID': 'g76', 'color': Colorz.Nothing, 'functionName': 'getBzIDByFlyerID(flyerID)', 'function': getBzIDByFlyerID(flyerID)},
        {'fnID': 'g77', 'color': Colorz.Nothing, 'functionName': 'getFollowIsOnByUserIDWithFlyerID(userID, flyerID)', 'function': getFollowIsOnByUserIDWithFlyerID(userID, flyerID)},
        {'fnID': 'g78', 'color': Colorz.Nothing, 'functionName': 'getFollowedBzzIDsByUserID(userID)', 'function': getFollowedBzzIDsByUserID(userID)},
        {'fnID': 'g79', 'color': Colorz.Nothing, 'functionName': 'getAuthorsIDsByBzID(bzID)', 'function': getAuthorsIDsByBzID(bzID)},
        {'fnID': 'g80', 'color': Colorz.Nothing, 'functionName': 'getFlyersIDsByBzID(bzID)', 'function': getFlyersIDsByBzID(bzID)},
        {'fnID': 'g81', 'color': Colorz.Nothing, 'functionName': 'getSlidesIDsByBzID(bzID)', 'function': getSlidesIDsByBzID(bzID)},
        {'fnID': 'g82', 'color': Colorz.Nothing, 'functionName': 'getCallsIDsByBzID(bzID)', 'function': getCallsIDsByBzID(bzID)},


  {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},
    ];

  // -------------------------------------------------------------------------------------------------------------


List<Map<String, Object>> proHatters (BuildContext context){
    final pro = Provider.of<CoFlyersProvider>(context, listen: false); // this is the FlyersProvider data wormHole

    List<CoFlyer> inputCoFlyers = getCoFlyersByFlyerType(flyerType);
    List<CoAuthor> coAuthors = getCoAuthorsByBzID(bzID);

    List<Map<String, Object>> proHatters = [

        {'fnID': 'h01', 'color': Colorz.Yellow, 'functionName': 'pro.hatAllFlyers', 'function': pro.hatAllCoFlyers},

        {'fnID': 'h02', 'color': Colorz.Yellow, 'functionName': 'pro.hatAllSavedCoFlyers', 'function': pro.hatAllSavedCoFlyers},

        {'fnID': 'h03', 'color': Colorz.Yellow, 'functionName': 'pro.hatCoFlyerByFlyerID(flyerID)', 'function': pro.hatCoFlyerByFlyerID(flyerID)},
        {'fnID': 'h04', 'color': Colorz.Yellow, 'functionName': 'pro.\nhatCoFlyerByFlyerID(flyerID)?.flyerLocation?.longitude', 'function': pro.hatCoFlyerByFlyerID(flyerID)?.flyerLocation?.longitude},

        {'fnID': 'h05', 'color': Colorz.Yellow, 'functionName': 'pro.hatFlyersIDsByFlyerType(flyerType)', 'function': pro.hatFlyersIDsByFlyerType(flyerType)},

        {'fnID': 'h06', 'color': Colorz.Yellow, 'functionName': 'pro.hatCoFlyersByFlyerType(flyerType)', 'function': pro.hatCoFlyersByFlyerType(flyerType)},

        {'fnID': 'h07', 'color': Colorz.Yellow, 'functionName': 'pro.hatSavedCoSlidesByFlyerID(flyerID)', 'function': pro.hatSavedCoSlidesByFlyerID(flyerID)},

        {'fnID': 'h08', 'color': Colorz.Yellow, 'functionName': 'pro.hatAnkhByFlyerID(flyerID)', 'function': pro.hatAnkhByFlyerID(flyerID)},

        {'fnID': 'h09', 'color': Colorz.Yellow, 'functionName': 'pro.hatSavedCoFlyersFromCoFlyers(coFlyers, userID)', 'function': pro.hatSavedCoFlyersFromCoFlyers(inputCoFlyers, userID)},

        {'fnID': 'h10', 'color': Colorz.Yellow, 'functionName': 'pro.hatCoFlyersByAuthorID(authorID)', 'function': pro.hatCoFlyersByAuthorID(authorID)},

        {'fnID': 'h11', 'color': Colorz.Yellow, 'functionName': 'pro.hatAuthorsIDsByBzID(bzID)', 'function': pro.hatAuthorsIDsByBzID(bzID)},

        {'fnID': 'h12', 'color': Colorz.Yellow, 'functionName': 'pro.hatCoFlyersByBzID(bzID)', 'function': pro.hatCoFlyersByBzID(bzID)},

        // {'fnID': 'h13', 'color': Colorz.Nothing, 'functionName': 'pro.hatCoAuthorFromCoAuthorsByAuthorID\n(coAuthors, authorID)', 'function': pro.hatCoAuthorFromCoAuthorsByAuthorID(coAuthors, authorID)},
        // {'fnID': 'h14', 'color': Colorz.Nothing, 'functionName': 'ro.hatCoAuthorFromCoAuthorsByAuthorID\n(coAuthors, authorID)?.coUser?.user?.name', 'function': pro.hatCoAuthorFromCoAuthorsByAuthorID(coAuthors, authorID)?.coUser?.user?.name},

        {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},
        {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},
        {'fnID': '---', 'color': Colorz.BloodTest, 'functionName': '------------------------------', 'function': fankoooooosha()},
    ];
return proHatters;
}


