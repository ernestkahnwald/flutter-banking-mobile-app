import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './bar.dart';
import 'package:src/model/transaction.dart';

class Chart extends StatelessWidget {
  static const days = 7;
  final List<Transaction> transactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(days, (index) {
      final nowDate = DateUtils.dateOnly(DateTime.now());
      final weekDay = nowDate.subtract(Duration(days: index));
      double totalSum = 0;

      for (var transaction in transactions) {
        if (transaction.date.difference(weekDay).inDays == 0) {
          totalSum += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).toString(),
        'amount': totalSum,
      };
    });
  }

  double get maxSpending => groupedTransactions.fold(
    0,
    (sum, group) => sum + (group['amount'] as double),
  );

  const Chart(this.transactions, { Key? key }) : super(key: key);

  double getPercent(double value) => maxSpending == 0 ? 0 : value / maxSpending;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactions
            .reversed
            .map((group) => Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                group['day'].toString()[0],
                group['amount'] as double,
                getPercent(group['amount'] as double),
              ),
            ))
            .toList(),
        ),
      ),
    );
  }
}
