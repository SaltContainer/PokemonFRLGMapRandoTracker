DoorSlot = CustomItem:extend()
DoorSlot.Icons = {
    [0] = "none",
    [1] = "other/unknown",
    [2] = "other/one_way",
    [3] = "other/dead_end",
    [4] = "other/event",
    [5] = "other/trainer",
    [6] = "badges/boulder_badge",
    [7] = "badges/cascade_badge",
    [8] = "badges/thunder_badge",
    [9] = "badges/rainbow_badge",
    [10] = "badges/soul_badge",
    [11] = "badges/marsh_badge",
    [12] = "badges/volcano_badge",
    [13] = "badges/earth_badge",
    [14] = "gyms/e4_ice",
    [15] = "gyms/e4_fighting",
    [16] = "gyms/e4_ghost",
    [17] = "gyms/e4_dragon",
    [18] = "gyms/champ",
    [19] = "hms/cut",
    [20] = "hms/rock_smash",
    [21] = "hms/strength",
    [22] = "hms/surf",
    [23] = "hms/waterfall",
    [24] = "hms/hm1",
    [25] = "hms/hm2",
    [26] = "hms/hm3",
    [27] = "hms/hm4",
    [28] = "hms/hm5",
    [29] = "hms/hm6",
    [30] = "hms/hm7",
    [31] = "types/normal",
    [32] = "types/water",
    [33] = "types/grass",
    [34] = "types/electric",
    [35] = "types/poison",
    [36] = "types/fairy",
    [37] = "types/steel",
    [38] = "types/fire",
    [39] = "other/center",
    [40] = "other/mart",
    [41] = "other/bike",
    [42] = "other/card_key",
    [43] = "numbers/1",
    [44] = "numbers/2",
    [45] = "numbers/3",
    [46] = "numbers/4",
    [47] = "numbers/5",
    [48] = "numbers/6",
    [49] = "numbers/7",
    [50] = "numbers/8",
    [51] = "locations/celadon",
    [52] = "locations/cerulean",
    [53] = "locations/cerulean_cave",
    [54] = "locations/cinnabar",
    [55] = "locations/dept",
    [56] = "locations/dotted_hole",
    [57] = "locations/five",
    [58] = "locations/four",
    [59] = "locations/fuchsia",
    [60] = "locations/icefall",
    [61] = "locations/indigo",
    [62] = "locations/lavender",
    [63] = "locations/lost_cave",
    [64] = "locations/mansion",
    [65] = "locations/mt_ember",
    [66] = "locations/mt_moon",
    [67] = "locations/navel_rock",
    [68] = "locations/one",
    [69] = "locations/pewter",
    [70] = "locations/rocket_hideout",
    [71] = "locations/route_2",
    [72] = "locations/route_4",
    [73] = "locations/route_5",
    [74] = "locations/route_6",
    [75] = "locations/route_7",
    [76] = "locations/route_8",
    [77] = "locations/route_10",
    [78] = "locations/route_11",
    [79] = "locations/route_12",
    [80] = "locations/route_15",
    [81] = "locations/route_16",
    [82] = "locations/route_18",
    [83] = "locations/route_20",
    [84] = "locations/route_22",
    [85] = "locations/route_25",
    [86] = "locations/saffron",
    [87] = "locations/seafoam_islands",
    [88] = "locations/seven",
    [89] = "locations/silph",
    [90] = "locations/six",
    [91] = "locations/ss_anne",
    [92] = "locations/three",
    [93] = "locations/two",
    [94] = "locations/vermilion",
    [95] = "locations/victory_road",
    [96] = "locations/viridian"
}
DoorSlot.Selection = "slot_celadon_0"

function DoorSlot:init(roomSlot, doorSlot)
    self:createItem("Door Slot")
    self.code = "slot_" .. roomSlot .. "_" .. doorSlot
    self.roomSlot = roomSlot
    self.doorSlot = doorSlot
    self.hubIcon = nil

    self:setState(1)
end

function DoorSlot:setHubIcon(hubIcon)
    self.hubIcon = hubIcon
end

function DoorSlot:setSelection()
    DoorSlot.Selection = self.code
end

function DoorSlot:removeSelectionOverlay()
    local current_warp = Tracker:FindObjectForCode(DoorSlot.Selection).ItemState
    local state = current_warp:getState()
    if state < 51 then
        current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[state] .. ".png", "")
    else
        current_warp = Tracker:FindObjectForCode("hub" .. DoorSlot.Selection).ItemState
        current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[state] .. ".png", "")
    end
end

function DoorSlot:addSelectionOverlay()
    local state = self:getState()
    if state < 51 then
        local current_warp = Tracker:FindObjectForCode(DoorSlot.Selection).ItemState
        current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[state] .. ".png", "overlay|images/other/selected_tag.png")
    else
        local current_warp = Tracker:FindObjectForCode("hub" .. DoorSlot.Selection).ItemState
        current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[state] .. ".png", "overlay|images/other/selected_hub.png")
    end
end

function DoorSlot:setState(state)
    self:setProperty("state", state)
    DOORSLOTS[self.code] = state
end

function DoorSlot:getState()
    return self:getProperty("state")
end

function DoorSlot:updateIcon()
    if self:getState() < 51 then
        local img = DoorSlot.Icons[self:getState()]
        local imgPath = "images/" .. img .. ".png"
        local overlay = ""
        if self.code == DoorSlot.Selection then
            overlay = "overlay|images/other/selected_tag.png"
        end
        self.ItemInstance.Icon = ImageReference:FromPackRelativePath(imgPath, overlay)
    else
        self.ItemInstance.Icon = nil
    end
end

function DoorSlot:onLeftClick()
    self:removeSelectionOverlay()
    self:setSelection()
    self:addSelectionOverlay()
end

function DoorSlot:onRightClick()
    local state = DoorSlotSelection.Selection
    self:setState(state)
    self.hubIcon:setState(state)
end

function DoorSlot:manualRightClick(selection)
    self:setState(selection)
    self.hubIcon:setState(selection)
end

function DoorSlot:canProvideCode(code)
    if code == self.code then
        return true
    else
        return false
    end
end

function DoorSlot:providesCode(code)
    if code == self.code and self:getState() ~= 0 then
        return self:getState()
    end
    return 0
end

function DoorSlot:advanceToCode(code)
    if code == nil or code == self.code then
        self:setState((self:getState() + 1) % #self.Icons)
    end
end

function DoorSlot:propertyChanged(key, value)
    if key == "state" then
        self:updateIcon()
    end
end
