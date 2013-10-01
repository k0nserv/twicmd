TwiCmd
======

TwiCmd let's you trigger events on your node.js server using your public twitter stream.
TiCmd uses the twitter streaming API and therefor requires a user context to run. Keys and
secrets are passed to the the constructor function.

Examples you say?
-----------------

###Javascript

```javascript
var TwiCmd  = require("twicmd"),
	twicmd = new TwiCmd({
		tweeters: ["xxxxxxxx"], //Numerical twitter ids
		commands: {
			test: function () { //Command triggered by #test
				console.log("test");
			}
		},
	    consumerKey: "Consumer key here",
	    consumerSecret: "Consumer secret here",
	    accessTokenKey: "Access token here",
	    accessTokenSecret: "Access Secret here",
	    /
	    //Tag needed to invoke a command besides the command tag
	    //Defaults to #twicmd
		invokingTag: "#myCustomInvokingTag"
	})

twicmd.addCommand("rs", function () {
	console.log("Restart a service or something else")
});

twicmd.start();

setInterva(funciton() {},5000); //Prevent process shutdown
```

###Coffeescript

```Coffeescript
TwiCmd  = require("twicmd")

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
```

License
-------
MIT, see license file
