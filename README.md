TwiCmd
======
TwiCmd is a small node module which enables triggering commands on a remote server using your public twitter stream.

**Out hiking and need to restart nginx or run a script? Send a short Tweet**

**Connect it to your lights and use twitter to turn them on and off**


###Concerns

* My twitter stream is public, commands could reveal to much about the computer I am controlling. **True, but you can name commands what ever you want. For example `#yolo #bro` to restart a service or clear a log.**
* It's not verbose enough. **Any problem that can be diagnosed and fixed using a script is a potential candidate for a command**

###Motivation

* Everyone has Twitter (almost)
* Twitter is available on all platforms (almost)
* Twitter is mobile
* Twitter handles authentication
* SSH access is not as mobile

Twicmd is suggested to be used with the [twitter](https://npmjs.org/package/twitter) module for twitter API communication. Add it to your dependencies or install it using `npm install -g twitter`

Examples
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
                        test: ->    #Available command triggered by #test
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

An array of twitter ids specifying who can trigger commands. Only direct tweets from these tweeters can trigger commands. If the array is left empty twicmd runs in public mode were anyone can trigger commands, this is not recommended.

####Commands
An object representing the available commands. Each key will represent a command. Commands are invoked by using them in tweets as hashtags along with the invoking tag. The value of each key should be a function to run when the command is triggered.

**Example**

```javascript
{
	restart: function () {/* … */},
	stop: function () {/* … */}

}
```

Triggering the restart command is done with the following tweet `#twicmd #restart` given that the invoking tag has not been changed from the default.

####TweetProvider
A tweet provider. The node module [twitter](https://npmjs.org/package/twitter) is suggested.
The tweet provider should provide a method called `stream` with the same signature as the `stream` method in the twitter module.


####invokingTag

The extra tag required to invoke a command besides the command tag.

**Default:** `#twicmd`

License
-------
MIT, see license file