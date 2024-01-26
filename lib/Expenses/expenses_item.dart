import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class expense_item extends StatelessWidget {
  const expense_item(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              expense.title,
            ),
            Row(
              children: [
                Text(
                  '\PKR ${expense.amount.toStringAsFixed(1)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      catergoryIcons[expense.category],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(expense.formmateddate)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
