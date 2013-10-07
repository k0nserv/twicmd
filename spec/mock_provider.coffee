Stream = require("stream")

class Mock extends Stream

    constructor: () ->
        @readable   = true

    stream: (url, opts, f) ->
        f @

        return @

    write: (data) ->
        @emit "data", data

    end: (data) ->
        @emit "end", data

module.exports = Mock