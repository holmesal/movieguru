'use strict'

describe 'Service: findMovies', () ->

  # load the service's module
  beforeEach module 'movieguruApp'

  # instantiate service
  findMovies = {}
  beforeEach inject (_findMovies_) ->
    findMovies = _findMovies_

  it 'should do something', () ->
    expect(!!findMovies).toBe true;
