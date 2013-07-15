'use strict';

angular.module('movieguruApp')
  .factory 'userData', ($http) ->

	# TODO: Clean this shit up. At least separate the http requests from the recommendation management
	# TODO: refactor addFavorite and favoriteRecommendation (and the other methods too)

	# Later, pull this from localstorage
	# data = 
	# 	faves: []
	# 	blacklist: []
	# 	later: []
	# 	queue: []
	# 	currentRecommendation: null
	# 	fetching: false

	get = () ->
		# TODO: Check if in localstorage, and fetch from there

		# No userdata, so return the defaults
		data = 
			faves: []
			blacklist: []
			later: []
			queue: []
			currentRec: {}
			fetching: false


	addFavorite = (fave) ->
		# Make sure this hasn't already been favorited
		# existing = 
		# Add to the list of faves
		data.faves.push fave

		# If it's in the queue, remove it
		# console.log _.findWhere(data.queue, {imdb_id: fave.imdb_id})
		# if _.findWhere(data.queue, {imdb_id: fave.imdb_id})
		# 	console.error 'addfavorite called!'
		# 	removeFromQueue fave

		# Pull some recommendations for this movie
		recommend fave


	# Get recommendations based on a movie
	recommend = (movie) ->
		# Grab the id
		id = movie.imdb_id
		# Call the api
		$http.get('http://localhost:5000/recommend/'+id)
		.success (results) ->
			addRecommendations results

	# Check for duplicates and add the returned recommendations to the queue
	addRecommendations = (movies) ->
		for movie in movies
			console.log movie.title
			# Is this movie already in the blacklist or the favorites?
			blacklisted = _.findWhere data.blacklist, {imdb_id: movie.imdb_id}
			faved = _.findWhere data.faves, {imdb_id: movie.imdb_id}
			latered = _.findWhere data.later, {imdb_id: movie.imdb_id}
			if not blacklisted and not faved and not latered
				# Is this movie already in the queue?
				existing = _.findWhere data.queue, {imdb_id: movie.imdb_id}
				if existing
					# Bump the existing rank
					existing.rank += 1
					console.log 'found! rank is ' + existing.rank
				else
					# Set the rank to 1
					movie.rank = 1
					# Push onto the queue
					data.queue.unshift movie
					console.log 'not found! rank is 1'
			else
				console.error 'found in the blacklist, favorites, or laters, so not adding'

	# Get the next highest-ranked movie in the queue
	getNext = ->
		# Don't do anything if the queue is empty
		if data.queue.length > 0
			# Get the highest-ranked movie
			# TODO: Next is -Infinity in some cases? Happens when there is no fanart for top recommendation
			next = _.max data.queue, (movie) ->
				return movie.rank
			console.log data.queue
			console.log next
			# Set the as current recommendation
			data.currentRecommendation = next

	# Take a recommendation, add it to the favorites, and remove it from the queue
	favoriteRecommendation = (movie) ->
		# Add the favorite, which kicks off the recommendations request
		addFavorite movie
		# Remove it from the queue
		removeFromQueue movie
		# Get the next best recommendation
		getNext()

	blacklistRecommendation = (movie) ->
		console.log 'blacklisting recommendation!'
		# Add it to the blacklist
		data.blacklist.push movie
		# Remove it from the queue
		removeFromQueue movie
		# Get the next best recommendation
		getNext()

	laterRecommendation = (movie) ->
		console.log 'reminding you later!'
		# Add it to the later list
		data.later.push movie
		# Remove it from the queue
		removeFromQueue movie
		# Get the next best recommendation
		getNext()

	removeFromQueue = (movie) ->
		# Necessary because the object returned from the API isn't identical to the angular object
		toRemove = _.findWhere(data.queue, {imdb_id: movie.imdb_id})
		if toRemove
			idx = data.queue.indexOf toRemove
			console.error 'removing: ' + toRemove.title
			data.queue.splice idx,1


		
	# data.faves.push
	# 	title: 'a faved title'

	# data.blacklisted.push
	# 	title: 'a blacklisted title'

	# data.later.push
	# 	title: 'a later title'

	# Public API here
	{
		get: get

		# data: data

		# addFavorite: addFavorite

		# getNext: getNext

		# favoriteRecommendation: favoriteRecommendation

		# blacklistRecommendation: blacklistRecommendation

		# laterRecommendation: laterRecommendation
	}
