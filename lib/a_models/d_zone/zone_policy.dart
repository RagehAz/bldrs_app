
enum ZoneState {
  /// SWITCHED OFF - CAN NOT BE USED - IS HIDDEN,
  hidden,

  /// INACTIVE - NOT YET USED - HAS NO FLYERS
  inactive,

  /// ACTIVE - USED - HAS FLYERS
  active,

  /// PUBLIC - CAN BE USED BY ANYONE
  public,
}

class ZonePolicy {
  /// --------------------------------------------------------------------------

  const ZonePolicy();

  // --------------------------------------------------------------------------

  /// NOTES:-

  // --------------------
  /// ZONE :
  ///   - Either Country - City - District
  ///
  /// ACTIVE ZONE
  ///   - is a zone that has certain amount of flyers and bzz to be visible to users
  ///
  /// PUBLIC ZONE
  ///   - is a zone that reached a level that can be visible to other zones
  ///
  /// ACTIVE CITY
  ///   - is a city that has certain amount of flyers and bzz to be visible to users
  ///
  /// ACTIVE COUNTRY
  ///   - is a country that has atleast 1 active city
  ///
  /// PUBLIC CITY
  ///   - is a city that reached a level that can be visible to other cities
  ///
  /// PUBLIC COUNTRY
  ///   - is a country that has atleast 1 public city
  ///
  /// BZ ZONING POLICY
  ///  - ( Existence ) : Bz can only be in one zone at a time
  ///  - ( Creation )  : Bz can be created in any zone
  ///  - Bz can publish flyers in his zone + other public zones
  ///  - Bz Author can only view his zone + other public zones
  ///
  /// FLYER ZONING POLICY
  ///  - ( Existence ) : Flyer can only be published in one zone
  ///  - ( Creation )  : Flyer can be published in his BzZone + other public zones
  ///  - Flyer can have extra publishing zones as boost (PAID FEATURE)
  ///
  /// USER ZONING POLICY
  ///   - ( Existence ) : User can only be in one zone at a time
  ///   - ( Creation )  : User can be created in any zone
  ///   - ( Viewing )   : User can only view Public zones flyers
  ///   - ( Viewing )   : User can only view Active zones bzz
  ///   - User zone and User Need Zone are the same
  // --------------------------------------------------------------------------


  // --------------------------------------------------------------------------
  void f(){}
}
