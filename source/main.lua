import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "scripts/Player"
import "scripts/Ennemy"
import "scripts/Scoreboard"

playdate.display.setRefreshRate(20)

gfx = playdate.graphics
screenWidth = playdate.display.getWidth()
screenHeight = playdate.display.getHeight()

GROUP_PLAYER = 1
GROUP_ENNEMY = 2

local function initialize()
  local scoreboard = Scoreboard()
  Player(scoreboard)
  for i = 1,5 do
    Ennemy(scoreboard)
  end

  local backgroundImage = gfx.image.new( "images/bg" )
  assert(backgroundImage)
  gfx.sprite.setBackgroundDrawingCallback(
    function( x, y, width, height )
        -- x,y,width,height is the updated area in sprite-local coordinates
        -- The clip rect is already set to this area, so we don't need to set it ourselves
        backgroundImage:draw( 0, screenHeight - backgroundImage.height)
    end
  )
end

initialize()

function playdate.update()
  playdate.timer.updateTimers()
  gfx.sprite.update()
end
