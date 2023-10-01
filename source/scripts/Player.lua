local gfx = playdate.graphics

class('Player').extends(gfx.sprite)
function Player:init(scoreboard)
  Player.super.init(self)
  local playerImage = gfx.image.new("images/fish")
  assert(playerImage)
  self:setImage(playerImage)
  self:setCollideRect(0, 0, self.width, self.height)
  self:setGroups({GROUP_PLAYER})
  self:moveTo(0, screenHeight / 2)
  self:add()
  self.scoreboard = scoreboard
end

function Player:update()
  local c = playdate.getCrankPosition() - 90
  local rad = math.rad(c)
  local y = math.sin(rad) * screenHeight / 2 + screenHeight / 2
  self:moveTo(self.width/2,  y)
end