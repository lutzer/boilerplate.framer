{ _ } = require("npm")

class exports.CarousselComponent extends Layer

    constructor: (@items, @shownItems, options) ->
        super(options)

        _.each @items, (item) =>
            _.extend item,
                parent : this
                visible : false

        @currentIndex = 0

    setIndex: (index) ->
        @currentIndex = index
