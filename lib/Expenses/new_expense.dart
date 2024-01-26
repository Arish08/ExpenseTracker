import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class newExpense extends StatefulWidget {
  const newExpense(this.onselectadd, {super.key});

  final void Function(Expense expense) onselectadd;

  @override
  State<newExpense> createState() => _newExpenseState();
}

class _newExpenseState extends State<newExpense> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? Selected_Date;
  Category selectedcategory = Category.leisure;

  void presenterror() {
    final enteredAmount = double.tryParse(amountcontroller.text);
    final amountisvalid = enteredAmount == null || enteredAmount < 0;

    if (titlecontroller.text.trim().isEmpty ||
        amountisvalid ||
        Selected_Date == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content:
              const Text('Please Make Sure To Input All the Correct Values'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Close'))
          ],
        ),
      );
      return;
    }
    Navigator.pop(context);
    widget.onselectadd(
      Expense(titlecontroller.text, enteredAmount, Selected_Date!,
          selectedcategory),
    );
  }

  void showdate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, now.month, now.day);

    final datePicker = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      Selected_Date = datePicker;
    });
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: titlecontroller,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefix: Text('PKR '),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(Selected_Date == null
                        ? 'No Date Selected'
                        : formatter.format(Selected_Date!)),
                    IconButton(
                        onPressed: showdate,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedcategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(
                    () {
                      selectedcategory = value;
                    },
                  );
                },
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  presenterror();
                },
                child: const Text(
                  'Save Expense',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
