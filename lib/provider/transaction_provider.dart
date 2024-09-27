import 'package:budget_bee/model/transaction_model.dart';
import 'package:budget_bee/services/database_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transaction = []; //List of transcation
  final DatabaseService _databaseService =
      DatabaseService(); //instance of database service

  //Getter for transaction
  List<TransactionModel> get trasactions => _transaction;

  //Method to add a transaction
  Future<void> addTransaction(TransactionModel transactionModel) async {
    await _databaseService
        .insertTransaction(transactionModel); //Insert transaction into database
    _transaction.add(transactionModel); //Add Transaction  to local list
    notifyListeners(); //Notify listeners to update UI
  }

  //Method to load transaction  from the database
  Future<void> loadTransaction() async {
    _transaction = await _databaseService
        .fetchTransaction(); //fetch transaction from database
    notifyListeners(); //notify listeners  to update UIl̥
  }
}
