import 'package:budget_bee/model/transaction_model.dart';
import 'package:budget_bee/screens/add_transaction_screen.dart';
import 'package:budget_bee/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Finance Tracker'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddTransactionScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<TransactionModel>>(
          future: context.read<DatabaseService>().fetchTransaction(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error : ${snapshot.error.toString()}'),
              );
            }

            final transactions = snapshot.data!;
            return ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final transaction = transactions[index];
                  return Card(
                      child: ListTile(
                    title: Text(transaction.title),
                    subtitle: Text(
                        transaction.date.toLocal().toString().split('')[0]),
                    trailing:
                        Text('\$${transaction.amount.toStringAsFixed(2)}'),
                  ));
                });
          }),
    );
  }
}
