local pd = playdate
local gfx = playdate.graphics

class("Scoreboard").extends(gfx.sprite)

local highscore = 0

local gameData = pd.datastore.read()
if (gameData) then
  highscore = gameData.highscore
end

local function SAVE_GAME_DATA()
  pd.datastore.write({highscore = highscore})
end

function pd.gameWillTerminate()
  SAVE_GAME_DATA()
end

function pd.gameWillSleep()
  SAVE_GAME_DATA()
end

function Scoreboard:init()
  Scoreboard.super.init(self)
  self.score = 0
  self:setZIndex(100)
  self:setCenter(0, 0)
  self:add()
end

function Scoreboard:update()
  local displayString = "Score: " .. self.score .. " - Highscore: " .. highscore
  local displayTextWidth, displayTextHeight = gfx.getTextSize(displayString)
  local displayImage = gfx.image.new(displayTextWidth, displayTextHeight)
  gfx.pushContext(displayImage)
    gfx.drawTextAligned(displayString, 0, 0, kTextAlignLeft)
  gfx.popContext()
  self:setImage(displayImage)
  self:moveTo(screenWidth - displayImage.width - 5, 5)
end

function Scoreboard:increment()
  self.score = self.score + 1
  if (self.score > highscore) then
    highscore = self.score
  end
end

function Scoreboard:reset()
  self.score = 0
end

