import 'package:flutter/material.dart';

// Widget che rappresenta una singola barra nel grafico
class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill, // Parametro che definisce l'altezza della barra
  });

  final double fill; // Percentuale di altezza della barra (0 a 1)

  @override
  Widget build(BuildContext context) {
    // Verifica se il tema dell'app è in modalità scura
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Layout della barra del grafico
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4), // Distanza orizzontale tra le barre
        child: FractionallySizedBox(
          heightFactor: fill, // Imposta l'altezza della barra in base al valore 'fill'
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, // Forma rettangolare
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)), // Angoli arrotondati in alto
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary // Colore per tema scuro
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65), // Colore per tema chiaro
            ),
          ),
        ),
      ),
    );
  }
}
