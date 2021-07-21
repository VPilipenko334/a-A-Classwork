
export const allTodos = (state) => {
   const todosArray = Object.values(state.todos);
   return todosArray;
}