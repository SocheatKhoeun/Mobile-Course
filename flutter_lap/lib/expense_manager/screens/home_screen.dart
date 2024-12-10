import 'package:flutter/material.dart';
import 'package:flutter_lap/expense_manager/constants.dart';
import 'package:flutter_lap/expense_manager/data/data.dart';
import 'package:flutter_lap/expense_manager/models/cost_model.dart';
import 'package:flutter_lap/expense_manager/models/type_model.dart';
import 'package:flutter_lap/expense_manager/screens/detail_screen.dart';
import 'package:flutter_lap/expense_manager/widgets/custom_chart.dart';
import 'package:flutter_lap/expense_manager/widgets/icon_btn.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) {
                  return _buildChartContainer();
                } else {
                  final TypeModel typeModel = typeNames[index - 1];
                  double tAmountSpent = _calculateAmountSpent(typeModel);
                  return _buildCategories(typeModel, tAmountSpent);
                }
              },
              childCount: 1 + typeNames.length,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build AppBar
  Widget _buildAppBar() {
    return SliverAppBar(
      forceElevated: true,
      floating: true,
      expandedHeight: 10.h,
      leading: CustomBtn(
        onPress: () {},
        iconData: Icons.settings_outlined,
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'My Budget',
          style: TextStyle(
            fontSize: 12.sp,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w500,
            color: kTextColor,
          ),
        ),
      ),
      actions: [
        CustomBtn(
          onPress: () {},
          iconData: Icons.add_outlined,
        ),
      ],
    );
  }

  // Helper method to build Chart Container
  Widget _buildChartContainer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(3.h),
      ),
      child: CustomChart(
        expenses: weeklySpending,
      ),
    );
  }

  // Helper method to calculate total amount spent
  double _calculateAmountSpent(TypeModel typeModel) {
    double tAmountSpent = 0;
    typeModel.expenses?.forEach((CostModel expense) {
      tAmountSpent += expense.cost ?? 0;
    });
    return tAmountSpent;
  }

  // Helper method to build Categories
  Widget _buildCategories(TypeModel category, double tAmountSpent) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(typeModel: category),
          ),
        );
      },
      child: Container(
        width: 100.w,
        height: 13.h,
        margin: kMargin,
        padding: kPadding,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: kRadius,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  '\$${(category.maxAmount! - tAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildProgressBar(category, tAmountSpent),
          ],
        ),
      ),
    );
  }

  // Helper method to build Progress Bar
  Widget _buildProgressBar(TypeModel category, double tAmountSpent) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxBarWidth = constraints.maxWidth;
        final double percentage =
            (category.maxAmount! - tAmountSpent) / category.maxAmount!;
        final double width = (percentage * maxBarWidth).clamp(0, maxBarWidth);

        return Stack(
          children: [
            Container(
              height: 3.h,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(2.h),
              ),
            ),
            Container(
              height: 3.h,
              width: width,
              decoration: BoxDecoration(
                color: setupColor(percentage),
                borderRadius: BorderRadius.circular(2.h),
              ),
            ),
          ],
        );
      },
    );
  }
}
