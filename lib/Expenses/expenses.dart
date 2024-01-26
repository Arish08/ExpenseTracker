import 'package:expense_tracker/Expenses/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/Expenses/expenses_list.dart';
import 'package:flutter/material.dart';

import '../widgets/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _Registeredexpenses = [
    Expense(
      'Petrol',
      1500,
      DateTime.now(),
      Category.travel,
    ),
    Expense(
      'Cinema',
      500,
      DateTime.now(),
      Category.leisure,
    ),
  ];

  void onaddExpense(Expense expense) {
    setState(() {
      _Registeredexpenses.add(expense);
    });
  }

  void onremoveExpense(Expense expense) {
    final expenseindex = _Registeredexpenses.indexOf(expense);
    setState(
      () {
        _Registeredexpenses.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _Registeredexpenses.insert(expenseindex, expense);
              });
            }),
      ),
    );
  }

  void showoverlaysheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => newExpense(onaddExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        'No Expense Found Please Try To Add Some!',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
    if (_Registeredexpenses.isNotEmpty) {
      mainContent = Expenses_list(
        expenses: _Registeredexpenses,
        OnremoveExpense: onremoveExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: showoverlaysheet,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: _Registeredexpenses,
          ),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
