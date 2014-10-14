searchDispatcher = require '../dispatchers/patient_search'
Request = require './server_request'
Router = require 'react-router'

module.exports = 

  executeSearch: (searchTerm) ->
    # Simple search
    if typeof searchTerm is 'string'
      searchRequest =
        term: searchTerm

    # Fixed search
    else if typeof searchTerm is 'object'
      searchRequest = 
        searchTerm

    if searchTerm.length < 2 then searchDispatcher.setSearchResults([])
    else 
      new Request(
        url: '/api/patient'
        data: searchRequest
        authenticate: on
      ).done(@setSearchResult).error(->
        console.log 'error'
      )

  setSearchResult: (data) ->
    searchDispatcher.setSearchResults(data)