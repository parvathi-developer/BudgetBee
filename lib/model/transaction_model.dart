class TransactionModel {
  final int id; // Transaction ID
  final String title; // Transaction title
  final double amount; // Transaction amount
  final DateTime date; // Transaction date

  // Constructor to create a Transaction object
  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  // Convert Transaction object to Map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID
      'title': title, // Title
      'amount': amount, // Amount
      'date': date.toIso8601String(), // Date in ISO format
    };
  }
}
