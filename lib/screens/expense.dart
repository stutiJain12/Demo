// main.dart
import 'package:demo/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Expense class is now in models/expense_model.dart

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ExpenseHomePage(),
    );
  }
}

class ExpenseHomePage extends StatefulWidget {
  const ExpenseHomePage({super.key});
  @override
  State<ExpenseHomePage> createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  late Box<Expense> _expenseBox;

  @override
  void initState() {
    super.initState();
    _expenseBox = Hive.box<Expense>('expenses');
  }

  void _addOrEditExpense({Expense? existingExpense}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddEditExpenseScreen(expense: existingExpense),
      ),
    );

    if (result != null && result is Expense) {
      if (existingExpense == null) {
        // Add new
        await _expenseBox.add(result);
      } else {
        // Edit existing
        if (existingExpense.isInBox) {
          existingExpense.title = result.title;
          existingExpense.amount = result.amount;
          existingExpense.date = result.date;
          existingExpense.category = result.category;
          await existingExpense.save();
        }
      }
      setState(() {});
    }
  }

  void _deleteExpense(Expense expense) {
    expense.delete();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _expenseBox.listenable(),
      builder: (context, Box<Expense> box, _) {
        final expenses = box.values.toList().cast<Expense>();
        final total = expenses.fold(0.0, (sum, e) => sum + e.amount);

        return Scaffold(
          body: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                          icon:
                              const Icon(Icons.add, color: Colors.blueAccent),
                          onPressed: () => _addOrEditExpense(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 20),
                padding: const EdgeInsets.symmetric(
                    vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Text(
                  'Total: ₹${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: expenses.isEmpty
                    ? const Center(child: Text('No expenses yet'))
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: expenses.length,
                        itemBuilder: (ctx, i) {
                          final e = expenses[i];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.indigo.shade50,
                                child: Text(
                                  e.category.isNotEmpty
                                      ? e.category[0]
                                      : '?',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                              ),
                              title: Text(
                                e.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                    '${e.category} • ${e.date.toString().substring(0, 10)}'),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('₹${e.amount.toStringAsFixed(2)}'),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _deleteExpense(e),
                                  ),
                                ],
                              ),
                              onTap: () =>
                                  _addOrEditExpense(existingExpense: e),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// 🔹 Add / Edit Screen (same as before)
class AddEditExpenseScreen extends StatefulWidget {
  final Expense? expense;
  const AddEditExpenseScreen({super.key, this.expense});

  @override
  State<AddEditExpenseScreen> createState() =>
      _AddEditExpenseScreenState();
}

class _AddEditExpenseScreenState extends State<AddEditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _amountCtrl;
  DateTime _selectedDate = DateTime.now();
  String _category = 'Food';

  final _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _titleCtrl =
        TextEditingController(text: widget.expense?.title ?? '');
    _amountCtrl = TextEditingController(
        text: widget.expense?.amount.toString() ?? '');
    if (widget.expense != null) {
      _selectedDate = widget.expense!.date;
      _category = widget.expense!.category;
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.expense == null
              ? 'Add Expense'
              : 'Edit Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration:
                    const InputDecoration(labelText: 'Title'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Amount'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                value: _category,
                items: _categories
                    .map((c) => DropdownMenuItem(
                        value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Picked Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_today, color: Colors.indigo),
                    label: const Text(
                      'Choose Date',
                      style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final expense = Expense(
                      id: widget.expense?.id ??
                          DateTime.now().toString(),
                      title: _titleCtrl.text,
                      amount:
                          double.parse(_amountCtrl.text),
                      date: _selectedDate,
                      category: _category,
                    );
                    Navigator.pop(context, expense);
                  }
                },
                child:
                    Text(widget.expense == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
