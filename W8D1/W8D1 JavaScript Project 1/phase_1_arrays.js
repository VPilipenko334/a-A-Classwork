Array.prototype.uniq = function() {
    let uniqueArray = [];

    for (let i = 0; i <this.length; i++)
        if (uniqueArray.indexOf)
}

//myEach 
Array.prototype.myEach = function(callback) {
    for (let i=0; this.length, i++) {
        current = this[i];
        console.log(callback(current));
    }
}

//blocks are like procs, procs are like callbacks

//myMap
Array.prototype.myMap = function(callback) {
    const array = [];
    this.myEach(el => array.push(callback(el)));
    return array;
}
//callbacks are similar to a PROC

