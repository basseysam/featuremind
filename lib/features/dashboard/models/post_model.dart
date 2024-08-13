

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String title;
  String description;
  String imageUrl;
  Timestamp createdAt;
  int likes;
  String state;
  AssignedTo assignedTo;
  List<Comment> comments;

  Post({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.likes,
    required this.state,
    required this.assignedTo,
    required this.comments,
  });

  // Factory constructor to create a Post object from a JSON map
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
      likes: json['likes'],
      state: json['state'],
      assignedTo: AssignedTo.fromJson(json['assigned_to']),
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }

  // Method to convert Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt,
      'likes': likes,
      'state': state,
      'assigned_to': assignedTo.toJson(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}

class AssignedTo {
  String name;
  String imageUrl;

  AssignedTo({
    required this.name,
    required this.imageUrl,
  });

  factory AssignedTo.fromJson(Map<String, dynamic> json) {
    return AssignedTo(
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_url': imageUrl,
    };
  }
}

class Comment {
  Sender sender;
  int likes;
  Timestamp createdAt;
  String commentText;

  Comment({
    required this.sender,
    required this.likes,
    required this.createdAt,
    required this.commentText,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      sender: Sender.fromJson(json['sender']),
      likes: json['likes'],
      createdAt: json['created_at'],
      commentText: json['comment_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'likes': likes,
      'created_at': createdAt,
      'comment_text': commentText,
    };
  }
}

class Sender {
  String name;
  String imageUrl;

  Sender({
    required this.name,
    required this.imageUrl,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image_url': imageUrl,
    };
  }
}
