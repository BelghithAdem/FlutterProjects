import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // added const and key

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListScreen(),
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<String> tasks = [];
  final TextEditingController taskController = TextEditingController();
  
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(taskController.text);
        taskController.clear();
      });
    }
  }
  
  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }
  
  void clearAllTasks() {
    setState(() {
      tasks.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TP2 - To-Do List'),
        backgroundColor: Colors.green,
        actions: [
          if (tasks.isNotEmpty)
            IconButton(
              onPressed: clearAllTasks,
              icon: const Icon(Icons.clear_all),
              tooltip: 'Clear all tasks',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a task',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addTask();
              },
              child: const Text('Add Task', style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.task_alt, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No tasks yet',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            'Add your first task above',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(tasks[index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => removeTask(index),
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  tooltip: 'Delete task',
                                ),
                              ],
                            ),
                            onLongPress: () {
                              removeTask(index);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

}
