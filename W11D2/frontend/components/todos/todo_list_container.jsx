//container component

import { connect } from "react-redux";
import TodoList from './todo_list.jsx';


import { receiveTodos, receiveTodo } from "../../actions/todo_actions";
import { allTodos } from "../../reducers/selectors";

const mapStateToProps = (state) => {
 return ({                              //explicit return 
     todos: allTodos(state)             //creating a prop called todos and return the value of all todos when passing in the state
 })
};

const mapDispatchToProps = dispatch => ({
    receiveTodo: todo =>dispatch(receiveTodo(todo))
});

export default connect (
    mapStateToProps,
    mapDispatchToProps
)(TodoList);
