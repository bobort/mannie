//test board.js
'use strict';
var expect = require('chai').expect;

describe('Sprite', function() {
  it('should exist'), function() {
    var Sprite = require('/js/sprite.js');
    expect(Sprite).to.not.be.undefined;
  }
}
