import 'dart:math'; 
import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({ super.key});


  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
    
  }
}

class _DiceRollerState extends State<DiceRoller> {
var currentDiceRoll = 2;

  void rollDice() {

    setState(() {
      currentDiceRoll =  randomizer.nextInt(6) +1;
    });
   
   print('Cambio immagine...');
  }

  @override
  Widget build(BuildContext context) {
  
       return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/img/dice-$currentDiceRoll.png', 
            width: 200,
            ),
            TextButton(
            /* onPressed: () {},  opzione con funzione anonima*/
            onPressed: rollDice,
            style: TextButton.styleFrom(
              padding: EdgeInsets.only(top:20),
              foregroundColor:  Colors.white, 
              textStyle: const TextStyle(
                fontSize: 28),
                ),
            child: const Text("Tira il dato")
            ),
            ],
            );
  }
}