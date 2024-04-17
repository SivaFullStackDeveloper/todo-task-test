import 'package:equatable/equatable.dart'; // Import Equatable for value equality
import '../data/todo_data.dart'; // Import todo data model

// Enum to represent the status of the todo state
enum TodoStatus { initial, loading, success, error }

// Class representing the state of the todo list
class TodoState extends Equatable {
  final List<Todo> todos; // List of todo items
  final TodoStatus status; // Status of the todo state

  // Constructor for TodoState
  const TodoState({
    this.todos = const <Todo>[],
    this.status = TodoStatus.initial,
  });

  // Method to create a copy of TodoState with some properties modified
  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }

  // Factory method to create a TodoState from JSON
  @override
  factory TodoState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfTodos = (json['todo'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList();

      return TodoState(
        todos: listOfTodos,
        status: TodoStatus.values.firstWhere(
              (element) => element.name.toString() == json['status'],
        ),
      );
    } catch (e) {
      rethrow; // Throw an error if there is an issue with JSON parsing
    }
  }

  // Method to convert TodoState to JSON
  Map<String, dynamic> toJson() {
    return {
      'todo': todos, // Convert todo list to JSON
      'status': status.name, // Convert status enum to string
    };
  }

  // Override Equatable's props getter to define equality comparison properties
  @override
  List<Object?> get props => [todos, status];
}
