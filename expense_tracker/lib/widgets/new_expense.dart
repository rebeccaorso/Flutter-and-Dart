import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Import del modello Expense con alias per evitare ambiguità con 'Category' di foundation.dart
import 'package:expense_tracker/models/expense.dart' as model;

// Formatter per la visualizzazione della data (es: 12 maggio 2025)
final formatter = DateFormat.yMMMMd();

// Schermata per l'aggiunta di una nuova spesa
class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense, // Funzione callback chiamata quando l'utente preme "Salva"
  });

  final void Function(model.Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // Controller per leggere il testo digitato dall'utente
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // Stato attuale della data e della categoria selezionata
  DateTime? _selectedDate;
  model.Category _selectedCategory = model.Category.piacere;

  // Mostra un selettore di data (popup)
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day); 

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate; // aggiorna lo stato con la data scelta
    });
  }

  // Verifica i dati inseriti, crea un oggetto Expense e lo passa al callback
  void _submitExpenseDate() {
    final enteredAmount = double.tryParse(_amountController.text); // tenta conversione a double
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // Se qualche campo non è valido, mostra un dialogo di errore
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Input non valido'),
          content: const Text(
              'Assicurati di inserire correttamente titolo, costo e data'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    // Costruzione e invio della spesa al componente genitore
    widget.onAddExpense(
      model.Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    // Chiude il bottom sheet dopo il salvataggio
    Navigator.pop(context);
  }

  // Rilascio delle risorse usate dai controller quando il widget viene distrutto
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Costruzione della UI
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 68, 16, 16), // padding extra in alto per evitare tastiera
      child: Column(
        children: [
          // Campo input per il titolo della spesa
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Titolo')),
          ),

          // Riga contenente l'importo e il selettore data
          Row(
            children: [
              Expanded(
                // Campo input per il costo
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '€',
                    label: Text('Costo'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                // Mostra la data selezionata o un testo placeholder
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No data selezionata'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Riga con dropdown categoria + pulsanti
          Row(
            children: [
              // Menu a tendina per la categoria della spesa
              DropdownButton<model.Category>(
                value: _selectedCategory,
                items: model.Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name), // Usa il nome leggibile dell'enum
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),

              const Spacer(), // Spinge i pulsanti verso il bordo destro

              // Pulsante per annullare e chiudere la modale
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annulla'),
              ),

              // Pulsante per salvare i dati inseriti
              ElevatedButton(
                onPressed: _submitExpenseDate,
                child: const Text('Salva'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
