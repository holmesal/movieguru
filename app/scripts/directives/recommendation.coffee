'use strict';

angular.module('movieguruApp')
	.directive 'recommendation', () ->
		templateUrl: 'views/recommendation.html'
		scope: {
			currentRec: '=currentRec'
			# showRecs: '=showRecs'
		}
		restrict: 'E'
		link: (scope, element, attrs) ->

			console.log scope.currentRec
			console.log scope.showRecs
			scope.showRecs = true

			# scope.showRecs = false

			# Bind to the current recommendation
			# scope.data = userData.data
			# # scope.queue = userData.queue
			# # scope.movie = scope.data.currentRecommendation
			
			
			# scope.queueEmpty = true

			# # When recommendations are added for the first time, set the current one
			# scope.$watch 'data.queue', (queue) ->
			# 	if scope.queueEmpty and queue.length > 1
			# 		scope.queueEmpty = false
			# 		userData.getNext()
			# 		console.log scope.data.currentRecommendation
			# 		console.log scope.movie
			# ,true

			# console.log scope.data.currentRecommendation

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

