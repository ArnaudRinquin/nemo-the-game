import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

playdate.display.setRefreshRate(20)

local gfx = playdate.graphics
local screenWidth = playdate.display.getWidth()
local screenHeight = playdate.display.getHeight()

local score = 0
local playerSprite = nil
local ennemySprites = {}

function isSpriteOutOfScreen(sprite)
  local spriteWidth = sprite.width
  local spriteX = sprite.x

  return spriteX < -spriteWidth/2 or spriteX > screenWidth + spriteWidth/2
end

function resetEnnemy(sprite)
  sprite:moveTo(screenWidth - (sprite.width /2) + math.random(0, 200), math.random(0, screenHeight))
end

local function initialize()
  local playerImage = gfx.image.new("images/fish")
  assert(playerImage)
  playerSprite = gfx.sprite.new( playerImage )
  playerSprite:setCollideRect(5, 12, 36, 24)
  playerSprite:moveTo(playerImage.width/2, screenHeight / 2 )
  playerSprite:add()

  local ennemyImage = gfx.image.new("images/fish-2")
  assert(ennemyImage)

  for i = 1,5 do
    local ennemySprite = gfx.sprite.new( ennemyImage )
    ennemySprite:setCollideRect(5, 12, 36, 24)
    ennemySprite:add()
    resetEnnemy(ennemySprite)
    ennemySprites[i] = ennemySprite
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

  local c = playdate.getCrankPosition()
  local pos = c < 180 and c / 180 * screenHeight or (360 - c) / 180 * screenHeight
  playerSprite:moveTo( playerSprite.width/2,  pos)

  for i = 1,#ennemySprites do
    local ennemySprite = ennemySprites[i]
    ennemySprite:moveBy( -10, 0 )
    if (isSpriteOutOfScreen(ennemySprite)) then
      score += 1
      resetEnnemy(ennemySprite)
    end
  end

  local collisions = playerSprite:overlappingSprites()

  if #collisions > 0 then
    score = 0
  end

  gfx.sprite.update()
  gfx.drawText("Score: " .. score, 320, 5)

  playdate.timer.updateTimers()


end