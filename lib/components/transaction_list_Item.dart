import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionItemList extends StatefulWidget {
  final Transaction tr;
  final void Function(String) onRemove;

  const TransactionItemList({
		required Key key,
    required this.tr,
    required this.onRemove,
	}) : super(key: key) ;

  @override
  State<TransactionItemList> createState() => _TransactionItemListState();
}

class _TransactionItemListState extends State<TransactionItemList> {
  static const colors = [
    Colors.red,
    Colors.lightGreen,
    Colors.orange,
    Colors.lime,
    Colors.lightBlue
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: _backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          height: 60,
          width: 60,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                'R\$${widget.tr.value.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd MMM y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                label: Text(
                  'Excluir',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.onRemove(widget.tr.id),
              ),
      ),
    );
  }
}
