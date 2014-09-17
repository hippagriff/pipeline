searchDispatcher = require '../dispatchers/patient_search'
Request = require './server_request'
Router = require 'react-router'

module.exports = 

  executeSearch: (searchTerm) ->
    new Request(
      url: '/api/patient'
      data:
        term: searchTerm
      authenticate: on
    ).done(@setSearchResult).error(->
      console.log 'error'
    )

  setSearchResult: (data) ->
    searchDispatcher.setSearchResults(data)