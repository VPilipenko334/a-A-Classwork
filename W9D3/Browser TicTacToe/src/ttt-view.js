const Game = require("../ttt_node/game");

class View {
  constructor(game, el) {
    this.game = game;
    this.el = el;
    this.handleClick = this.handleClick.bind(this);
    this.setupBoard();
    this.bindEvents();
  }

  setupBoard() {
    const ul = document.createElement("ul");
    
    for(let rowIndex = 0; rowIndex < 3; rowIndex++){
      for(let colIndex = 0; colIndex < 3; colIndex++){
        const li = document.createElement("li");
        li.dataset.pos = JSON.stringify([rowIndex, colIndex])
        ul.append(li);
      }
    }
    this.el.append(ul);
  }
  
  bindEvents() {
    this.el.addEventListener("click", this.handleClick);
  }

  handleClick(e) {
    const el = e.target;
    if (el.nodeName === "LI"){
      this.makeMove(el);
    }
  }

  makeMove(square) {
    // JSON.parse will convert the json string back into an array
    const pos = JSON.parse(square.dataset.pos);
    const currentPlayer = this.game.currentPlayer;
    try {
      this.game.playMove(pos);
    } catch (e) {
      alert("This " + e.msg.toLowerCase());
    }
    square.classList.add(currentPlayer);
    if (this.game.isOver()) this.handleGameOver()
  }
  
  handleGameOver(){
    // Remove the click listener from the board
    this.el.removeEventListener("click", this.handleClick)
    this.el.classList.add("game-over")
  
    const winner = this.game.winner();
    const figcaption = document.createElement("figcaption")
  
    if (winner) {
      this.el.classList.add(`winner-${winner}`);
      figcaption.append(`You win, ${winner}!`)
    } else {
      figcaption.append("It's a draw!")
    }
  
    this.el.append(figcaption)
  }
}

module.exports = View;