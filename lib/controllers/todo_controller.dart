import 'package:get/get.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void addTodo(String title) {
    if (title.isNotEmpty) {
      todos.add(Todo(title: title));
    }
  }

  void toggleTodo(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  void removeTodo(int index) {
    todos.removeAt(index);
  }

  void editTodo(int index, String newTitle) {
    if (newTitle.isNotEmpty) {
      todos[index].title = newTitle;
      todos.refresh();
    }
  }
}
