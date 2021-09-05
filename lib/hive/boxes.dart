import 'package:hive/hive.dart';

class Boxes {
  static Box getComprehensiveDeals() => Hive.box('dealsBox');
}