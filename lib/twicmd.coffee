_ = require("underscore")
twitter = require("twitter")

DEFAULT_PARAMETERS =
    interval: 30

INVOKING_TAG = "#twicmd"
HASH_REGEX   = ///(:?\W|^)\#([A-z0-9])+///g

# Parameters:
#   tweeters: An array of Tweeters to watch
#   command: An object with command as keys and functions as values
#   interval: The time interval between polling in seconds
class TwiCmd
    #private
    handleData = (data) ->
        console.log data

    #public
    constructor: (parameters) ->
        _params = _.clone DEFAULT_PARAMETERS
        _params = _.extend _params, parameters

        @tweeters = _params.tweeters || []
        @commands = _params.commands || {}
        @interval = _params.interval

        @consumerKey    = _params.consumerKey
        @consumerSecret = _params.consumerSecret

        @accessTokenKey     = _params.accessTokenKey
        @accessTokenSecret  = _params.accessTokenSecret

        if (_.isUndefined @consumerKey) or (_.isUndefined @consumerSecret) or
           (_.isUndefined @accessTokenKey) or (_.isUndefined @accessTokenSecret)
            throw new TypeError "Consumer key, secret and Access token key and secret is required"

        @twitt = new twitter
                    consumer_key: @consumerKey
                    consumer_secret: @consumerSecret
                    access_token_key: @accessTokenKey
                    access_token_secret: @accessTokenSecret

        @running  = false

    addTweeter: (handle) ->
        @tweeters.push handle

    addCommand: (command, callback) ->
        if not _.isFunction callback
            throw new TypeError "Callback should be a function"

        @commands[command] = callback

    start: () ->
        _follow = @tweeters.join ","

        @stream = twitt.stream 'statuses/filter', { follow: _follow, track: INVOKING_TAG }, (stream) ->
            @stream = stream

            stream.on 'data', handleData.bind this


    stop: () ->


if (not _.isUndefined module) && module.exports
    module.exports = TwiCmd