require "open_weather";
require "serial_api";

local function ready()
    if owe.status() == nil then
        return true
    end
    sapi.send_error()
    return false
end

function scmd.WHW()
    if owe.has_weather() then
        sapi.send_ok()
    else
        sapi.send_error()
    end
end

function scmd.WST()
    local status = owe.status()
    if status == nil then
        sapi.send_ok()
    else
        sapi.send(status)
    end
end

-- formatted weather text for 3 days intended to be used with LEDClock
function scmd.WFF()
    if not ready() then
        return
    end
    sapi.send(owe.forecast_text())
end

-- forecast icons
function scmd.WFC()
    scmd.WCW("icons")
end

-- current weather
-- Possible params:
-- - temp - current temp
-- - icons - current icons
function scmd.WCW(param)
    if ready() == false then
        return
    end
    sapi.send(owe.current(param))
end



