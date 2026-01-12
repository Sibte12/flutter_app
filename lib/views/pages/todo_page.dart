import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/todo_controller.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  final TodoController controller = Get.put(TodoController());
  final TextEditingController textController = TextEditingController();

  void showEditDialog(BuildContext context, int index, String oldTitle) {
    final TextEditingController editController =
        TextEditingController(text: oldTitle);

    Get.defaultDialog(
      title: 'Edit Todo',
      content: TextField(controller: editController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      ),
      textCancel: 'Cancel',
      textConfirm: 'Update',
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.editTodo(index, editController.text);
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX Todo App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter todo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    controller.addTodo(textController.text);
                    textController.clear();
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  final todo = controller.todos[index];
                  return ListTile(
                    leading: Checkbox(
                      value: todo.isDone,
                      onChanged: (_) => controller.toggleTodo(index),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        decoration: todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => showEditDialog(
                            context,
                            index,
                            todo.title,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => controller.removeTodo(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
