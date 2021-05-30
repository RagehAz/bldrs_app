class Filterz{

  static const List<Map<String, dynamic>> propertyFilters = const <Map<String, dynamic>>[
    {'title' : 'Property use', 'list' : propertyUse, 'canPickMany' : false },
    {'title' : 'Contract type', 'list' : contractType, 'canPickMany' : false },
    {'title' : 'Property type', 'list' : propertyType, 'canPickMany' : false },
    {'title' : 'Property area', 'list' : propertyArea, 'canPickMany' : true },

  ];


  static const List<String> propertyType = const <String>['Any', 'Penthouse', 'Chalet', 'Twin House', 'Full Floor', 'Half Floor', 'Building',
    'Land', 'Bungalow', 'Hotel Room', 'Villa', 'Office', 'Store', 'WareHouse', 'Exhibition Hall',
    'Meeting Room', 'Clinic', ];

  static const List<String> contractType = const <String>['For Sale', 'For Rent'];

  static const List<String> propertyUse = const <String>['Residential', 'Commercial', 'Industrial', 'Governmental', 'Administration',
    'Transportation', 'Educational', 'Agricultural', 'Medical', 'Hotel', 'Sports', 'Entertainment'];

  static const List<String> propertyArea = const <String>['Any', 'less than 50 sq.m',
    '50-100 sq.m', '100-150 sq.m', '150-200 sq.m', '200-250 sq.m', '250-300 sq.m',
    '300-400 sq.m', '400-500 sq.m', '500-700 sq.m', '700-1000 sq.m',
    '1000-2000 sq.m', '2000-5000 sq.m', '5000-10000 sq.m', 'more than 10000 sq.m'];

// int propertyArea;
// int numberOfRoom;
// Coordinates propertyLocation;
// int propertyPrice;

  static const List<String> designType = const <String>['Architecture Design', 'Interior Design', 'Urban Design', 'Urban Planning',
    'Furniture Design', 'Lighting Design', 'Landscape Design', 'Structure Design', 'Infrastructure Design'];

  static const List<String> spaceType = const <String>['Bedroom', 'Living Room', 'Kitchen', 'Bathroom', 'Reception', 'Salon', 'Toilet',
    'Terrace', 'Back yard', 'Storage Room', 'Spa', 'Gymnasium', 'Laundry Room', 'Theatre', 'Court',
    'Dining Room', 'Stairs', 'Attic', 'Mechanical Room', 'Electricity Room', 'store', 'corridor',
    'Lobby', 'Office', 'Kitchenette', 'Elevator Room', 'Lecture Room', 'Meeting Room', 'Seminal Hall',
    'Convention Hall', 'Musical Hall', 'Home Theatre', 'Library', 'Garage',];

  static const List<String> architecturalStyle = const <String>['American Colonial', 'Arabian','ArtDeco','Art Nouveau','Asian','Beach Style',
    'Chinese', 'Contemporary','Craftsman','Eclectic','English Country','Farm house','French','French Country',
    'Gothic','Indian','Industrial','Japanese','Mediterranean','MidCentury','Medieval','Minimalist',
    'Modern','Moroccan','Rustic','Scandinavian Country','Scandinavian Modern','ShabbyChic',
    'Shaker','South western','Spanish','Traditional','Transitional','Tuscan','Tropical',
    'Victorian','Vintage','Zen',];

  static const List<String> productUse = const <String>['Wall', 'Floor', 'Ceiling', 'Roof', 'Window', 'Door', 'Structure', 'Signage',
    'Proofing Isolation', 'FireFighting', 'Stairs', 'Landscape',
    'HVAC', 'Plumbing', 'Furnishing', 'Appliance', 'Safety', 'Conveying', 'Lighting', 'Electricity',
    'SmartHome', 'Security', ];

  static const List<String> constructionMaterial = const <String>['Paint', 'Wood', 'Paper', 'Stone', 'Marble', 'Granite', 'Fabric',
    'Plastic', 'Glass', 'Brick', 'Metal', 'Concrete', 'Ceramic', 'Porcelain', 'Mosaic', 'Asphalt',
    'Gypsum', 'PVC', 'WPC'];

//List<String projectType = ['Interior', 'Architecture', 'LightStructure', ];

  static const List<String> constructionTrade = const <String>['Carpentry', 'Electricity', 'Elevators', 'Isolation', 'Masonry',
    'Plumbing',];


  static const List<String> equipmentType = const <String>['EarthWork', 'Vehicles', 'Material Handling', 'HandTools', 'PowerTools'];

// List<String equipmentUse = <String>['EarthWork', 'SiteWork',];

}