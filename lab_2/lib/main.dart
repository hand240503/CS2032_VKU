import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản Lý Chi Tiêu',
      theme: ThemeData(primarySwatch: Colors.green),
      home: ExpenseHomePage(),
    );
  }
}

class ExpenseHomePage extends StatefulWidget {
  @override
  _ExpenseHomePageState createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  double totalBalance = 0.0;
  List<Map<String, dynamic>> transactions = [];

  void _addTransaction(String title, double amount, bool isIncome) {
    setState(() {
      totalBalance += isIncome ? amount : -amount;
      transactions.add({
        'title': title,
        'amount': amount,
        'isIncome': isIncome,
        'date': DateTime.now(),
      });
    });
  }

  void _showAddTransactionDialog() {
    final _titleController = TextEditingController();
    final _amountController = TextEditingController();
    bool isIncome = true;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Thêm Giao Dịch'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Số tiền'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Text('Thu nhập'),
                Switch(
                  value: isIncome,
                  onChanged: (value) {
                    setState(() {
                      isIncome = value;
                    });
                  },
                ),
                Text('Chi tiêu'),
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_titleController.text.isNotEmpty && _amountController.text.isNotEmpty) {
                _addTransaction(
                  _titleController.text,
                  double.parse(_amountController.text),
                  isIncome,
                );
                Navigator.of(ctx).pop();
              }
            },
            child: Text('Thêm'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản Lý Chi Tiêu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Số dư hiện tại: \$${totalBalance.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tx = transactions[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        tx['isIncome'] ? Icons.arrow_downward : Icons.arrow_upward,
                        color: tx['isIncome'] ? Colors.green : Colors.red,
                      ),
                      title: Text(tx['title']),
                      subtitle: Text('${tx['date'].toLocal()}'),
                      trailing: Text(
                        '${tx['isIncome'] ? '+' : '-'}\$${tx['amount'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: tx['isIncome'] ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
