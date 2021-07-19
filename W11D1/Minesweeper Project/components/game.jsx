import Board from './board';
import React from 'react';
import * as Minesweeper from '../minesweeper';

class Game extends React.Component {
    constructor(props) {
        super(props);
        const board = new Minesweeper.Board();
        this.state = { board: board};
        this.updateGame = this.updateGame.bind(this);
    }

    updateGame() {
        
    }

    // what the user sees, will be in div tags 
    render() {

    }
}
