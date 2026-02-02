import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_plan/models/task_model.dart';
import 'package:d_plan/models/note_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Tasks
  Stream<List<Task>> getTasks() {
    return _db.collection('tasks').snapshots().map((snapshot) => snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList());
  }

  Future<void> addTask(String title, String description) {
    return _db.collection('tasks').add({
      'title': title,
      'description': description,
      'status': 'todo',
    });
  }

  Future<void> updateTaskStatus(String id, TaskStatus status) {
    return _db.collection('tasks').doc(id).update({'status': status.toString().split('.').last});
  }

  // Notes
  Stream<List<Note>> getNotes() {
    return _db.collection('notes').snapshots().map((snapshot) => snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList());
  }

  Future<void> addNote(String title, String content) {
    return _db.collection('notes').add({
      'title': title,
      'content': content,
    });
  }
}
