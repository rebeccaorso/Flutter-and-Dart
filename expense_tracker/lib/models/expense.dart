import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMMMMd();

final uuid = Uuid();

enum Category { cibo, viaggi, piacere, lavoro }

const categoryIcons = {
  Category.cibo: Icons.lunch_dining,
  Category.viaggi: Icons.travel_explore,
  Category.piacere: Icons.catching_pokemon_sharp,
  Category.lavoro: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
  : expenses = allExpenses.where((expense)=> expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for(final expense in expenses ) {
      sum += expense.amount; // sum = sum + expense.amount;
    }

    return sum;
  }
}
