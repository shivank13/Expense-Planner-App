
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
class  NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController=TextEditingController();

  final amountController=TextEditingController();
   DateTime selectedDate;

  void submitData(){
    if(amountController.text.isEmpty)
    {
      return;
    }

    final enteredTitle =titleController.text;
    final enteredAmount =double.parse(amountController.text);
    if(enteredTitle.isEmpty || enteredAmount <=0 || selectedDate== null)
    {
      return;
    }

    widget.addTx(enteredTitle,enteredAmount,selectedDate);
    Navigator.of(context).pop();
  }
   
   void _presentDatePicker()
   {
     showDatePicker(
       context: context, 
       initialDate: DateTime.now(), 
       firstDate: DateTime(2019), 
       lastDate: DateTime.now(),
       ).then((pickedDate) {
         if(pickedDate ==null)
         {
           return;
         }
         setState(() {
           selectedDate=pickedDate;
         });
         
       });
   }

  @override
  Widget build(BuildContext context) {
    return  Card(

             elevation: 5,
             child:Container(
               padding: EdgeInsets.all(10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
               children:[
                 TextField(
                   decoration: InputDecoration(labelText:'Title' ),
                   controller: titleController,
                   onSubmitted:(_)=> submitData(),
                   //onChanged: (val){
                    // titleInput=val;
                   //},
                   ),
                 TextField(
                   decoration: InputDecoration(labelText:'Amount' ),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted:(_)=> submitData(),
                  // onChanged:(val){
                    // amountInput=val;
                 //  } ,
                   ),
                   Container(
                     height: 70,
                     child: Row(
                       
                       children: [
                         Expanded(
                            child: Text(selectedDate==null?'No Date Chosen!': 
                           'Picked Date: ${DateFormat.yMd().format(selectedDate)}'),
                         ),
                         FlatButton(
                           textColor:Theme.of(context).primaryColor ,
                           onPressed:_presentDatePicker, child: 
                           Text('Choose Date',
                           style: TextStyle(fontWeight:FontWeight.bold ),)),
                       ],
                     ),
                   ),
                 RaisedButton(onPressed:  submitData,
                 
                  child: Text('Add transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  )
               ],
           ),
             ),
             );
  }
}