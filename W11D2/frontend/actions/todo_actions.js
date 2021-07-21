export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";

//resets to-dos
//passes in a new set of todos
//todos is an array
export const receiveTodos = (todos) => {
    return {
        type: RECEIVE_TODOS,
        todos, 
    };
};

//dispatcher ?? * creates things?
export const receiveTodo = (todo) => {
    return {
        type: RECEIVE_TODO,
        todo,
    };
};

export const removeTodo = (todo) => {
    return {
        type: REMOVE_TODO,
        todo, 
    };
};
