import 'package:flutter/material.dart';

import './transaction.dart';

import 'package:src/model/transaction.dart' as tmodels;

class TransactionList extends StatelessWidget {
  final List<tmodels.Transaction> _transactions;
  final EdgeInsets margin;
  final Function _onDelete;

  const TransactionList(
    this._transactions,
    this._onDelete,
    {this.margin = const EdgeInsets.only(), Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
      ? Image.asset('assets/images/no-items.jpeg')
      : ListView.builder(
        itemBuilder: (ctx, index) => Container(
          margin: margin,
          child: TransactionWidget(_transactions[index], _onDelete),
        ),
        itemCount: _transactions.length,
      );
  }
}
