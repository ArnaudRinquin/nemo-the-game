local gfx = playdate.graphics
local ennemyImage = gfx.image.new("images/fish-2")

class('Ennemy').extends(gfx.sprite)
function Ennemy:init(scoreboard)
  Ennemy.super.init(self)
  assert(ennemyImage)
  self.speed = math.random(7, 12)
  self.scale = math.random(7, 13) / 10
  self:setImage(ennemyImage)
  self:setScale(self.scale, self.scale)
  self:setCollideRect(0, 0, self.width, self.height)
  self:setGroups({GROUP_ENNEMY})
  self:setCollidesWithGroups({GROUP_PLAYER})
  self:reset()
  self:add()
  self.scoreboard = scoreboard
end

function Ennemy:update()
  self:moveBy( -self.speed, 0 )

  local actualX, actualY, collisions, lenght = self:moveWithCollisions( self.x - self.speed, self.y)
  for index, collision in ipairs(collisions) do
    local collidedObject = collision['other']
    if collidedObject:isa(Player) then
      self.scoreboard:reset()
    end
end

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
