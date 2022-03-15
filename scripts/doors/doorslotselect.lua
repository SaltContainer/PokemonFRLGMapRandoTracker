DoorSlotSelection = CustomItem:extend()
DoorSlotSelection.Types = {
    [1] = "unknown",
    [2] = "one_way",
    [3] = "dead_end",
    [4] = "event",
    [5] = "trainer",
    [6] = "boulder_badge",
    [7] = "cascade_badge",
    [8] = "thunder_badge",
    [9] = "rainbow_badge",
    [10] = "soul_badge",
    [11] = "marsh_badge",
    [12] = "volcano_badge",
    [13] = "earth_badge",
    [14] = "e4_ice",
    [15] = "e4_fighting",
    [16] = "e4_ghost",
    [17] = "e4_dragon",
    [18] = "champ",
    [19] = "cut",
    [20] = "rock_smash",
    [21] = "strength",
    [22] = "surf",
    [23] = "waterfall",
    [24] = "hm1",
    [25] = "hm2",
    [26] = "hm3",
    [27] = "hm4",
    [28] = "hm5",
    [29] = "hm6",
    [30] = "hm7",
    [31] = "custom1",
    [32] = "custom2",
    [33] = "custom3",
    [34] = "custom4",
    [35] = "custom5",
    [36] = "custom6",
    [37] = "custom7",
    [38] = "custom8",
    [39] = "center",
    [40] = "mart",
    [41] = "bike",
    [42] = "card_key",
    [43] = "1",
    [44] = "2",
    [45] = "3",
    [46] = "4",
    [47] = "5",
    [48] = "6",
    [49] = "7",
    [50] = "8",
    [51] = "celadon",
    [52] = "cerulean",
    [53] = "cerulean_cave",
    [54] = "cinnabar",
    [55] = "dept",
    [56] = "dotted_hole",
    [57] = "five",
    [58] = "four",
    [59] = "fuchsia",
    [60] = "icefall",
    [61] = "indigo",
    [62] = "lavender",
    [63] = "lost_cave",
    [64] = "mansion",
    [65] = "mt_ember",
    [66] = "mt_moon",
    [67] = "navel_rock",
    [68] = "one",
    [69] = "pewter",
    [70] = "rocket_hideout",
    [71] = "route_2",
    [72] = "route_4",
    [73] = "route_5",
    [74] = "route_6",
    [75] = "route_7",
    [76] = "route_8",
    [77] = "route_10",
    [78] = "route_11",
    [79] = "route_12",
    [80] = "route_15",
    [81] = "route_16",
    [82] = "route_18",
    [83] = "route_20",
    [84] = "route_22",
    [85] = "route_25",
    [86] = "saffron",
    [87] = "seafoam_islands",
    [88] = "seven",
    [89] = "silph",
    [90] = "six",
    [91] = "ss_anne",
    [92] = "three",
    [93] = "two",
    [94] = "vermilion",
    [95] = "victory_road",
    [96] = "viridian"
}
DoorSlotSelection.Selection = 2

function DoorSlotSelection:init(index)
    self:createItem("Door Slot Selection")
    self.index = index
    self.code = "doorslot_" .. DoorSlotSelection.Types[index]
    self.image = DoorSlot.Icons[index]

    self:setState(0)
end

function DoorSlotSelection:setState(state)
    self:setProperty("state", state)
end

function DoorSlotSelection:getState()
    return self:getProperty("state")
end

function DoorSlotSelection:updateIcon()
    local overlay = ""
    if self:getState() > 0 then
        if DoorSlotSelection.Selection < 51 then
            overlay = "overlay|images/other/selected_tag.png"
        else
            overlay = "overlay|images/other/selected_hub.png"
        end
    end

    self.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. self.image .. ".png", overlay)
end

function DoorSlotSelection:updateNeighbors()
    for i = 1, #DoorSlot.Icons do
        if DoorSlotSelection.Types[i] and self.index ~= i then
            local item = Tracker:FindObjectForCode("doorslot_" .. DoorSlotSelection.Types[i])
            if item then
                item.ItemState:setState(0)
            end
        end
    end
end

function DoorSlotSelection:onLeftClick()
    local selection = self.index
    local current_warp = Tracker:FindObjectForCode(DoorSlot.Selection).ItemState
    local current_warp_hub = current_warp.hubIcon
    if current_warp and current_warp_hub then
        current_warp:setState(selection)
        current_warp_hub:setState(selection)
        if selection < 51 then
            current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[selection] .. ".png", "overlay|images/other/selected_tag.png")
        else
            current_warp_hub.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[selection] .. ".png", "overlay|images/other/selected_hub.png")
        end
    end
end

function DoorSlotSelection:onRightClick()
    DoorSlotSelection.Selection = self.index
    self:setState(1)
    self:updateNeighbors()
end

function DoorSlotSelection:canProvideCode(code)
    if code == self.code then
        return true
    else
        return false
    end
end

function DoorSlotSelection:providesCode(code)
    if code == self.code and self:getState() ~= 0 then
        return self:getState()
    end
    return 0
end

function DoorSlotSelection:advanceToCode(code)
    if code == nil or code == self.code then
        self:setState((self:getState() + 1) % 2)
    end
end

function DoorSlotSelection:propertyChanged(key, value)
    if key == "state" then
        self:updateIcon()
    end
end
