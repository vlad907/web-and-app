import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: ExpenseForm(),
    );
  }
}

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  // Insert expense into the database
  void _addExpense() async {
    if (_formKey.currentState!.validate()) {
      String description = _descriptionController.text;
      double amount = double.parse(_amountController.text);

      Map<String, dynamic> row = {
        DatabaseHelper.columnDescription: description,
        DatabaseHelper.columnAmount: amount
      };
      
      await DatabaseHelper.instance.insert(row);

      // Clear the fields after saving
      _descriptionController.clear();
      _amountController.clear();

      setState(() {});
    }
  }

  // Fetch expenses from the database
  Future<List<Map<String, dynamic>>> _fetchExpenses() async {
    return await DatabaseHelper.instance.queryAllRows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addExpense,
                    child: Text('Add Expense'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchExpenses(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final expenses = snapshot.data!;
                  return ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(expenses[index]['description']),
                        subtitle: Text('Amount: \$${expenses[index]['amount']}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
