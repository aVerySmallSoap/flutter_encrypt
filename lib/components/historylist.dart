import 'package:flutter/material.dart';

import '../api/session.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: Session.user!.getHistory().length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final String entry = Session.user!.getHistory()[index];
          return Container(
              color: Colors.lightBlueAccent,
              child: Dismissible(
                key: Key(entry),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  setState(() {
                    Session.user!.getHistory().removeAt(index);
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$entry removed')));
                },
                child: ListTile(
                  title: Text(
                    Session.user!.getHistory()[index],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
