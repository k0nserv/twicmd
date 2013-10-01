_ = require("underscore")
twitter = require("twitter")

DEFAULT_PARAMETERS =
    invokingTag: "#twicmd"

HASH_REGEX   = ///(?:\W|^)\#([A-z0-9]+)///g

# Parameters:
#   tweeters: An array of Tweeters to watch
#   command: An object with command as keys and functions as values
#   invokingTag: A tag which is required for events to trigger. Defaults to #twicmd
class TwiCmd
    #private
    handleData = (data) ->
        text = data.text

        while match = HASH_REGEX.exec(text)
            if match.length > 1
                tag = match[1]
                if (@commands.hasOwnProperty tag) and (_.isFunction @commands[tag])
                    @commands[tag]() if _.contains @tweeters, data.user.id_str


    #public
    constructor: (parameters) ->
        _params = _.clone DEFAULT_PARAMETERS
        _params = _.extend _params, parameters

        @tweeters = _params.tweeters || []
        @commands = _params.commands || {}

        @consumerKey    = _params.consumerKey
        @consumerSecret = _params.consumerSecret

        @accessTokenKey     = _params.accessTokenKey
        @accessTokenSecret  = _params.accessTokenSecret

        @invokingTag = _params.invokingTag

        if (_.isUndefined @consumerKey) or (_.isUndefined @consumerSecret) or
           (_.isUndefined @accessTokenKey) or (_.isUndefined @accessTokenSecret)
            throw new TypeError "Consumer key, secret and Access token key and secret is required"

        if @tweeters.length == 0
            throw new TypeError "Atleast one tweeter is required"


        @twitt = new twitter
                    consumer_key: @consumerKey
                    consumer_secret: @consumerSecret
                    access_token_key: @accessTokenKey
                    access_token_secret: @accessTokenSecret

        @running  = false

    addCommand: (command, callback) ->
        if not _.isFunction callback
            throw new TypeError "Callback should be a function"

        @commands[command] = callback

    start: () ->
        @running = true
        _follow = @tweeters.join ","
        that = this

        @stream = @twitt.stream 'statuses/filter', { track: @invokingTag, follow: _follow}, (stream) ->
            @stream = stream

            stream.on 'data', handleData.bind(that)
            stream.on 'end', (response) ->
                console.log "Connection to the streaming API ended"
                that.stop()

            stream.on 'error', (error) ->
               console.log "An error occured: ", error

    stop: () ->
        @running = false
        if not _.isUndefined @stream
            @stream.destroy()

    isRunning: () ->
        return @running

if (not _.isUndefined module) && module.exports
    module.exports = TwiCmd