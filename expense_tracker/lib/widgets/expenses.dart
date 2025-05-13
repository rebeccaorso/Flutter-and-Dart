import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

// Widget principale che gestisce la lista delle spese
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // Lista delle spese attualmente registrate (inizialmente con alcuni esempi)
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Corso flutter', amount: 19.99, date: DateTime.now(), category: Category.lavoro),
    Expense(title: 'Latte avena', amount: 2.89, date: DateTime.now(), category: Category.cibo),
    Expense(title: 'Cinema', amount: 10.99, date: DateTime.now(), category: Category.piacere),
  ];

  // Apre il bottom sheet per aggiungere una nuova spesa
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  // Aggiunge una nuova spesa alla lista
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // Rimuove una spesa e offre l’opzione di annullamento tramite SnackBar
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Eliminato'),
        action: SnackBarAction(
          label: 'Annulla',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mostra un messaggio se la lista è vuota, altrimenti la lista
    Widget mainContent = const Center(
      child: Text('Nessun dato trovato. Aggiungine!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    // UI principale
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
         Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent), // Lista o messaggio
        ],
      ),
    );
  }
}
