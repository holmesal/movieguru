'use strict';

angular.module('movieguruApp')
		.directive 'recommendation', () ->
			templateUrl: 'views/recommendation.html'
			scope:
#        currentRec: '='
				movies: '='
				# showRecs: '=showRecs'
			restrict: 'E'
			link: (scope, element, attrs) ->

				console.log scope.movies

				console.log scope.currentRec

				# scope.showRecs = false

				# Bind to the current recommendation
				# scope.data = userData.data
				# # scope.queue = userscope.movies.queue
				# # scope.movie = scope.data.currentRecommendation

				scope.queueEmpty = true

				# # When recommendations are added for the first time, set the current one
				scope.$watch 'movies.queue', (queue) ->
					console.error 'queue changed!'
					if scope.queueEmpty and queue.length > 1
						console.log 'adding first!'
						scope.queueEmpty = false

						scope.getNext()
						console.log scope.currentRec
						console.log scope.movies
				,true

				# console.log scope.data.currentRecommendation

				scope.getNext = ->
					# Don't do anything if the queue is empty
					if scope.movies.queue.length > 0
						# Get the highest-ranked movie
						# TODO: Next is -Infinity in some cases? Happens when there is no fanart for top recommendation
						next = _.max scope.movies.queue, (movie) ->
							return movie.rank
						console.log scope.movies.queue
						console.log next
						# Set the as current recommendation
						data.currentRecommendation = next

				scope.fave = (movie) ->
					userData.favoriteRecommendation movie

				scope.blacklist = (movie) ->
					userData.blacklistRecommendation movie

				scope.later = (movie) ->
					userData.laterRecommendation movie

				scope.hide = ->
					# Animate out

				scope.show = ->
					# Animate in

