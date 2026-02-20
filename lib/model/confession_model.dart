import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_twitter_clone/helper/show.dart';

class ConfessionModel {
  ConfessionModel({
    this.title,
    this.description,
    this.date,
  });


  String? description;
  String? title;
  String? date;


  ConfessionModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    title = doc["title"];
    description = doc["description"];
    date =  doc["date"];
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      "description" : description,
      "date" : date,
    };
  }


}

