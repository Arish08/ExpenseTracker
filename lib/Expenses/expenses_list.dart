import 'package:expense_tracker/Expenses/expenses_item.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses_list extends StatelessWidget {
  const Expenses_list(
      {required this.OnremoveExpense, required this.expenses, super.key});

  final Function(Expense expense) OnremoveExpense;

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kColorScheme.error),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: Icon(Icons.delete_rounded),
          ),
        ),
        onDismissed: (direction) {
          OnremoveExpense(
            expenses[index],
          );
        },
        key: ValueKey(expenses[index]),
        child: expense_item(expenses[index]),
      ),
    );
  }
}
