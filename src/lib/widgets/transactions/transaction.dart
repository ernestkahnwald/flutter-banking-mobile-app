import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:src/model/transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction _transaction;
  final Function _onDelete;

  const TransactionWidget(this._transaction, this._onDelete, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Text(
                '\$${_transaction.amount.toString()}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        title: Text(_transaction.title),
        subtitle: Text(
          DateFormat(DateFormat.HOUR24_MINUTE).format(_transaction.date),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => _onDelete(_transaction.id),
        ),
      ),
    );
  }
}
