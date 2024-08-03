import 'package:flutter/material.dart';
import 'package:job_journey/features/company/models/category.dart';

const Color blue = Color(0xff3D5DF8);
const Color lightBlue = Color(0xff0C1332);


// const Color darkPurple = Color.fromARGB(255, 236, 189, 31);
const Color darkGray = Color.fromARGB(255, 10, 10, 10);
const Color onbackground = Color.fromARGB(255, 0, 0, 0);
const Color background = Color.fromARGB(255, 0, 0, 0);
const Color white = Color(0xffffffff);
const Color lightBlue = Color.fromARGB(255, 124, 145, 250);
const Color gray = Color.fromARGB(255, 224, 223, 223);

const String font = 'Tajawal';

const TextStyle smallTextStyle = TextStyle(color: white, fontFamily: font, fontSize: 12);

const TextStyle meduimTextStyle = TextStyle(color: white, fontFamily: font, fontSize: 14);

const TextStyle largTextStyle = TextStyle(color: white, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold);

const TextStyle appBarTextStyle = TextStyle(color: white, fontFamily: font, fontWeight: FontWeight.bold, fontSize: 16);

const sizedBoxSmall = SizedBox(height: 10);

const sizedBoxMedium = SizedBox(height: 20);

const sizedBoxLarge = SizedBox(height: 30);

List<String> cities = [
  'حمص',
  'حماة',
  'دمشق',
  'ريف دمشق',
  'حلب',
  'الحسكة',
  'دير الزور',
  'القامشلي',
  'طرطوس',
  'اللاذقية',
  'درعا',
];

const List<String> jobTypes = ['دوام كامل', 'دوام جزئي', 'تدريب'];
const List<String> jobTypesEn = ['part time', 'full time', 'internal ship'];

const List<Category> categories = [
  Category(id: 1, name: 'الدعم الإداري والمكتبي', enName: 'Administrative & Office Support'),
  Category(id: 2, name: 'خدمة العملاء', enName: 'Customer Service'),
  Category(id: 3, name: 'المالية والمحاسبة', enName: 'Finance & Accounting'),
  Category(id: 4, name: 'الموارد البشرية', enName: 'Human Resources'),
  Category(id: 5, name: 'تكنولوجيا المعلومات', enName: 'Information Technology'),
  Category(id: 6, name: 'التسويق والمبيعات', enName: 'Marketing & Sales'),
  Category(id: 7, name: 'الرعاية الصحية والطب', enName: 'Healthcare & Medical'),
  Category(id: 8, name: 'الهندسة', enName: 'Engineering'),
  Category(id: 9, name: 'التعليم والتدريب', enName: 'Education & Training'),
  Category(id: 10, name: 'التصنيع والإنتاج', enName: 'Manufacturing & Production'),
  Category(id: 11, name: 'اللوجستيات وسلسلة التوريد', enName: 'Logistics & Supply Chain'),
  Category(id: 12, name: 'الضيافة والسياحة', enName: 'Hospitality & Tourism'),
  Category(id: 13, name: 'التجزئة', enName: 'Retail'),
  Category(id: 14, name: 'القانون', enName: 'Legal'),
  Category(id: 15, name: 'الإبداع والتصميم', enName: 'Creative & Design'),
  Category(id: 16, name: 'البناء والحرف', enName: 'Construction & Trades'),
  Category(id: 17, name: 'العلوم والبحوث', enName: 'Science & Research'),
  Category(id: 18, name: 'إدارة العمليات والمشاريع', enName: 'Operations & Project Management'),
  Category(id: 19, name: 'العقارات', enName: 'Real Estate'),
  Category(id: 20, name: 'النقل والتوصيل', enName: 'Transportation & Delivery'),
];

const List<Category> industries = [
  Category(id: 1, name: 'التكنولوجيا', enName: 'Technology'),
  Category(id: 2, name: 'المالية', enName: 'Finance'),
  Category(id: 3, name: 'الرعاية الصحية', enName: 'Healthcare'),
  Category(id: 4, name: 'التجزئة', enName: 'Retail'),
  Category(id: 5, name: 'التصنيع', enName: 'Manufacturing'),
  Category(id: 6, name: 'النقل واللوجستيات', enName: 'Transportation and Logistics'),
  Category(id: 7, name: 'الطاقة', enName: 'Energy'),
  Category(id: 8, name: 'الاتصالات', enName: 'Telecommunications'),
  Category(id: 9, name: 'العقارات', enName: 'Real Estate'),
  Category(id: 10, name: 'التعليم', enName: 'Education'),
  Category(id: 11, name: 'الضيافة والسياحة', enName: 'Hospitality and Tourism'),
  Category(id: 12, name: 'الوسائط والترفيه', enName: 'Media and Entertainment'),
  Category(id: 13, name: 'الزراعة', enName: 'Agriculture'),
  Category(id: 14, name: 'السيارات', enName: 'Automotive'),
  Category(id: 15, name: 'الفضاء والدفاع', enName: 'Aerospace and Defense'),
  Category(id: 16, name: 'البناء', enName: 'Construction'),
  Category(id: 17, name: 'الأدوية', enName: 'Pharmaceuticals'),
  Category(id: 18, name: 'الأغذية والمشروبات', enName: 'Food and Beverage'),
  Category(id: 19, name: 'التأمين', enName: 'Insurance'),
  Category(id: 20, name: 'الخدمات القانونية', enName: 'Legal Services'),
];
