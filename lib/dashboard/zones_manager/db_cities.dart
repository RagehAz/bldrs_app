import 'package:bldrs/dashboard/zones_manager/db_districts.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/zone/city_model.dart';

class DbCities {

  static List<City> getCitiesByIso3(String iso3){
    List<City> _cities = [];
    dbCities().forEach((pr) {
      if (pr.iso3 == iso3){_cities.add(pr);}
    });
    return _cities;
  }

  static List<City> dbCities(){
    return
      <City>[
        City(districts: DbDistricts.getDistrictsByCity('Cairo'),iso3: 'egy', name: 'Cairo', namez: [Name(code: 'ar', value: 'القاهرة',),],),
        City(districts: DbDistricts.getDistrictsByCity('Alexandria'),iso3: 'egy', name: 'Alexandria', namez: [Name(code: 'ar', value: 'الإسكندرية',),],),
        City(districts: DbDistricts.getDistrictsByCity('Port Said'),iso3: 'egy', name: 'Port Said', namez: [Name(code: 'ar', value: 'بورسعيد',),],),
        City(districts: DbDistricts.getDistrictsByCity('Suez'),iso3: 'egy', name: 'Suez', namez: [Name(code: 'ar', value: 'السويس',),],),
        City(districts: DbDistricts.getDistrictsByCity('Damietta'),iso3: 'egy', name: 'Damietta', namez: [Name(code: 'ar', value: 'دمياط',),],),
        City(districts: DbDistricts.getDistrictsByCity('Dakahlia'),iso3: 'egy', name: 'Dakahlia', namez: [Name(code: 'ar', value: 'الدقهلية',),],),
        City(districts: DbDistricts.getDistrictsByCity('Sharkia'),iso3: 'egy', name: 'Sharkia', namez: [Name(code: 'ar', value: 'الشرقية',),],),
        City(districts: DbDistricts.getDistrictsByCity('Qaliubiya'),iso3: 'egy', name: 'Qaliubiya', namez: [Name(code: 'ar', value: 'القليوبية',),],),
        City(districts: DbDistricts.getDistrictsByCity('Kafr El Sheikh'),iso3: 'egy', name: 'Kafr El Sheikh', namez: [Name(code: 'ar', value: 'كفر الشيخ',),],),
        City(districts: DbDistricts.getDistrictsByCity('Gharbia'),iso3: 'egy', name: 'Gharbia', namez: [Name(code: 'ar', value: 'الغربية',),],),
        City(districts: DbDistricts.getDistrictsByCity('Monoufia'),iso3: 'egy', name: 'Monoufia', namez: [Name(code: 'ar', value: 'المنوفية',),],),
        City(districts: DbDistricts.getDistrictsByCity('Beheira'),iso3: 'egy', name: 'Beheira', namez: [Name(code: 'ar', value: 'البحيرة',),],),
        City(districts: DbDistricts.getDistrictsByCity('Ismailia'),iso3: 'egy', name: 'Ismailia', namez: [Name(code: 'ar', value: 'الاسماعيلية',),],),
        City(districts: DbDistricts.getDistrictsByCity('Giza'),iso3: 'egy', name: 'Giza', namez: [Name(code: 'ar', value: 'الجيزة',),],),
        City(districts: DbDistricts.getDistrictsByCity('Bani Sweif'),iso3: 'egy', name: 'Bani Sweif', namez: [Name(code: 'ar', value: 'بنى سويف',),],),
        City(districts: DbDistricts.getDistrictsByCity('Fayoum'),iso3: 'egy', name: 'Fayoum', namez: [Name(code: 'ar', value: 'الفيوم',),],),
        City(districts: DbDistricts.getDistrictsByCity('Minya'),iso3: 'egy', name: 'Minya', namez: [Name(code: 'ar', value: 'المنيا',),],),
        City(districts: DbDistricts.getDistrictsByCity('Asyut'),iso3: 'egy', name: 'Asyut', namez: [Name(code: 'ar', value: 'أسيوط',),],),
        City(districts: DbDistricts.getDistrictsByCity('Sohag'),iso3: 'egy', name: 'Sohag', namez: [Name(code: 'ar', value: 'سوهاج',),],),
        City(districts: DbDistricts.getDistrictsByCity('Qena'),iso3: 'egy', name: 'Qena', namez: [Name(code: 'ar', value: 'قنا',),],),
        City(districts: DbDistricts.getDistrictsByCity('Aswan'),iso3: 'egy', name: 'Aswan', namez: [Name(code: 'ar', value: 'أسوان',),],),
        City(districts: DbDistricts.getDistrictsByCity('Luxor'),iso3: 'egy', name: 'Luxor', namez: [Name(code: 'ar', value: 'الأقصر',),],),
        City(districts: DbDistricts.getDistrictsByCity('Red Sea'),iso3: 'egy', name: 'Red Sea', namez: [Name(code: 'ar', value: 'البحر الأحمر',),],),
        City(districts: DbDistricts.getDistrictsByCity('Matrouh'),iso3: 'egy', name: 'Matrouh', namez: [Name(code: 'ar', value: 'مطروح',),],),
        City(districts: DbDistricts.getDistrictsByCity('South Sinai'),iso3: 'egy', name: 'South Sinai', namez: [Name(code: 'ar', value: 'سيناء',),],),
        City(districts: DbDistricts.getDistrictsByCity('NorthCoast'),iso3: 'egy', name: 'NorthCoast', namez: [Name(code: 'ar', value: 'الساحل الشمالي',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Riyadh'),iso3: 'sau', name: 'Al Riyadh', namez: [Name(code: 'ar', value: 'الرياض',),],),
        City(districts: DbDistricts.getDistrictsByCity('Jeddah'),iso3: 'sau', name: 'Jeddah', namez: [Name(code: 'ar', value: 'جدة',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Dammam'),iso3: 'sau', name: 'Al Dammam', namez: [Name(code: 'ar', value: 'الدمام',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Khobar'),iso3: 'sau', name: 'Al Khobar', namez: [Name(code: 'ar', value: 'الخبر',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Duwadimi'),iso3: 'sau', name: 'Al Duwadimi', namez: [Name(code: 'ar', value: 'الدوادمي',),],),
        City(districts: DbDistricts.getDistrictsByCity('Shaqra'),iso3: 'sau', name: 'Shaqra', namez: [Name(code: 'ar', value: 'شقراء',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Kharj'),iso3: 'sau', name: 'Al Kharj', namez: [Name(code: 'ar', value: 'الخرج',),],),
        City(districts: DbDistricts.getDistrictsByCity('Wadi Al Dawasir'),iso3: 'sau', name: 'Wadi Al Dawasir', namez: [Name(code: 'ar', value: 'وادي الدواسر',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Qutaif'),iso3: 'sau', name: 'Al Qutaif', namez: [Name(code: 'ar', value: 'القطيف',),],),
        City(districts: DbDistricts.getDistrictsByCity('Anak'),iso3: 'sau', name: 'Anak', namez: [Name(code: 'ar', value: 'عنك',),],),
        City(districts: DbDistricts.getDistrictsByCity('Khamis Mushait'),iso3: 'sau', name: 'Khamis Mushait', namez: [Name(code: 'ar', value: 'خميس مشيط',),],),
        City(districts: DbDistricts.getDistrictsByCity('Hafar Al Batin'),iso3: 'sau', name: 'Hafar Al Batin', namez: [Name(code: 'ar', value: 'حفر الباطن',),],),
        City(districts: DbDistricts.getDistrictsByCity('Najran'),iso3: 'sau', name: 'Najran', namez: [Name(code: 'ar', value: 'نجران',),],),
        City(districts: DbDistricts.getDistrictsByCity('Makkah Al Mukarrama'),iso3: 'sau', name: 'Makkah Al Mukarrama', namez: [Name(code: 'ar', value: 'مكة المكرمة',),],),
        City(districts: DbDistricts.getDistrictsByCity('Jazan'),iso3: 'sau', name: 'Jazan', namez: [Name(code: 'ar', value: 'جازان',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Dhahran'),iso3: 'sau', name: 'Al Dhahran', namez: [Name(code: 'ar', value: 'الظهران',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Madina Al Munawara'),iso3: 'sau', name: 'Al Madina Al Munawara', namez: [Name(code: 'ar', value: 'المدينة المنورة',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Ehsaa'),iso3: 'sau', name: 'Al Ehsaa', namez: [Name(code: 'ar', value: 'الاحساء',),],),
        City(districts: DbDistricts.getDistrictsByCity('Buraydah'),iso3: 'sau', name: 'Buraydah', namez: [Name(code: 'ar', value: 'بريدة',),],),
        City(districts: DbDistricts.getDistrictsByCity('Unayzah'),iso3: 'sau', name: 'Unayzah', namez: [Name(code: 'ar', value: 'عنيزه',),],),
        City(districts: DbDistricts.getDistrictsByCity('Hail'),iso3: 'sau', name: 'Hail', namez: [Name(code: 'ar', value: 'حائل',),],),
        City(districts: DbDistricts.getDistrictsByCity('Al Taif'),iso3: 'sau', name: 'Al Taif', namez: [Name(code: 'ar', value: 'الطائف',),],),
        City(districts: DbDistricts.getDistrictsByCity('Abha'),iso3: 'sau', name: 'Abha', namez: [Name(code: 'ar', value: 'أبها',),],),
      ];
  }

}
