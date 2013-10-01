TwiCmd  = require("./twicmd.coffee")

twicmd = new TwiCmd
                tweeters: ["xxxxxxxxxxx"] #Numerical twitter ids
                commands:
                        test: ->    #Availiable command triggd by #test
                            console.log "Test"
                consumerKey: "Consumer key here"
                consumerSecret: "Consumer secret here"
                accessTokenKey: "Access token here"
                accessTokenSecret: "Access Secret here"
                invokingTag: "#mycustominvokingtag"

twicmd.addCommand "rs", () ->
    #Restart something

twicmd.start()

setInterval (->), 5000 #Prevent process shutdown
