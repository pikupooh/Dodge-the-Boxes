enemy = class{}

function enemy:init(tilenumber, direction, allign)
  self.direction = direction
  self.allign = allign
  if self.allign == 0 then
    self.x = tilenumber * ENEMY_DIMENSION
    self.y = direction * WINDOW_HEIGHT
  elseif self.allign == 1 then
    self.x = direction * WINDOW_WIDTH
    self.y = tilenumber * ENEMY_DIMENSION
  end
end

function enemy:update(dt)
  if self.allign == 0 then
    if self.direction == 0 then
      self.y = self.y + ENEMY_SPEED * dt
    elseif self.direction == 1 then
      self.y = self.y - ENEMY_SPEED * dt
    end
  elseif self.allign == 1 then
    if self.direction == 0 then
      self.x = self.x + ENEMY_SPEED * dt
    elseif self.direction == 1 then
      self.x = self.x - ENEMY_SPEED * dt
    end
  end
end

function enemy:render()
  if self.allign == 0 then
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', self.x,self.y, ENEMY_DIMENSION, ENEMY_DIMENSION)
    love.graphics.setColor(1, 1, 1)
  elseif self.allign == 1 then
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', self.x,self.y, ENEMY_DIMENSION, ENEMY_DIMENSION)
    love.graphics.setColor(1, 1, 1)
  end
end
