import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';

import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
       primarySwatch: Colors.purple,
       accentColor: Colors.amber,
       errorColor: Colors.red,
       fontFamily: 'Quicksand',
       textTheme: ThemeData.light().textTheme.copyWith(
         title: TextStyle(
           fontFamily:'OpenSans',
         fontWeight:FontWeight.bold,
         fontSize: 18,),
         button: TextStyle(color:Colors.white),
       ),
       appBarTheme: AppBarTheme(
         textTheme: ThemeData.light().textTheme.copyWith(
           title:TextStyle(
             fontFamily:'OpenSans',
             fontSize:20,
             fontWeight:FontWeight.bold,
           )
           ) 
       ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
 
  //String titleInput;
  //String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  final List<Transaction>_userTransactions=[
   // Transaction(id:'t1',
   // title:'New Shoes',
    //amount:69,
    //date:DateTime.now(),
    //),
    //Transaction(id:'t2',
    //title:'groceries',
    //amount:60,
    //date:DateTime.now(),
    //)

  ];
  List<Transaction>get _recentTransaction{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days:7 ),
        ),
        );
    }).toList();
  }
   void _addNewTranssaction(String txtitle,double txamount,DateTime chosenDate)
   {
     final newTx=Transaction(title:txtitle,
      amount: txamount,
      date: chosenDate,
      id: DateTime.now().toString()
      );
      setState(() {
        _userTransactions.add(newTx);
      });
   }


  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, 
    builder: (_){
     return GestureDetector(
       onTap: (){},
       child: NewTransaction(_addNewTranssaction),
       behavior: HitTestBehavior.opaque,
     );
    },
    );
  }
   
   void deleteTransaction(String id){
     setState(() {
       _userTransactions.removeWhere((tx) =>tx.id==id);
     });
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses',),
        actions: [
          IconButton(icon: Icon(Icons.add),
           onPressed:()=> _startAddNewTransaction(context),
           )
        ],
      ),
      body:  SingleChildScrollView(
              child: Column(
             // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[
              Chart(_recentTransaction),
              TransactionList(_userTransactions,deleteTransaction),
            
            ],
            
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed:()=> _startAddNewTransaction(context),
        ),
      );
    
  }
}
