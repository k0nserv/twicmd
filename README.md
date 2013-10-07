TwiCmd
======

TwiCmd let's you trigger events on your node.js server using your public twitter stream.
TiCmd uses the twitter streaming API and therefor requires a user context to run. Keys and
secrets are passed to the the constructor function.

Examples you say?
-----------------

###Javascript

```javascript
var TwiCmd = require("twicmd"),
	twitter = require("twitter"),
	twicmd, twitt;

twitt = new twitter({
	consumerKey: "Consumer key here",
	consumerSecret: "Consumer secret here",
	accessTokenKey: "Access token here",
	accessTokenSecret: "Access Secret here"
});

twicmd = new TwiCmd({
	tweetProvider: twitt,
	tweeters: ["xxxxxxxx"], //Numerical twitter ids
	commands: {
		test: function () { //Command triggered by #test
			console.log("test");
		}
	},
    //Tag needed to invoke a command besides the command tag
    //Defaults to #twicmd
	invokingTag: "#myCustomInvokingTag"
});

twicmd.addCommand("rs", function () {
	console.log("Restart a service")
});

twicmd.start();

setInterval(function() {},5000); //Prevent process shutdown
```

###Coffeescript

```Coffeescript
TwiCmd  = require("twicmd")
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

####TweetProvider
A tweet provider. The node module [twitter](https://npmjs.org/package/twitter) is suggested. The TweetProvider needs to provide a method called stream with the same signature as the stream method in the twitter module.

####Invokingtag

The extra tag required to invoke a command besides the command tag.

**Default:** `#twicmd`

License
-------
MIT, see license file
