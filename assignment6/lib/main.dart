import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assignment6/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  DatabaseHelper dbHelper = DatabaseHelper(); // Create an instance of DatabaseHelper

  // Controllers for form inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _transactionType = 'income'; // Default transaction type
  bool _isRecurring = false; // Default recurring status

  @override
  void initState() {
    super.initState();
  }

  // Function to handle form submission and save to Firestore
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      double amount = double.parse(_amountController.text);

      // Await saving the transaction before updating balance
      await dbHelper.addTransaction(
        _nameController.text,
        amount,
        _transactionType,
        _isRecurring,
      );

      // Clear the form after submission
      _clearForm();
    }
  }

  // Clear form after submission
  void _clearForm() {
    _nameController.clear();
    _amountController.clear();
    _transactionType = 'income';
    _isRecurring = false;
    setState(() {});
  }

  // Calculate balance based on real-time updates from Firestore
  double _calculateBalance(List<QueryDocumentSnapshot<Map<String, dynamic>>> transactions) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Listen to real-time changes in Firestore and update the balance accordingly
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('transactions').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error fetching transactions');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                // Calculate balance based on real-time data
                double balance = _calculateBalance(snapshot.data!.docs);

                return Text(
                  'Balance: \$${balance.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name input field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Transaction Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // Amount input field
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // Transaction type (Income/Expense) using a Dropdown
                  DropdownButtonFormField<String>(
                    value: _transactionType,
                    items: [
                      DropdownMenuItem(child: Text('Income'), value: 'income'),
                      DropdownMenuItem(child: Text('Expense'), value: 'expense'),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _transactionType = value!;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Transaction Type'),
                  ),
                  SizedBox(height: 10),
                  // Recurring status checkbox
                  CheckboxListTile(
                    title: Text('Is Recurring?'),
                    value: _isRecurring,
                    onChanged: (value) {
                      setState(() {
                        _isRecurring = value!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // Submit button
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
