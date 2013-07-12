'use strict'

describe 'Service: userData', () ->

  # load the service's module
  beforeEach module 'movieguruApp'

  # instantiate service
  userData = {}
  beforeEach inject (_userData_) ->
    userData = _userData_

  it 'should do something', () ->
    expect(!!userData).toBe true;
