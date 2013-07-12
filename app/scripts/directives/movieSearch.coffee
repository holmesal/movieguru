'use strict';

angular.module('movieguruApp')
  .directive 'movieSearch', (findMovies,userData) ->
	templateUrl: 'views/movieSearch.html'
	restrict: 'E' # Element
	scope: # Don't override any parent properties
		attrs: '&'
	link: (scope, element, attrs) ->


		# scope.movies = recommendations.search



		# Hook the 'results' property in the scope of the current directive up to the results provided by the findMovies service
		scope.finder = findMovies.data
		
		# scope.data = userData.data

		# Initially, there is no movieQuery
		scope.movieQuery = ''

		# Watch the movieQuery model for changes
		scope.$watch 'movieQuery', (query) ->
			# Empty the element if the query is emptied
			if query.length > 0
				# Fire off a search
				findMovies.search query
			else
				scope.finder.results = []

		# Called when a list item is clicked
		scope.fireCallback = (chosen) ->
			# Push onto the favorites via the function on the userData service
			userData.favoriteRecommendation chosen

			# Reset the input field and clear the results
			scope.movieQuery = ''
			scope.finder.results = []

			# Check out the next movie
			userData.getNext()
			# Call the registered onclick function
			# console.log attrs.listClick
			# scope.$apply (self) ->
			# scope[attrs.callback]()
			# console.log scope.$eval(attrs.listClick)
