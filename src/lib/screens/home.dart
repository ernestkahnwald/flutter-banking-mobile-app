import 'package:flutter/material.dart';

import 'package:src/model/transaction.dart';
import 'package:src/widgets/chart/chart.dart';
import 'package:src/widgets/transactions/add_transaction.dart';
import 'package:src/widgets/transactions/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'tr1',
      amount: 79.9,
      date: DateTime.now(),
    ),
    Transaction(
      id: '2',
      title: 'tr2',
      amount: 302.31,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: '3',
      title: 'tr3',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: '4',
      title: 'tr4',
      amount: 30,
      date: DateTime.now(),
    ),
    Transaction(
      id: '5',
      title: 'tr5',
      amount: 30,
      date: DateTime.now(),
    ),
    Transaction(
      id: '6',
      title: 'tr6',
      amount: 50,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    final nowDate = DateUtils.dateOnly(
      DateTime.now().subtract(const Duration(days: 7))
    );
    return _transactions
      .where((transaction) => DateUtils.dateOnly(transaction.date).isAfter(nowDate))
      .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    setState(() => _transactions.add(Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    )));
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void startAddingNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => GestureDetector(
        onTap: () {},
        child: AddTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Banking'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Chart(_recentTransactions),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TransactionList(_transactions.reversed.toList(), _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => startAddingNewTransaction(context),
      ),
    );
  }
}
