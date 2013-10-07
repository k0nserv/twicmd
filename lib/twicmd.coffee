_ = require("underscore")

DEFAULT_PARAMETERS =
    invokingTag: "#twicmd"

HASH_REGEX   = ///(?:\W|^)\#([A-z0-9]+)///g

# Parameters:
#   tweetProvider: An instance of Twitter from the twitter module
#   tweeters: An array of Tweeters to watch
#   command: An object with command as keys and functions as values
#   invokingTag: A tag which is required for events to trigger. Defaults to #twicmd
class TwiCmd
    #private
    handleData = (data) ->
        text = data.text

        return if text.indexOf(@invokingTag) == -1

        while match = HASH_REGEX.exec(text)
            if match.length > 1
                tag = match[1]
                if (@commands.hasOwnProperty tag) and (_.isFunction @commands[tag])
                    @commands[tag]() if (_.contains(@tweeters, data.user.id_str) or @tweeters.length == 0)

    #public
    constructor: (parameters) ->
        _params = _.clone DEFAULT_PARAMETERS
        _params = _.extend _params, parameters

        @tweeters = _params.tweeters || []
        @commands = _params.commands || {}

        @invokingTag = _params.invokingTag

        if @tweeters.length == 0
            console.log "Warning: Running in public mode anyone can invoke commands"


        @twitt = _params.tweetProvider
        if _.isUndefined @twitt
            throw new TypeError "Tweetprovider must be provided"

        @running  = false

    addCommand: (command, callback) ->
        if not _.isFunction callback
            throw new TypeError "Callback should be a function"

        @commands[command] = callback

    start: () ->
        @running = true
        that = this

        opts = {}
        opts.track = @invokingTag

        if @tweeters.length > 0
            opts.follow = @tweeters.join ","

        @stream = @twitt.stream 'statuses/filter', opts, (stream) ->
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