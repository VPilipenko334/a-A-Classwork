
export const allTodos = (state) => {
   const todosArray = Object.values(state.todos);  //extract an array of todos from state.todos 
   return todosArray;  //returning your new array 
}



