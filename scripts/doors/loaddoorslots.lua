ScriptHost:LoadScript("scripts/doors/locations/Celadon.lua")
ScriptHost:LoadScript("scripts/doors/locations/Cerulean.lua")
ScriptHost:LoadScript("scripts/doors/locations/CeruleanCave.lua")
ScriptHost:LoadScript("scripts/doors/locations/Cinnabar.lua")
ScriptHost:LoadScript("scripts/doors/locations/Dept.lua")
ScriptHost:LoadScript("scripts/doors/locations/DottedHole.lua")
ScriptHost:LoadScript("scripts/doors/locations/Five.lua")
ScriptHost:LoadScript("scripts/doors/locations/Four.lua")
ScriptHost:LoadScript("scripts/doors/locations/Fuchsia.lua")
ScriptHost:LoadScript("scripts/doors/locations/Icefall.lua")
ScriptHost:LoadScript("scripts/doors/locations/Indigo.lua")
ScriptHost:LoadScript("scripts/doors/locations/Lavender.lua")
ScriptHost:LoadScript("scripts/doors/locations/LostCave.lua")
ScriptHost:LoadScript("scripts/doors/locations/Mansion.lua")
ScriptHost:LoadScript("scripts/doors/locations/MtEmber.lua")
ScriptHost:LoadScript("scripts/doors/locations/MtMoon.lua")
ScriptHost:LoadScript("scripts/doors/locations/NavelRock.lua")
ScriptHost:LoadScript("scripts/doors/locations/One.lua")
ScriptHost:LoadScript("scripts/doors/locations/Pewter.lua")
ScriptHost:LoadScript("scripts/doors/locations/RocketHideout.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route2.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route4.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route5.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route6.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route7.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route8.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route10.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route11.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route12.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route15.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route16.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route18.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route20.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route22.lua")
ScriptHost:LoadScript("scripts/doors/locations/Route25.lua")
ScriptHost:LoadScript("scripts/doors/locations/Saffron.lua")
ScriptHost:LoadScript("scripts/doors/locations/SeafoamIslands.lua")
ScriptHost:LoadScript("scripts/doors/locations/Seven.lua")
ScriptHost:LoadScript("scripts/doors/locations/Silph1.lua")
ScriptHost:LoadScript("scripts/doors/locations/Silph2.lua")
ScriptHost:LoadScript("scripts/doors/locations/Six.lua")
ScriptHost:LoadScript("scripts/doors/locations/SSAnne.lua")
ScriptHost:LoadScript("scripts/doors/locations/Three.lua")
ScriptHost:LoadScript("scripts/doors/locations/Two.lua")
ScriptHost:LoadScript("scripts/doors/locations/Vermilion.lua")
ScriptHost:LoadScript("scripts/doors/locations/VictoryRoad.lua")
ScriptHost:LoadScript("scripts/doors/locations/Viridian.lua")

for t = 1, #DoorSlot.Icons do
    if DoorSlotSelection.Types[t] then
        DoorSlotSelection(t)
    end
end

local dead_end = Tracker:FindObjectForCode("doorslot_dead_end")
if dead_end then
    dead_end.ItemState:onRightClick()
end