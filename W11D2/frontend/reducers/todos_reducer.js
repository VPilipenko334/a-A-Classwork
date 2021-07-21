import { RECEIVE_TODO } from "../actions/todo_actions";
import { RECEIVE_TODOS } from "../actions/todo_actions";
import { REMOVE_TODO } from "../actions/todo_actions";

// Return the initial state if the state argument is undefined.
// Return the state if the reducer doesn't care about the action.
// Return a new state object if the reducer cares about the action.

const initialState = {
    1: {
        id: 1,
        title: "wash car",
        body: "with soap",
        done: false
    },
    2: {
        id: 2,
        title: "wash dog",
        body: "with shampoo",
        done: true
    }
};

const todosReducer = (state = initialState, action) => {
    Object.freeze(state);  // freezing and protecting old arg
    const nextState = Object.assign({}, state); //creates a new object 

    switch (action.type) {
        case RECEIVE_TODOS: 
            action.todos.forEach(todo => 
            nextState[todo.id] = todo
            );
            return nextState;
        case RECEIVE_TODO:
            nextState[action.todo.id] = action.todo;
            return nextState; 
        case REMOVE_TODO: 
            delete nextState[action.todo.id];
            return nextState; 
        default:
            return state;
    }
};

// const newTodos = [{ id: 1, title: "wash car", body: "with soap", done: false }, { id: 2, title: "wash dog", body: "with shampoo", done: true }];

export default todosReducer;