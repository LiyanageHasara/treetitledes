import 'package:flutter/material.dart';
import 'package:treeapp/data/model/tree.dart';

class TreeDetailsPage extends StatelessWidget{
  final Tree tree;

  const TreeDetailsPage({Key key, @required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tree.title, style: Theme.of(context)
                .textTheme.title.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
            ),),
            const SizedBox(height: 20.0,),
            Text(tree.description, style: TextStyle(
              fontSize: 16.0
            ),),

          ],
        ),
      ),
    );
  }
}

