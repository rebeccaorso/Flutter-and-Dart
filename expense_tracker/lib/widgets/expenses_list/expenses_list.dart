import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

// Widget per la lista di spese, usa Dismissible per permettere lo swipe-to-delete
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key, 
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        // Aggiungi il background con la scritta "Elimina"
        background: Stack(
          alignment: Alignment.center, 
          children: [
            // Colore di sfondo rosso
            Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal
              ),
            ),
            // Testo "Elimina" centrato sopra il colore di sfondo
            Positioned(
              child: Text(
                'Elimina',
                style: TextStyle(
                  color: Colors.white, // Colore del testo
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
