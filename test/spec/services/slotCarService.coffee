'use strict'

describe 'Service: slotCarService', () ->

  # load the service's module
  beforeEach module 'soSlotControlMasterApp'

  # instantiate service
  slotCarService = {}
  beforeEach inject (_slotCarService_) ->
    slotCarService = _slotCarService_

  it 'should do something', () ->
    expect(!!slotCarService).toBe true
