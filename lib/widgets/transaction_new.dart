// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/widgets/adaptive_flatbutton.dart';

class TransactionNew extends StatefulWidget {
  final Function selectHandler;

  const TransactionNew(this.selectHandler, {Key key}) : super(key: key);

  @override
  State<TransactionNew> createState() => _TransactionNewState();
}

class _TransactionNewState extends State<TransactionNew> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final inputTitle = _titleController.text;
    final inputAmount = double.parse(_amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.selectHandler(
      inputTitle,
      inputAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date chosen!'
                            : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose date', _presentDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                style: (ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                )),
                onPressed: _submitData,
                child: Text(
                  'Add transaction',
                  style: TextStyle(
                    color: Theme.of(context).buttonTheme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
