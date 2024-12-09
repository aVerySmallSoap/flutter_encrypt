import 'package:flutter/material.dart';
import 'package:test_app/api/sessions/session_manager.dart';
import '../api/user.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  final User? _user = SessionManager.instance.getSession("user")?.user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _user!.getHistory().length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final String entry = _user.getHistory()[index];
          return Container(
              color: Color.fromRGBO(242, 235, 191, 1),
              child: Dismissible(
                key: Key(entry),
                background: Container(
                  color: Color.fromRGBO(240, 96, 96, 1),
                  padding: EdgeInsets.only(left: 8),
                  alignment: AlignmentDirectional.centerStart,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                direction: DismissDirection.startToEnd,
                dismissThresholds: {
                  DismissDirection.startToEnd: 0.8,
                },
                onDismissed: (direction) {
                  setState(() {
                    _user.getHistory().removeAt(index);
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$entry removed')));
                },
                child: ListTile(
                  title: Text(
                    _user.getHistory()[index],
                    style: TextStyle(
                      fontFamily: "Antipasto",
                      fontSize: 24,
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
