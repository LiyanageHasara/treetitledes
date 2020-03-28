class Tree{
  String title;
  String description;
  String id;

  Tree({this.title, this.description, this.id});

  Tree.fromMap(Map<String,dynamic> data, String id):
    title=data["title"],
    description=data["description"],
    id=id;

  Map<String, dynamic> toMap(){
    return{
      "title" : title,
      "description" : description,
    };
  }
}