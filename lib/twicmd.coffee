_ = require "underscore"

DEFAULT_PARAMETERS
    interval: 30
#
# Parameters:
#   tweeters: An array of Tweeters to watch
#   command: An object with command as keys and functions as values
#   interval: The time interval between polling in seconds
#
class TwiCmd
    constructor: (parameters) ->
        @tweeters = parameters.tweeters || []
        @commands = parameters.commands || {}
        @interval = parameters.interval

    addTweeter: (handle) ->
        @tweeters.push handle

    addCommand: (command, callback) ->
        if not _.isFunction callback
            throw
                error: "Parameter error"
                msg: "Callback should be a function"

        @commands[command] = callback

if (not _.isUndefined module) && module.exports
    module.exports = TwiCmd
