// Generated by CoffeeScript 1.6.3
(function() {
  var EuropeanCB, Parser, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Parser = require(__dirname + '/parser').Parser;

  EuropeanCB = (function(_super) {
    __extends(EuropeanCB, _super);

    function EuropeanCB() {
      _ref = EuropeanCB.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    EuropeanCB.prototype.getRates = function(base, currencys) {
      var url;
      url = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml';
      this._base = base;
      this._currencys = currencys;
      return this._getData(url);
    };

    EuropeanCB.prototype._parse = function(data) {
      var cur, currencys, parseString,
        _this = this;
      if (data == null) {
        this._onParseError('Can\'t get from ecb.int');
        return;
      }
      parseString = require('xml2js').parseString;
      cur = {};
      currencys = {};
      return parseString(data, {
        async: true
      }, function(err, result) {
        var cost, i, _i, _j, _ref1, _ref2;
        if (err) {
          _this._onParseError(err);
          return;
        }
        data = result['gesmes:Envelope'].Cube[0].Cube[0].Cube;
        for (i = _i = 0, _ref1 = data.length; 0 <= _ref1 ? _i < _ref1 : _i > _ref1; i = 0 <= _ref1 ? ++_i : --_i) {
          currencys[data[i]['$'].currency] = data[i]['$'].rate;
        }
        cost = 1;
        if (currencys[_this._base]) {
          cost = currencys[_this._base];
        }
        for (i = _j = 0, _ref2 = _this._currencys.length; 0 <= _ref2 ? _j < _ref2 : _j > _ref2; i = 0 <= _ref2 ? ++_j : --_j) {
          cur[_this._currencys[i]] = currencys[_this._currencys[i]] / cost;
        }
        return _this.emit('end', cur);
      });
    };

    return EuropeanCB;

  })(Parser);

  exports.EuropeanCB = EuropeanCB;

}).call(this);
