'use strict';

angular.module('movieguruApp')
  .factory 'findMovies', ($http) ->
    # Service logic
    data =
      results: []
      fetching: false

    searchMovies = (query) ->
      console.log query
      data.fetching = true
      $http.get('http://localhost:5000/search/'+query)
      .success (results) ->
        data.results = results
        data.fetching = false

    # Public API here
    {
      search: (query) ->
        searchMovies query

      data: data

    }
