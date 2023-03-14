
import 'package:flutter/material.dart';
import 'package:personal_expenses/components/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

			double totalSum = 0.0;

			for(var i = 0; i < recentTransactions.length; i++) {
				bool isSameDay = recentTransactions[i].date.day == weekDay.day;
				bool isSameMonth = recentTransactions[i].date.month == weekDay.month;
				bool isSameYear = recentTransactions[i].date.year == weekDay.year;
			
				if(isSameDay && isSameMonth && isSameYear) {
					totalSum += recentTransactions[i].value;
				}
			}

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

	double get _weekTotalValue {
		return groupedTransactions.fold(0.0, (sum, tr) {
			return sum + (tr['value'] as double);
		});
	}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
					return Flexible(
						fit: FlexFit.tight,
						child: ChartBar(
							label: tr['day'] as String, 
							value: tr['value'] as double,
							percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue,
						),
					);
				}).toList(),
        ),
      ),
    );
  }
}
