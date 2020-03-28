import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treeapp/data/firestore_service.dart';
import 'package:treeapp/data/model/tree.dart';

class AddTreePage extends StatefulWidget {
  final Tree tree;

  const AddTreePage({Key key, this.tree}) : super(key: key);
  @override
  _AddTreePageState createState() => _AddTreePageState();
}

class _AddTreePageState extends State<AddTreePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  FocusNode _descriptionNode;

  @override
  void initState(){
    super.initState();
    _titleController = TextEditingController(text: isEditTree ? widget.tree.title : '');
    _descriptionController = TextEditingController(text: isEditTree ? widget.tree.description : '');
    _descriptionNode = FocusNode();
  }

  get isEditTree => widget.tree != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditTree ? 'Edit Tree' : 'Add Tree'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
                controller: _titleController,
                validator: (value){
                  if(value==null || value.isEmpty)
                    return "Title cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _descriptionNode,
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(isEditTree ? "Update" : "Save"),
                onPressed: () async {
                  if(_key.currentState.validate()){

                    try{
                      if(isEditTree){
                        Tree tree =Tree(description: _descriptionController.text,
                        title: _titleController.text,
                        id: widget.tree.id,
                        );
                        await FirestoreService().updateTree(tree);
                      }else {
                        Tree tree =Tree(description: _descriptionController.text,
                        title: _titleController.text,
                        );
                        await FirestoreService().addTree(tree);
                      }
                      Navigator.pop(context);
                    }catch(e){
                      print(e);
                    }
                  }

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
