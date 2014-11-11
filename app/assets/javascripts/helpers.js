// Javascript
Array.prototype.first = function () {
  return this[0];
};

Array.prototype.last = function () {
  return this.pop();
};

Array.prototype.diff = function(a) {
  return this.filter(function(i) {return a.indexOf(i) < 0;});
};

// JQuery
var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();
