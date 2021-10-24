import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  String id;
  String name;
  String category;
  String image;
  List chapters = [];
  Timestamp createdAt;
  Timestamp updatedAt;
  Story();

  Story.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    image = data['image'];
    chapters = data['chapters'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'chapters': chapters,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
