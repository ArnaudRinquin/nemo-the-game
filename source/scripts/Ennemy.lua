local gfx = playdate.graphics
local ennemyImage = gfx.image.new("images/fish-2")

class('Ennemy').extends(gfx.sprite)
function Ennemy:init(scoreboard)
  Ennemy.super.init(self)
  assert(ennemyImage)
  self:setImage(ennemyImage)
  self:setCollideRect(5, 12, 36, 24)
  self:reset()
  self:add()
  self.scoreboard = scoreboard
end

function Ennemy:update()
  self:moveBy( -10, 0 )
  if (isSpriteOutOfScreen(self)) then
    self.scoreboard:increment()
    self:reset()
  end
end

function Ennemy:reset()
  self:moveTo(screenWidth - (self.width /2) + math.random(0, 200), math.random(0, screenHeight))
end


function isSpriteOutOfScreen(sprite)
  local spriteWidth = sprite.width
  local spriteX = sprite.x
  return spriteX < -spriteWidth/2 or spriteX > screenWidth + spriteWidth/2
end

