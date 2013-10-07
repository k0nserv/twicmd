TwiCmd      = require("../lib/twicmd.coffee")
TweetMock   = require("./mock_provider.coffee")

describe "Twicmd", () ->
    spy     = undefined
    mock    = undefined

    beforeEach () ->
        spy =
            f: () ->

        mock = new TweetMock()

    it "triggers commands on events in public mode", () ->
        twicmd = new TwiCmd
                    tweetProvider: mock
                    tweeters: []
                    commands:
                            command: () ->
                                spy.f()

                            cmd: () ->
                                spy.f()

        twicmd.addCommand "test", () ->
            spy.f()

        twicmd.start()

        spyOn spy, "f"

        mock.write
            text: "A simple tweet #twicmd #command"
            user:
                id_str: "123123123"

        mock.write
            text: "#twicmd #cmd"
            user:
                id_str: "123123123"

        mock.write
            text: "A test command #twicmd #test"
            user:
                id_str: "123123123"

        mock.write
            text: "A test command #test"  #Missing twicmd should not trigger
            user:
                id_str: "123123123"

        expect(spy.f.callCount).toEqual(3)

    it "triggers commands for single tweeter", () ->
        twetter_id      = "123123123"
        incorrect_id    = "999999999"

        twicmd = new TwiCmd
            tweetProvider: mock
            tweeters: [twetter_id]
            commands:
                command: () ->
                    spy.f()

                test: () ->
                    spy.f()

                incorrect: () ->
                    spy.f()

        twicmd.start()
        spyOn spy, "f"

        mock.write
                text: "#twicmd #command"
                user:
                    id_str: twetter_id

        mock.write
                text: "Other command #twicmd #test"
                user:
                    id_str: twetter_id

        mock.write
                text: "Correct command, incorrect tweeter #twicmd #test"
                user:
                    id_str: incorrect_id

        mock.write
                text: "Inccorect tweeter id #twicmd #incorrect"
                user:
                    id_str: incorrect_id

        expect(spy.f.callCount).toEqual 2


