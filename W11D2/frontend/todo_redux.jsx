import React from 'react'; 
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import { receiveTodo } from './actions/todo_actions';
import { receiveTodos } from './actions/todo_actions';
import { removeTodo } from './actions/todo_actions'
// import App from './components/app'
import Root from './components/root'
import { allTodos } from './reducers/selectors';

document.addEventListener("DOMContentLoaded", () => {
    const store = configureStore(); // creates the store
    window.store = store; // lets us access the store from window
    window.receiveTodo = receiveTodo;
    window.receiveTodos = receiveTodos;
    window.removeTodo = removeTodo;
    window.allTodos = allTodos;
    
    let content = document.getElementById('content');
    // ReactDOM.render(<h1>Todos App</h1>, content);
    ReactDOM.render(<Root store={store}/>, content)
});