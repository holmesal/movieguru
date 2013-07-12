'use strict'

describe 'Directive: bgImg', () ->
  beforeEach module 'movieguruApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<bg-img></bg-img>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the bgImg directive'
