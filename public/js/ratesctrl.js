  var RatesCtrl;

  RatesCtrl = (function() {
    function RatesCtrl($scope, $http) {
      var apiUrl, currencys, interval;
      $scope.base = 'EUR';
      interval = 60000;
      apiUrl = '/api/rates';
      currencys = ['AUD', 'NOK', 'USD'];
      $scope.sources = ['loading...'];
      $scope.getSourcesList = function() {
        return $scope.sources.join(', ');
      };
      $scope.ratesCollection = {};
      $scope.error = false;
      this._getRates($http, $scope, apiUrl, currencys);
      setInterval(this._getRates, interval, $http, $scope, apiUrl, currencys);
    }

    RatesCtrl.prototype._getRates = function(http, scope, apiUrl, currencys) {
      var i, params, url, _i, _ref,
        _this = this;
      params = '?base=' + scope.base;
      for (i = _i = 0, _ref = currencys.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        params += '&cur=' + currencys[i];
      }
      url = apiUrl + params;
      return http({
        method: 'GET',
        url: url
      }).success(function(data, status, headers, config) {
        var error, source, _ref1;
        console.log(data);
        scope.base = data.base;
        scope.error = data.error;
        if (data.error) {
          scope.errorMsg = '';
          _ref1 = data.errors;
          for (source in _ref1) {
            error = _ref1[source];
            scope.errorMsg += ("Error" + (error.legnth >= 1 ? 's' : '') + " while get information from " + source + ": ") + error.join('; ');
          }
        }
        scope.ratesCollection = data.ratesCollection;
        return scope.sources = data.sources;
      }).error(function(data, status, headers, config) {
        scope.error = true;
        return scope.errorMsg = "Connection error.";
      });
    };

    return RatesCtrl;

  })();
