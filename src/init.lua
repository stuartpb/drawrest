local httpServer = require('httpserv')

-- wired up per http://www.microyum.cc/wp-content/uploads/2018/06/2.0-SPI-wiring-1024x1024.jpg

screen = require('ili9225')()

screen:init()

screen.init = nil

local function httpHandler(req, res)
  local function booly(v)
    if v == nil or v == 'nil'
      or v == 'null' or v == 'undefined' then return nil
    elseif type(v) == 'number' then return v > 0
    elseif v == 'false' or v == 'no' then return false
    else return v == 'true' or v == 'yes' or v end
  end

  -- If we're receiving screen content
  if req.url:sub(1, 6) == '/blit?' and req.method == 'POST' then

    -- Push every chunk we receive to the screen
    function req:ondata(chunk)
      if chunk then
        screen:fill(chunk)

      -- Finish the request once chunks are done
      else
        res:send()
        res:finish()
      end
    end

  -- If we're setting the window
  elseif req.url:sub(1, 8) == '/window?' and req.method == 'POST' then

    -- Process query string parameters
    local q = {}
    for k, v in req.url:sub(9):gmatch('([^&]-)=([^&]*)') do
      q[k] = tonumber(v) or v
    end

    -- Set the window and move to the starting point
    screen:window(q.x0, q.x1, q.y0, q.y1, booly(q.landscape))
    screen:jump(q.x0, q.y0)

    -- Send an OK response
    res:send()
    res:finish()

  -- If it's a request to any other endpoint
  else
    -- technically, due to the HTTP server implementation ganked here's hacks,
    -- this is going to send "404 Not Found OK", but I'm "OK" with that
    res:send(nil, '404 Not Found')
    res:finish()
  end
end

httpServer.createServer(80, httpHandler)
