import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hubapp/models/hub.dart';
import 'package:hubapp/screens/hub_detail_screen.dart';
import 'package:intl/intl.dart';

class HubTile extends StatelessWidget {
  final Hub hub;

  const HubTile({Key? key, required this.hub}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hub.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    hub.description,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Created At: ${DateFormat('yyyy-MM-dd hh:MM').format(hub.createdAt)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      HubDetailScreen.routeName,
                      arguments: hub.id,
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
