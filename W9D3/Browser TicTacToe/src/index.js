const View = require("./ttt-view.js");
const Game = require("../ttt_node/game.js");

document.addEventListener("DOMContentLoaded", () => {
  const rootEle = document.querySelector(".ttt");
  const game = new Game();
  const view = new View(game, rootEle);
});
