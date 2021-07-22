//presentational component
import React from 'react';
import TodoListItem from './todo_list/todo_list_item';
import TodoForm from './todo_list/todo_form';

const TodoList = (props) => {
    const todos = props.todos;
    const listItems = todos.map(todo => {
        return <TodoListItem todo ={todo}/> 
    })

    return  (
        <div>
            <h1>My To-Do List:</h1>
            <ul>
                {listItems}
            </ul>
            <TodoForm receiveTodo={props.receiveTodo}/>
        </div>
    )

}
export default ToDoList;

// export default () => <h3>Todo List goes here!</h3>

//mapping out the list: 
// {todos.map(todo -> <li key = {todo.id}> {todo.title}</li>)}

