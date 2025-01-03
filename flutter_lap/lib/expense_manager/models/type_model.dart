import 'package:flutter_lap/expense_manager/models/cost_model.dart';

class TypeModel {
  final String? name;
  final double? maxAmount;
  final List<CostModel>? expenses;

  TypeModel({this.name, this.maxAmount, this.expenses});
}
