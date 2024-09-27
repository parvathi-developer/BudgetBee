import 'package:budget_bee/model/transaction_model.dart';
import 'package:budget_bee/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  _AddTransactionScreen createState() => _AddTransactionScreen();
}

class _AddTransactionScreen extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_selectedDate == null
                    ? 'No Date Choosen!'
                    : 'Picked Date:${_selectedDate!.toLocal()}'.split('')[0]),
                TextButton(
                    onPressed: _onPressedDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            ElevatedButton(
                onPressed: _submitData, child: const Text('Add transaction'))
          ],
        ),
      ),
    );
  }

  Future<void> _onPressedDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        initialDate: DateTime.now());

    if (pickedDate != null) {
      _selectedDate = pickedDate;
    }
  }

  void _submitData() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        _selectedDate == null) {
      return;
    }

    final newTransaction = TransactionModel(
        id: 0, title: title, amount: amount, date: _selectedDate!);

    Provider.of<DatabaseService>(context, listen: false)
        .insertTransaction(newTransaction);
    Navigator.of(context).pop();
  }
}
