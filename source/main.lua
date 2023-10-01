import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "scripts/Player"
import "scripts/Ennemy"

playdate.display.setRefreshRate(20)

gfx = playdate.graphics
screenWidth = playdate.display.getWidth()
screenHeight = playdate.display.getHeight()
score = 0

local function initialize()
  Player()
  for i = 1,5 do
    Ennemy()
  end

  local backgroundImage = gfx.image.new( "images/bg" )
  assert(backgroundImage)
  gfx.sprite.setBackgroundDrawingCallback(
    function( x, y, width, height )
        -- x,y,width,height is the updated area in sprite-local coordinates
        -- The clip rect is already set to this area, so we don't need to set it ourselves
        backgroundImage:draw( 0, 0 )
    end
  )
end

initialize()

function playdate.update()
  playdate.timer.updateTimers()
  gfx.sprite.update()
  gfx.drawText("Score: " .. score, 320, 5)
end
