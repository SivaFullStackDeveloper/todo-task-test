import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Flutter Bloc library
import 'package:flutter_slidable/flutter_slidable.dart'; // Import Slidable for swipe actions
import 'package:todo/todo_bloc/todo_events.dart'; // Import todo events
import '../todo_bloc/todo_state.dart'; // Import todo state
import 'data/todo_data.dart'; // Import todo data model
import 'todo_bloc/todo_bloc.dart'; // Import todo bloc

// Home screen widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final formKey = GlobalKey<FormState>();

  // Function to add a todo item
  addTodo(Todo todo) {
    context.read<TodoBloc>().add(
      AddTodo(todo),
    );
  }

  // Function to remove a todo item
  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(
      RemoveTodo(todo),
    );
  }

  // Function to toggle todo item completion status
  alertTodo(int index) {
    context.read<TodoBloc>().add(
        AlterTodo(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Show dialog to add a new todo item
            showDialog(
                context: context,
                builder: (context) {
                  TextEditingController controller1 = TextEditingController();
                  TextEditingController controller2 = TextEditingController();

                  return Form(
                    key: formKey,
                    child: AlertDialog(
                      title:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Add a Task'
                          ),
                          IconButton(onPressed:(){
                            Navigator.pop(context);
                          },icon:Icon(Icons.close,color: Colors.black,))
                        ],
                      ),

                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            // Validate task title
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please Give Task Name";
                              }
                            },
                            controller: controller1,
                            cursorColor: Theme.of(context).colorScheme.secondary,
                            decoration: InputDecoration(
                              hintText: 'Task Title...',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            // Validate task description
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please Give Description";
                              }
                            },
                            controller: controller2,
                            cursorColor: Theme.of(context).colorScheme.secondary,
                            decoration: InputDecoration(
                              hintText: 'Task Description...',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextButton(
                              onPressed: () {
                                // Validate form and add todo item if valid
                                if(controller1.text.isEmpty || controller2.text.isEmpty){
                                  formKey.currentState!.validate();
                                }else{
                                  addTodo(
                                    Todo(
                                        title: controller1.text,
                                        subtitle: controller2.text
                                    ),
                                  );
                                  controller1.text = '';
                                  controller2.text = '';
                                  Navigator.pop(context);
                                }

                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.green,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                foregroundColor:  Colors.green,
                                backgroundColor: Colors.green,
                              ),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text("Add +",style: TextStyle(
                                        color: Colors.white
                                    ),),
                                  )
                              )
                          ),
                        )
                      ],
                    ),
                  );
                }
            );
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.black,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
          title: const Text(
            'ToDo App',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              // Check todo state status and display appropriate UI
              if(state.status == TodoStatus.success) {
                return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, int i) {
                      // Display todo item with swipe actions
                      return Card(
                        color: Theme.of(context).colorScheme.primary,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Slidable(
                            key: const ValueKey(0),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) {
                                    // Remove todo item
                                    removeTodo(state.todos[i]);
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: ListTile(
                                title: Text(
                                  state.todos[i].title,style: TextStyle(
                                    color: Colors.white,
                                    decoration: state.todos[i].isDone?TextDecoration.lineThrough:TextDecoration.none
                                ),
                                ),
                                subtitle: Text(
                                  state.todos[i].subtitle,style: TextStyle(
                                    decoration: state.todos[i].isDone?TextDecoration.lineThrough:TextDecoration.none,
                                    color: Colors.white
                                ),
                                ),
                                trailing: Checkbox(
                                    value: state.todos[i].isDone,
                                    activeColor: Theme.of(context).colorScheme.secondary,
                                    onChanged: (value) {
                                      // Toggle todo completion status
                                      alertTodo(i);
                                    }
                                )
                            )
                        ),
                      );
                    }
                );
              } else if (state.status == TodoStatus.initial){
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container();
              }
            },
          ),
        )
    );
  }
}
