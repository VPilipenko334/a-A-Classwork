
// `Function.prototype.inherits` using surrogate 

Function.prototype.inherits1 = function (BaseClass) {
    function Surrogate() { }
    Surrogate.prototype = BaseClass.prototype;
    this.prototype = new Surrogate();
    this.prototype.constructor = this;
};

// `Function.prototype.inherits` using `Object.create`

Function.prototype.inherits2 = function (BaseClass) {
    this.prototype = Object.create(BaseClass.prototype);
    this.prototype.constructor = this;
};

function Dog(name) {
    this.name = name;
}

Dog.prototype.bark = function () {
    console.log(this.name + " goes woof");
};

function Doggy(name) {
    Dog.call(this, name);
}

Doggy.inherits1(Dog);

Doggy.prototype.waddle = function () {
    console.log(this.name + " waddles!");
};

const blixa = new Doggy("Toto");
toto.bark();
toto.run();
