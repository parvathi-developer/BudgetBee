import 'package:budget_bee/model/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<TransactionModel> transactions;
  const TransactionList(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tx = transactions[index];
          return Card(
            child: ListTile(
              title: Text(tx.title),
              subtitle: Text(tx.date.toString()),
              trailing: Text('\$${tx.amount.toStringAsFixed(2)}'),
            ),
          );
        });
  }
}
