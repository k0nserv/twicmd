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

	    //Tag needed to invoke a command besides the command tag
	    //Defaults to #twicmd
		invokingTag: "#myCustomInvokingTag"
	})

twicmd.addCommand("rs", function () {
	console.log("Restart a service")
});

twicmd.start();

setInterval(function() {},5000); //Prevent process shutdown
```

###Coffeescript

```Coffeescript
TwiCmd  = require("twicmd")

twicmd = new TwiCmd
                tweeters: ["xxxxxxxxxxx"] #Numerical twitter ids
                commands:
                        test: ->    #Available command triggered by #test
                            console.log "Test"
                consumerKey: "Consumer key here"
                consumerSecret: "Consumer secret here"
                accessTokenKey: "Access token here"
                accessTokenSecret: "Access Secret here"
                #Tag needed to invoke a command besides the command tag
	    		#Defaults to #twicmd
                invokingTag: "#mycustominvokingtag"

twicmd.addCommand "rs", () ->
    console.log "Restart a service"

twicmd.start()

setInterval (->), 5000 #Prevent process shutdown
```

Documentation
-------------

###TwiCmd Constructor
`TwiCmd (parameters)`

####tweeters

An array of twitter ids who can trigger commands. Only direct tweets from these tweeters actually trigger commands. If the array is left empty twicmd runs in public mode were anyone can trigger commands, be careful with this.

####Commands
An object representing the available commands. Each key will represent a command. Commands are invoked by using them in tweets as hashtags along with the invokingTag. The value of each key should be a function to run when the command is triggered.

**Example**

```javascript
{
	restart: function () {/* … */},
	stop: function () {/* … */}

}
```

Triggering the restart command is done with the following tweet `#twicmd #restart` given that the invoking tag has not been changed.

####ConsumerKey, ConsumerSecret, AccessTokenkey, AccessTokenSecret

Used for authentication with Twitter's streaming API. For further details on generating these see Twitter's developer [documentation](https://dev.twitter.com/docs/auth/oauth#user-context).

####Invokingtag

The extra tag required to invoke a command besides the command tag.

**Default:** `#twicmd`

License
-------
MIT, see license file
