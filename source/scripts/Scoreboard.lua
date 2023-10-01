local gfx = playdate.graphics

class("Scoreboard").extends(gfx.sprite)

function Scoreboard:init()
  Scoreboard.super.init(self)
  self.score = 0
  self:moveTo(320, 5)
  self:setZIndex(100)
  self:setCenter(0, 0)
  self:add()
end

function Scoreboard:update()
  local displayString = "Score: " .. self.score
  local displayTextWidth, displayTextHeight = gfx.getTextSize(displayString)
  local displayImage = gfx.image.new(displayTextWidth, displayTextHeight)
  gfx.pushContext(displayImage)
    gfx.drawText(displayString, 0, 0)
  gfx.popContext()
  self:setImage(displayImage)
end

function Scoreboard:increment()
  self.score = self.score + 1
end

function Scoreboard:reset()
  self.score = 0
end