'use strict'

describe 'Directive: recommendation', () ->
  beforeEach module 'movieguruApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<recommendation></recommendation>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the recommendation directive'
