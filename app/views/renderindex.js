// Generated by CoffeeScript 1.6.3
(function() {
  ({
    renderIndex: function() {
      var mu, out, templData,
        _this = this;
      mu = require('mu2');
      mu.root = __dirname;
      templData = {
        'title': 'Оффициальная страница творческой группы "Ме-ме-ме"',
        'pages': [
          {
            'dropdown': '',
            'url': 'main',
            'name': 'Главная',
            'isDropdown': false
          }, {
            'dropdown': 'class=dropdown-toggle data-toggle=dropdown',
            'url': 'members',
            'name': 'Состав нашей группы',
            'isDropdown': true,
            'dropdownMenu': [
              {
                'url': 'photographer',
                'name': 'Михаил Овчаров'
              }, {
                'url': 'videographer',
                'name': 'Ольга Овчарова'
              }, {
                'url': 'makeuper',
                'name': 'Алёна Полухина'
              }, {
                'url': 'decorator',
                'name': 'Екатерина Костецкая'
              }
            ]
          }, {
            'dropdown': '',
            'url': 'works',
            'name': 'Наши совместные работы',
            'isDropdown': false
          }, {
            'dropdown': '',
            'url': 'indieWorks',
            'name': 'Работы не в команде',
            'isDropdown': false
          }, {
            'dropdown': '',
            'url': 'contacts',
            'name': 'Наши контакты',
            'isDropdown': false
          }
        ],
        'sliderFiles': void 0
      };
      out = '';
      return mu.compileAndRender('index.mu', templData).on('data', function(data) {
        return out += data.toString().on('end', function() {
          return _this.fs.writeFile('index.html', out, function(err) {
            if (err) {
              console.log('Warning, can\'t create index.html');
              throw err;
            }
          });
        });
      });
    }
  });

}).call(this);
