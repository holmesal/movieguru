'use strict';

angular.module('movieguruApp')
	.directive 'movieSearch', (findMovies) ->
		templateUrl: 'views/movieSearch.html'
		restrict: 'E' # Element
		scope:
			movies: '='
			addFavorite: '&'
		link: (scope, element, attrs) ->

        # Init the query
        scope.query = ''

        # Bind to the findMovies service
        scope.data = findMovies.data



        # Watch the query for changes
        scope.$watch 'query', (query) ->
          # Empty the element if the query is emptied
          if query.length > 0
            # Fire off a search
            findMovies.search query
          else
            scope.results = []


        scope.resultClick = (result) ->
          # Add to the favorites
          scope.addFavorite
            fave: result

          # Clear out the results and the query
          scope.query = ''
          scope.data.results = []



			# Add selected movies to the favorites
			#      scope.addMovie = (chosen) ->
			#        # Push onto the list of favorites
			#        scope.movies.faves.push
			#        # Push onto the favorites via the function on the userData service
			#        userData.favoriteRecommendation chosen
			#
			#        # Reset the input field and clear the results
			#        scope.movieQuery = ''
			#        scope.finder.results = []
		#
		#        # Check out the next movie
		#        userData.getNext()








		# scope.movies = recommendations.search



		# Hook the 'results' property in the scope of the current directive up to the results provided by the findMovies service
		#      scope.finder = findMovies.data

		# scope.data = userData.data

			# Initially, there is no movieQuery
#      scope.movieQuery = ''


			# Called when a list item is clicked
				# Call the registered onclick function
				# console.log attrs.listClick
				# scope.$apply (self) ->
				# scope[attrs.callback]()
				# console.log scope.$eval(attrs.listClick)
