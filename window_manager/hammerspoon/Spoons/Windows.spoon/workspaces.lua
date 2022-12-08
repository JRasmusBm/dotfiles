-- docs
local laptopScreen = "Color LCD"
    local windowLayout = {
        {"Safari",  nil,          laptopScreen, hs.layout.left50,    nil, nil},
        {"Mail",    nil,          laptopScreen, hs.layout.right50,   nil, nil},
        {"iTunes",  "iTunes",     laptopScreen, hs.layout.maximized, nil, nil},
        {"iTunes",  "MiniPlayer", laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
    }
    hs.layout.apply(windowLayout)
