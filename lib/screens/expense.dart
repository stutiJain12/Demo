import 'package:demo/models/expense_model.dart';
import 'package:demo/components/index.dart';
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
          body: CustomColumn(
            children: [
              CustomSafeArea(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: CustomRow(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(
                      icon: Icons.add,
                      size: 50,
                      iconSize: 30,
                      color: Colors.blueAccent,
                      border: Border.all(color: Colors.blueAccent, width: 2),
                      onPressed: () => _addOrEditExpense(),
                    ),
                  ],
                ),
              ),
              CustomContainer(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                color: Colors.blueAccent,
                borderRadius: 20,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
                child: CustomText(
                  'Total: ₹${total.toStringAsFixed(2)}',
                  style: CustomTextStyle.heading,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: CommonListView<Expense>(
                  items: expenses,
                  emptyMessage: 'No expenses yet',
                  emptyIcon: Icons.account_balance_wallet_outlined,
                  itemBuilder: (ctx, e, i) {
                    return CustomListTile(
                      leading: CircleAvatar(
                        radius: 25,
                          backgroundColor: Colors.blue.shade50,
                          child: CustomText(
                            e.category.isNotEmpty ? e.category[0] : '?',
                            style: CustomTextStyle.bodyBold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        title: e.title,
                        subtitle: CustomText(
                          '${e.category} • ${e.date.toString().substring(0, 10)}',
                          style: CustomTextStyle.subtitle,
                        ),
                        trailing: CustomRow(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 8,
                          children: [
                            CustomText(
                              '₹${e.amount.toStringAsFixed(2)}',
                              style: CustomTextStyle.bodyBold,
                              color: Colors.blueAccent,
                            ),
                          CustomIconButton(
                            icon: Icons.delete,
                            color: Colors.red,
                            onPressed: () => _deleteExpense(e),
                          ),
                        ],
                      ),
                      onTap: () => _addOrEditExpense(existingExpense: e),
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
  State<AddEditExpenseScreen> createState() => _AddEditExpenseScreenState();
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
    _titleCtrl = TextEditingController(text: widget.expense?.title ?? '');
    _amountCtrl =
        TextEditingController(text: widget.expense?.amount.toString() ?? '');
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
      appBar: CustomAppBar(
        title: widget.expense == null ? 'Add Expense' : 'Edit Expense',
      ),
      body: CommonScrollView(
        padding: const EdgeInsets.all(16),
        child: CustomForm(
          formKey: _formKey,
          children: [
            CustomTextField(
              controller: _titleCtrl,
              label: 'Title',
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            CustomTextField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              label: 'Amount',
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            CustomDropdown<String>(
              value: _category,
              label: 'Category',
              items: _categories,
              itemBuilder: (c) => CustomText(c),
              onChanged: (v) => setState(() => _category = v!),
            ),
            CustomDatePicker(
              selectedDate: _selectedDate,
              onDateSelected: (date) => setState(() => _selectedDate = date),
              activeColor: Colors.blueAccent,
              lastDate: DateTime.now(),
            ),
            CustomButton(
              text: widget.expense == null ? 'Add' : 'Save',
              color: Colors.blueAccent,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final expense = Expense(
                    id: widget.expense?.id ?? DateTime.now().toString(),
                    title: _titleCtrl.text,
                    amount: double.parse(_amountCtrl.text),
                    date: _selectedDate,
                    category: _category,
                  );
                  Navigator.pop(context, expense);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
