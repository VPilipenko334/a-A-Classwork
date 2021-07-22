// create react component called ToDoListItem 
// should return <li> (list) with props.todo.title inside of it 
// TodoList component should render TodoListItems and give them their neccessary props 

//when you refresh your page; everything should look the same 

import React from 'react';
import { render } from 'react-dom';


class TodoListItem extends React.Component {
    constructor(props) {
        this.super(props);   //passing in a super so everything will be inherited
        this.state = {detail: false };   //key?
        this.toggleDetail = this.toggleDetail.bind(this); //bind the function to this to give it window scope
        this.toggleTodo = this.toggleTodo.bind(this); // binding the function to this gives it a window scope
    }
}

    toggleDetail(e) {
        e.preventDefault();
        this.setSTate( { detail : !this.state.detail });
    }

    toggleTodo(e) {
        e.preventDefault();
        const toggleTodo = Object.assign(
            {},
            this.props.todo,
            {done : !this.props.todo.done}
        );

        this.props.receiveTodo(toggleTodo);
    }

    render() {
        const {todo, updateTodo } = this.props;
        const {title, done} = todo;
        let detail; 
            if (this.state.detail) {
                detail = <TodoDetailViewContainer todo = {todo} />;
            }
    }

    return (
        <li className="todo-list-item">
            <div className="todo-header">
                <h3>< a onCLick= {this.toggleDetail }> {title} </a></h3>
                <button 
                    className={ done ? "done" : "undone" }
                    onClick={ this.toggleTodo}>
                    {done ? "Undo" : "Done" }
                </button>
            </div>
        </li>
    )

    export default TodoListItem; 