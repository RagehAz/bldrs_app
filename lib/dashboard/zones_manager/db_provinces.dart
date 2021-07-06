import 'package:bldrs/dashboard/zones_manager/db_districts.dart';
import 'package:bldrs/models/planet/province_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';

class DbProvinces {

  static List<Province> getProvincesByIso3(String iso3){
    List<Province> _provinces = new List();
    dbProvinces().forEach((pr) {
      if (pr.iso3 == iso3){_provinces.add(pr);}
    });
    return _provinces;
  }

  static List<Province> dbProvinces(){
    return
      <Province>[
        Province(districts: DbDistricts.getDistrictsByProvince('Cairo'),iso3: 'egy', name: 'Cairo', namez: [Name(code: 'ar', value: 'القاهرة',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Alexandria'),iso3: 'egy', name: 'Alexandria', namez: [Name(code: 'ar', value: 'الإسكندرية',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Port Said'),iso3: 'egy', name: 'Port Said', namez: [Name(code: 'ar', value: 'بورسعيد',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Suez'),iso3: 'egy', name: 'Suez', namez: [Name(code: 'ar', value: 'السويس',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Damietta'),iso3: 'egy', name: 'Damietta', namez: [Name(code: 'ar', value: 'دمياط',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Dakahlia'),iso3: 'egy', name: 'Dakahlia', namez: [Name(code: 'ar', value: 'الدقهلية',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Sharkia'),iso3: 'egy', name: 'Sharkia', namez: [Name(code: 'ar', value: 'الشرقية',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Qaliubiya'),iso3: 'egy', name: 'Qaliubiya', namez: [Name(code: 'ar', value: 'القليوبية',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Kafr El Sheikh'),iso3: 'egy', name: 'Kafr El Sheikh', namez: [Name(code: 'ar', value: 'كفر الشيخ',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Gharbia'),iso3: 'egy', name: 'Gharbia', namez: [Name(code: 'ar', value: 'الغربية',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Monoufia'),iso3: 'egy', name: 'Monoufia', namez: [Name(code: 'ar', value: 'المنوفية',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Beheira'),iso3: 'egy', name: 'Beheira', namez: [Name(code: 'ar', value: 'البحيرة',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Ismailia'),iso3: 'egy', name: 'Ismailia', namez: [Name(code: 'ar', value: 'الاسماعيلية',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Giza'),iso3: 'egy', name: 'Giza', namez: [Name(code: 'ar', value: 'الجيزة',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Bani Sweif'),iso3: 'egy', name: 'Bani Sweif', namez: [Name(code: 'ar', value: 'بنى سويف',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Fayoum'),iso3: 'egy', name: 'Fayoum', namez: [Name(code: 'ar', value: 'الفيوم',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Minya'),iso3: 'egy', name: 'Minya', namez: [Name(code: 'ar', value: 'المنيا',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Asyut'),iso3: 'egy', name: 'Asyut', namez: [Name(code: 'ar', value: 'أسيوط',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Sohag'),iso3: 'egy', name: 'Sohag', namez: [Name(code: 'ar', value: 'سوهاج',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Qena'),iso3: 'egy', name: 'Qena', namez: [Name(code: 'ar', value: 'قنا',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Aswan'),iso3: 'egy', name: 'Aswan', namez: [Name(code: 'ar', value: 'أسوان',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Luxor'),iso3: 'egy', name: 'Luxor', namez: [Name(code: 'ar', value: 'الأقصر',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Red Sea'),iso3: 'egy', name: 'Red Sea', namez: [Name(code: 'ar', value: 'البحر الأحمر',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Matrouh'),iso3: 'egy', name: 'Matrouh', namez: [Name(code: 'ar', value: 'مطروح',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('South Sinai'),iso3: 'egy', name: 'South Sinai', namez: [Name(code: 'ar', value: 'سيناء',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('NorthCoast'),iso3: 'egy', name: 'NorthCoast', namez: [Name(code: 'ar', value: 'الساحل الشمالي',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Riyadh'),iso3: 'sau', name: 'Al Riyadh', namez: [Name(code: 'ar', value: 'الرياض',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Jeddah'),iso3: 'sau', name: 'Jeddah', namez: [Name(code: 'ar', value: 'جدة',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Dammam'),iso3: 'sau', name: 'Al Dammam', namez: [Name(code: 'ar', value: 'الدمام',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Khobar'),iso3: 'sau', name: 'Al Khobar', namez: [Name(code: 'ar', value: 'الخبر',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Duwadimi'),iso3: 'sau', name: 'Al Duwadimi', namez: [Name(code: 'ar', value: 'الدوادمي',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Shaqra'),iso3: 'sau', name: 'Shaqra', namez: [Name(code: 'ar', value: 'شقراء',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Kharj'),iso3: 'sau', name: 'Al Kharj', namez: [Name(code: 'ar', value: 'الخرج',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Wadi Al Dawasir'),iso3: 'sau', name: 'Wadi Al Dawasir', namez: [Name(code: 'ar', value: 'وادي الدواسر',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Qutaif'),iso3: 'sau', name: 'Al Qutaif', namez: [Name(code: 'ar', value: 'القطيف',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Anak'),iso3: 'sau', name: 'Anak', namez: [Name(code: 'ar', value: 'عنك',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Khamis Mushait'),iso3: 'sau', name: 'Khamis Mushait', namez: [Name(code: 'ar', value: 'خميس مشيط',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Hafar Al Batin'),iso3: 'sau', name: 'Hafar Al Batin', namez: [Name(code: 'ar', value: 'حفر الباطن',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Najran'),iso3: 'sau', name: 'Najran', namez: [Name(code: 'ar', value: 'نجران',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Makkah Al Mukarrama'),iso3: 'sau', name: 'Makkah Al Mukarrama', namez: [Name(code: 'ar', value: 'مكة المكرمة',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Jazan'),iso3: 'sau', name: 'Jazan', namez: [Name(code: 'ar', value: 'جازان',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Dhahran'),iso3: 'sau', name: 'Al Dhahran', namez: [Name(code: 'ar', value: 'الظهران',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Madina Al Munawara'),iso3: 'sau', name: 'Al Madina Al Munawara', namez: [Name(code: 'ar', value: 'المدينة المنورة',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Ehsaa'),iso3: 'sau', name: 'Al Ehsaa', namez: [Name(code: 'ar', value: 'الاحساء',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Buraydah'),iso3: 'sau', name: 'Buraydah', namez: [Name(code: 'ar', value: 'بريدة',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Unayzah'),iso3: 'sau', name: 'Unayzah', namez: [Name(code: 'ar', value: 'عنيزه',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Hail'),iso3: 'sau', name: 'Hail', namez: [Name(code: 'ar', value: 'حائل',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Al Taif'),iso3: 'sau', name: 'Al Taif', namez: [Name(code: 'ar', value: 'الطائف',),],),
        Province(districts: DbDistricts.getDistrictsByProvince('Abha'),iso3: 'sau', name: 'Abha', namez: [Name(code: 'ar', value: 'أبها',),],),
      ];
  }

}
