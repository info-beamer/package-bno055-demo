gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT*0.95)

local angle = 0
local vid

local font = resource.load_font "OpenSans-Bold.ttf"

util.data_mapper{
    rotate = function(new_angle)
        angle = tonumber(new_angle)
    end
}

util.json_watch("config.json", function(config)
    if vid then
        vid:dispose()
    end
    vid = resource.load_video{
        file = config.video.asset_name,
        looped = true,
    }
end)

function node.render()
    gl.translate(WIDTH/2, HEIGHT/2)
    gl.rotate(angle, 0, 0, 1)
    gl.scale(2, 2, 1)
    util.draw_correct(vid, -WIDTH/2, -HEIGHT/2, WIDTH/2, HEIGHT/2)

    local scale = (1+math.abs(math.cos(angle/180*math.pi)))/2
    gl.scale(scale, scale, 1)
    local text = "Hello World!"
    local w = font:width(text, 50)
    font:write(-w/2, -50/2, text, 50, 1,1,1,1)
end
