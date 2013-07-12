'use strict'

describe 'Directive: movieSearch', () ->
  beforeEach module 'movieguruApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<movie-search></movie-search>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the movieSearch directive'
