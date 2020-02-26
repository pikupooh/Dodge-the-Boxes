player = class{}

function player:init(x,y)
  self.x = x
  self.y = y
end

function player:update (dt)
  if love.keyboard.isDown('up') and self.y > 20 then
    self.y = self.y - PLAYER_SPEED * dt
  elseif love.keyboard.isDown('down') and self.y < WINDOW_HEIGHT - PLAYER_DIMENSIONS - 10 then
    self.y = self.y + PLAYER_SPEED * dt
  elseif love.keyboard.isDown('right') and self.x < WINDOW_WIDTH - PLAYER_DIMENSIONS - 10 then
    self.x = self.x + PLAYER_SPEED * dt
  elseif love.keyboard.isDown('left') and self.x > 10 then
    self.x = self.x - PLAYER_SPEED * dt
  end
end

function player:collide(enemy)
  if self.x + PLAYER_DIMENSIONS - 5 >= enemy.x and self.x + 5 <= enemy.x + ENEMY_DIMENSION then
    if self.y - 5 + PLAYER_DIMENSIONS >= enemy.y and self.y + 5 <= enemy.y + ENEMY_DIMENSION then
      return true
    end
  end
  return false
end

function player:render ()
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle('fill', self.x, self.y, PLAYER_DIMENSIONS, PLAYER_DIMENSIONS)
  love.graphics.setColor(1, 1, 1)
end
