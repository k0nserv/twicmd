TwiCmd  = require("./twicmd.coffee")
twitter = require("twitter")

twitt = new twitter
                consumerKey: "Consumer key here"
                consumerSecret: "Consumer secret here"
                accessTokenKey: "Access token here"
                accessTokenSecret: "Access Secret here"

twicmd = new TwiCmd
                tweetProvider: twitt
                tweeters: ["xxxxxxxxxxx"] #Numerical twitter ids
                commands:
                        test: ->    #Availiable command triggd by #test
                            console.log "Test"
                invokingTag: "#mycustominvokingtag"

twicmd.addCommand "rs", () ->
    #Restart something

twicmd.start()

setInterval (->), 5000 #Prevent process shutdown
