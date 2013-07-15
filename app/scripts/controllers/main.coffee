'use strict'

angular.module('movieguruApp')
	.controller 'MainCtrl', ($scope, userData, pullRecs) ->

		# Refactor so that this guy holds the state, and all of the other directives and services are two-way bound to it

		# On controller load, call movies.get to load any existing data from localstorage
		$scope.movies = userData.get()

		$scope.showSearch = true
		$scope.showRecs = true

		console.log $scope.movies



		$scope.addFavorite = (movie) ->
			isIn = $scope.memberCheck movie
			if isIn.faves
				# Don't do anything
        console.error 'already in faves'
			else
				if isIn.blacklist
					# Remove from the blacklist
				else if isIn.later
					# Remove from later
				else if isIn.queue
					# Remove from the queue
          console.log 'remove from queue'

        # Add to faves
        $scope.movies.faves.push movie

        # Pull recommendations
        recs = pullRecs.get movie, $scope.movies
        console.log recs


		$scope.memberCheck = (movie) ->
			# Check if this movie exists in any lists, and return the object from that list if so
			results =
					faves:  _.findWhere($scope.movies.faves, {imdb_id: movie.imdb_id})
					blacklist: _.findWhere($scope.movies.blacklist, {imdb_id: movie.imdb_id})
					later: _.findWhere($scope.movies.later, {imdb_id: movie.imdb_id})
					queue: _.findWhere($scope.movies.queue, {imdb_id: movie.imdb_id})

			console.log results

			return results

		# $scope.showRecs = true

		# $scope.userData = userData.get {userid: id}

		# Need to figure out the scope on the recommendations directive for this to work properly. right now setting it to & works, but only when true?



		# $scope.awesomeThings = [
		#   'HTML5 Boilerplate',
		#   'AngularJS',
		#   'Karma'
		# ]

	#   $scope.searchMovies = (query, callback) ->
	#     # ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota","North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
	# #     $http.get('/stations/autocomplete?term='+query).success(function(stations) {
	# #   callback(stations); // This will automatically open the popup with retrieved results
	# # });
	#     # $http.get('http://localhost:9292/api.trakt.tv/search/movies.json/d5cadc7325bf0642b11b8439f8fe09f5/'+query)
	#     # $http.get('http://localhost:9292/api.rottentomatoes.com/api/public/v1.0/movies.json?q='+query+'&apikey=9ays5wpy937m92qenf8nyhdv')
	#     $http.get('http://localhost:5000/search/'+query)
	#     .success (results) ->
	#       matches = []
	#       for result in results
	#         # console.log result
	#         string = result.title + ' ('+result.year+')'
	#         matches.push string
	#       console.log matches
	#       callback matches
