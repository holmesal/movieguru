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
        # console.dir res
        # console.log results
        # data.results = res
        # console.log results
        # results = results

    # Public API here
    {
      search: (query) ->
        searchMovies query

      data: data
      
    }
