//container component

import { Connect } from "react-redux";
import {} from 'todo_list.jsx';
import { receiveTodo } from "../../actions/todo_actions";
import { allTodos } from "../../reducers/selectors";

const mapStateToProps = (state) => {
 return ({
     todos: allTodos(state)
 })
};

const mapDispatchToProps = dispatch => ({
    receiveTodo: todo =>dispatch(receiveTodo(todo))
});

export default connect (
    mapStateToProps,
    mapDispatchToProps
)(TodoList);
