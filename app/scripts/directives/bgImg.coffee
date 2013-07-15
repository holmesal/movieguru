'use strict';

angular.module('movieguruApp')
  .directive('bgImg', () ->
	template: '<div></div>'
	restrict: 'E'
	link: (scope, element, attrs) ->

      imgs = [
        # 'http://zapp.trakt.us/images/fanart_movies/1181.jpg',
        'http://zapp.trakt.us/images/fanart_movies/174419.jpg'
        'http://slurm.trakt.us/images/fanart_movies/1251.1.jpg'
        # 'http://zapp.trakt.us/images/fanart_movies/297.jpg'
        # 'http://zapp.trakt.us/images/fanart_movies/778.jpg'
        'http://zapp.trakt.us/images/fanart_movies/184.jpg'
      ]

      console.log 'hi!'

      scope.$watch 'data.currentRecommendation', (rec)->
        if rec
          console.log rec
          if rec.images.fanart
            scope.bgUrl = rec.images.fanart
        else
          scope.bgUrl = imgs[Math.floor(Math.random()*imgs.length)]

        element.css
          'background-image': 'url('+scope.bgUrl+')'

      # Preload the top 5 images in the queue
      # TODO: This loads more images that I'd like it to, for some reason
      scope.$watch 'data.queue', (queue) ->
        # Preload the top 3 images
        for [0..3]
          unloaded = _.max queue, (movie) ->
            if not movie.loaded
              return movie.rank
            else
              return 0

          console.info unloaded

          if unloaded.images
            console.info 'loaded new image!'
            unloaded.loaded = true
            img = new Image
            img.src = unloaded.images.fanart
      ,true

  )
