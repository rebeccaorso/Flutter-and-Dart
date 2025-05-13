import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

// Widget per visualizzare il grafico delle spese suddiviso per categoria
class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses}); // Costruttore che riceve la lista delle spese

  final List<Expense> expenses; // Lista delle spese passata al widget

  // Funzione che ritorna una lista di "bucket" (categorie di spese)
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.cibo), 
      ExpenseBucket.forCategory(expenses, Category.piacere),
      ExpenseBucket.forCategory(expenses, Category.viaggi),
      ExpenseBucket.forCategory(expenses, Category.lavoro),
    ];
  }

  // Funzione che calcola l'importo massimo tra tutte le spese
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses; // Aggiorna il massimo
      }
    }

    return maxTotalExpense; // Ritorna il massimo
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se il tema dell'app è in modalità scura
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Layout principale del grafico
    return Container(
      margin: const EdgeInsets.all(16), // Distanza attorno al grafico
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8, 
      ),
      width: double.infinity, // Larghezza del container al 100%
      height: 180, // Altezza del grafico
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Raggio per arrotondare gli angoli
        gradient: LinearGradient(
          colors: [
            // Definizione di un gradiente per lo sfondo
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter, // Partenza del gradiente (dal basso)
          end: Alignment.topCenter, // Fine del gradiente (verso l'alto)
        ),
      ),
      child: Column(
        children: [
          Expanded(
            // Mostra le barre del grafico
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // Itera sui bucket delle spese
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense, // Calcola la proporzione
                  )
              ],
            ),
          ),
          const SizedBox(height: 12), // Spaziatura tra il grafico e le icone
          Row(
            // Mostra le icone per ogni categoria
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category], // Icona della categoria
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary // Colore per tema scuro
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7), // Colore per tema chiaro
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
