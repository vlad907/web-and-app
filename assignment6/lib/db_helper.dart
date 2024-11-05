import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add a transaction with more data types
  Future<void> addTransaction(String name, double amount, String type, bool isRecurring) async {
    try {
      await _firestore.collection('transactions').add({
        'name': name,         // String
        'amount': amount,     // double
        'type': type,         // String ('income' or 'expense')
        'isRecurring': isRecurring,  // bool
        'date': DateTime.now(), // DateTime
      });
      print('Transaction added successfully');
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  // Function to fetch all transactions
  Future<List<Map<String, dynamic>>> getTransactions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('transactions').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }

  // Function to calculate balance
  Future<double> calculateBalance() async {
    List<Map<String, dynamic>> transactions = await getTransactions();
    double balance = 0;
    for (var transaction in transactions) {
      if (transaction['type'] == 'income') {
        balance += transaction['amount'];
      } else if (transaction['type'] == 'expense') {
        balance -= transaction['amount'];
      }
    }
    return balance;
  }
}
