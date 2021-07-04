import 'package:bldrs/dashboard/zones_manager/db_areas.dart';
import 'package:bldrs/models/planet/province_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';

List<Province> geebProvincesByIso3(String iso3){
  List<Province> _provinces = new List();
  dbProvinces.forEach((pr) {
    if (pr.iso3 == iso3){_provinces.add(pr);}
  });
  return _provinces;
}

final List<Province> dbProvinces = <Province>[
  Province(areas: geebAreasByProvince('Cairo'),iso3: 'egy', name: 'Cairo', namez: [Namez(code: 'ar', value: 'القاهرة',),],),
  Province(areas: geebAreasByProvince('Alexandria'),iso3: 'egy', name: 'Alexandria', namez: [Namez(code: 'ar', value: 'الإسكندرية',),],),
  Province(areas: geebAreasByProvince('Port Said'),iso3: 'egy', name: 'Port Said', namez: [Namez(code: 'ar', value: 'بورسعيد',),],),
  Province(areas: geebAreasByProvince('Suez'),iso3: 'egy', name: 'Suez', namez: [Namez(code: 'ar', value: 'السويس',),],),
  Province(areas: geebAreasByProvince('Damietta'),iso3: 'egy', name: 'Damietta', namez: [Namez(code: 'ar', value: 'دمياط',),],),
  Province(areas: geebAreasByProvince('Dakahlia'),iso3: 'egy', name: 'Dakahlia', namez: [Namez(code: 'ar', value: 'الدقهلية',),],),
  Province(areas: geebAreasByProvince('Sharkia'),iso3: 'egy', name: 'Sharkia', namez: [Namez(code: 'ar', value: 'الشرقية',),],),
  Province(areas: geebAreasByProvince('Qaliubiya'),iso3: 'egy', name: 'Qaliubiya', namez: [Namez(code: 'ar', value: 'القليوبية',),],),
  Province(areas: geebAreasByProvince('Kafr El Sheikh'),iso3: 'egy', name: 'Kafr El Sheikh', namez: [Namez(code: 'ar', value: 'كفر الشيخ',),],),
  Province(areas: geebAreasByProvince('Gharbia'),iso3: 'egy', name: 'Gharbia', namez: [Namez(code: 'ar', value: 'الغربية',),],),
  Province(areas: geebAreasByProvince('Monoufia'),iso3: 'egy', name: 'Monoufia', namez: [Namez(code: 'ar', value: 'المنوفية',),],),
  Province(areas: geebAreasByProvince('Beheira'),iso3: 'egy', name: 'Beheira', namez: [Namez(code: 'ar', value: 'البحيرة',),],),
  Province(areas: geebAreasByProvince('Ismailia'),iso3: 'egy', name: 'Ismailia', namez: [Namez(code: 'ar', value: 'الاسماعيلية',),],),
  Province(areas: geebAreasByProvince('Giza'),iso3: 'egy', name: 'Giza', namez: [Namez(code: 'ar', value: 'الجيزة',),],),
  Province(areas: geebAreasByProvince('Bani Sweif'),iso3: 'egy', name: 'Bani Sweif', namez: [Namez(code: 'ar', value: 'بنى سويف',),],),
  Province(areas: geebAreasByProvince('Fayoum'),iso3: 'egy', name: 'Fayoum', namez: [Namez(code: 'ar', value: 'الفيوم',),],),
  Province(areas: geebAreasByProvince('Minya'),iso3: 'egy', name: 'Minya', namez: [Namez(code: 'ar', value: 'المنيا',),],),
  Province(areas: geebAreasByProvince('Asyut'),iso3: 'egy', name: 'Asyut', namez: [Namez(code: 'ar', value: 'أسيوط',),],),
  Province(areas: geebAreasByProvince('Sohag'),iso3: 'egy', name: 'Sohag', namez: [Namez(code: 'ar', value: 'سوهاج',),],),
  Province(areas: geebAreasByProvince('Qena'),iso3: 'egy', name: 'Qena', namez: [Namez(code: 'ar', value: 'قنا',),],),
  Province(areas: geebAreasByProvince('Aswan'),iso3: 'egy', name: 'Aswan', namez: [Namez(code: 'ar', value: 'أسوان',),],),
  Province(areas: geebAreasByProvince('Luxor'),iso3: 'egy', name: 'Luxor', namez: [Namez(code: 'ar', value: 'الأقصر',),],),
  Province(areas: geebAreasByProvince('Red Sea'),iso3: 'egy', name: 'Red Sea', namez: [Namez(code: 'ar', value: 'البحر الأحمر',),],),
  Province(areas: geebAreasByProvince('Matrouh'),iso3: 'egy', name: 'Matrouh', namez: [Namez(code: 'ar', value: 'مطروح',),],),
  Province(areas: geebAreasByProvince('South Sinai'),iso3: 'egy', name: 'South Sinai', namez: [Namez(code: 'ar', value: 'سيناء',),],),
  Province(areas: geebAreasByProvince('NorthCoast'),iso3: 'egy', name: 'NorthCoast', namez: [Namez(code: 'ar', value: 'الساحل الشمالي',),],),
  Province(areas: geebAreasByProvince('Al Riyadh'),iso3: 'sau', name: 'Al Riyadh', namez: [Namez(code: 'ar', value: 'الرياض',),],),
  Province(areas: geebAreasByProvince('Jeddah'),iso3: 'sau', name: 'Jeddah', namez: [Namez(code: 'ar', value: 'جدة',),],),
  Province(areas: geebAreasByProvince('Al Dammam'),iso3: 'sau', name: 'Al Dammam', namez: [Namez(code: 'ar', value: 'الدمام',),],),
  Province(areas: geebAreasByProvince('Al Khobar'),iso3: 'sau', name: 'Al Khobar', namez: [Namez(code: 'ar', value: 'الخبر',),],),
  Province(areas: geebAreasByProvince('Al Duwadimi'),iso3: 'sau', name: 'Al Duwadimi', namez: [Namez(code: 'ar', value: 'الدوادمي',),],),
  Province(areas: geebAreasByProvince('Shaqra'),iso3: 'sau', name: 'Shaqra', namez: [Namez(code: 'ar', value: 'شقراء',),],),
  Province(areas: geebAreasByProvince('Al Kharj'),iso3: 'sau', name: 'Al Kharj', namez: [Namez(code: 'ar', value: 'الخرج',),],),
  Province(areas: geebAreasByProvince('Wadi Al Dawasir'),iso3: 'sau', name: 'Wadi Al Dawasir', namez: [Namez(code: 'ar', value: 'وادي الدواسر',),],),
  Province(areas: geebAreasByProvince('Al Qutaif'),iso3: 'sau', name: 'Al Qutaif', namez: [Namez(code: 'ar', value: 'القطيف',),],),
  Province(areas: geebAreasByProvince('Anak'),iso3: 'sau', name: 'Anak', namez: [Namez(code: 'ar', value: 'عنك',),],),
  Province(areas: geebAreasByProvince('Khamis Mushait'),iso3: 'sau', name: 'Khamis Mushait', namez: [Namez(code: 'ar', value: 'خميس مشيط',),],),
  Province(areas: geebAreasByProvince('Hafar Al Batin'),iso3: 'sau', name: 'Hafar Al Batin', namez: [Namez(code: 'ar', value: 'حفر الباطن',),],),
  Province(areas: geebAreasByProvince('Najran'),iso3: 'sau', name: 'Najran', namez: [Namez(code: 'ar', value: 'نجران',),],),
  Province(areas: geebAreasByProvince('Makkah Al Mukarrama'),iso3: 'sau', name: 'Makkah Al Mukarrama', namez: [Namez(code: 'ar', value: 'مكة المكرمة',),],),
  Province(areas: geebAreasByProvince('Jazan'),iso3: 'sau', name: 'Jazan', namez: [Namez(code: 'ar', value: 'جازان',),],),
  Province(areas: geebAreasByProvince('Al Dhahran'),iso3: 'sau', name: 'Al Dhahran', namez: [Namez(code: 'ar', value: 'الظهران',),],),
  Province(areas: geebAreasByProvince('Al Madina Al Munawara'),iso3: 'sau', name: 'Al Madina Al Munawara', namez: [Namez(code: 'ar', value: 'المدينة المنورة',),],),
  Province(areas: geebAreasByProvince('Al Ehsaa'),iso3: 'sau', name: 'Al Ehsaa', namez: [Namez(code: 'ar', value: 'الاحساء',),],),
  Province(areas: geebAreasByProvince('Buraydah'),iso3: 'sau', name: 'Buraydah', namez: [Namez(code: 'ar', value: 'بريدة',),],),
  Province(areas: geebAreasByProvince('Unayzah'),iso3: 'sau', name: 'Unayzah', namez: [Namez(code: 'ar', value: 'عنيزه',),],),
  Province(areas: geebAreasByProvince('Hail'),iso3: 'sau', name: 'Hail', namez: [Namez(code: 'ar', value: 'حائل',),],),
  Province(areas: geebAreasByProvince('Al Taif'),iso3: 'sau', name: 'Al Taif', namez: [Namez(code: 'ar', value: 'الطائف',),],),
  Province(areas: geebAreasByProvince('Abha'),iso3: 'sau', name: 'Abha', namez: [Namez(code: 'ar', value: 'أبها',),],),
];