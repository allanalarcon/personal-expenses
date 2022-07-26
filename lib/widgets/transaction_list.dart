// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(this.transactions, this.deleteTransaction, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.15,
                  child: Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.01,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  height: constraints.maxHeight * 0.8,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                          child: Text('\$${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: mediaQuery.size.width > 400
                      ? TextButton.icon(
                          icon: Icon(Icons.delete),
                          style: (ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).errorColor,
                            ),
                          )),
                          label: Text('Delete'),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
