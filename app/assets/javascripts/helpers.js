Array.prototype.first = function () {
  return this[0];
};

Array.prototype.last = function () {
  return this.pop();
};

Array.prototype.diff = function(a) {
  return this.filter(function(i) {return a.indexOf(i) < 0;});
};
