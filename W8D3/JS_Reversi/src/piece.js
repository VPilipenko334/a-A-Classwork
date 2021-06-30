/**
 * Initializes the Piece with its color.
 */
function Piece (color) {

    this.color = color;
}

/**
 * Returns the color opposite the current piece.
 */
Piece.prototype.oppColor = function () {
    if(this.color === "white") {
        return "black";
    } else  {
        return "white"; }
};

/**
 * Changes the piece's color to the opposite color.
 */
Piece.prototype.flip = function () {
    if (this.color === "white") {
        this.color = "black";
    } else {
        this.color = "white"; 
    }
};

/**
 * Returns a string representation of the string
 * based on its color.
 */
Piece.prototype.toString = function () {

    return this.color;

};

    
// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
    module.exports = Piece;
}
// DON'T TOUCH THIS CODE