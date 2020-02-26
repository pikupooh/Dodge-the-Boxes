class =  require "class"
require "enemy"
require "player"

GAME_SCREEN_HEIGHT = 720
WINDOW_WIDTH = 720
WINDOW_HEIGHT = GAME_SCREEN_HEIGHT + 20

PLAYER_DIMENSIONS = 40
PLAYER_SPEED = 300

ENEMY_SPEED = 150

function love.load()
  math.randomseed(os.time())
  reset()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false ,
    vsync = true ;
    resizable = false
  })
  love.graphics.setBackgroundColor(1, 1, 1)
  love.window.setTitle('DODGE THE BOXES')
  fonts = {
    ['small'] = love.graphics.newFont('font.ttf', 4),
    ['medium'] = love.graphics.newFont('font.ttf', 16),
    ['large'] = love.graphics.newFont('font.ttf', 64)
  }
end

function love.update(dt)

  if not gamepause then
    if gameState == 1 then
      countx = countx - 1
      county = county - 0.75
      if countx < 1 then
        tilenumberX1  = Player.x / ENEMY_DIMENSION + math.random(-2, 2)
        tilenumberX2 =  Player.x / ENEMY_DIMENSION + math.random(-2, 2)
        direction = math.random(0,1)
        table.insert(Enemies, enemy(tilenumberX1, direction, 0)) ;
        table.insert(Enemies, enemy(tilenumberX2, (direction + 1) % 2, 0)) ;
        score = score + 1
        if score % 5 == 0 and score ~= 0 and COUNT_DOWN_X > 50 then
          COUNT_DOWN_X = COUNT_DOWN_X - 15
          ENEMY_DIMENSION = ENEMY_DIMENSION + 5
        end
        countx = COUNT_DOWN_X
      end

      if county < 1 then
        tilenumberX1  = Player.y / ENEMY_DIMENSION + math.random(-2, 2)
        tilenumberX2 = Player.y / ENEMY_DIMENSION + math.random(-2, 2)
        direction = math.random(0,1)
        table.insert(Enemies, enemy(tilenumberX1, direction, 1)) ;
        table.insert(Enemies, enemy(tilenumberX2, (direction + 1) % 2, 1)) ;
        score = score + 1
        if score % 5 == 0 and score ~= 0 and COUNT_DOWN_Y > 35 then
          COUNT_DOWN_Y = COUNT_DOWN_Y - 15
          ENEMY_DIMENSION = ENEMY_DIMENSION + 5
        end
        county = COUNT_DOWN_Y
      end

      for i, v in pairs(Enemies) do
        v:update(dt)
        if Player:collide(v) then
          gameState = 2
          break
        end
        if v.x > WINDOW_WIDTH + 15 or v.x < -15 or v.y > WINDOW_HEIGHT + 15 or v.y < -15  then
          table.remove(Enemies, i)
        end
      end
      Player:update(dt)
    end
  end
end

function love.keypressed(key)
  if key == 'p' or key == 'P' then
    if gamepause then
      gamepause = false
    elseif not gamepause then
      gamepause = true
    end
  end
  if key == 'escape' then
    love.event.quit()
  end
  if key == 'r' or key == 'R' then
    reset()
  end
  if key == 'space' then
    if gameState == 0 then
      gameState = 1
    elseif gameState == 1 then
      gameState = 2
    elseif gameState == 2 then
      reset()
      gameState = 1
    end
  end
end

function love.draw()
  for i, v in pairs(Enemies) do
    v:render()
  end

  if score < 1 then
    love.graphics.setFont(fonts['medium'])
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf('ARROW KEYS FOR MOVEMENT', 0, WINDOW_HEIGHT - 230, WINDOW_WIDTH, 'center')
  end
  Player:render()
  if gameState == 0 then
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(fonts['large'])
    love.graphics.printf('DODGE', 0 , 100 , WINDOW_WIDTH, 'center')
    love.graphics.setFont(fonts['medium'])
    love.graphics.printf('PRESS SPACE TO START', 0 , WINDOW_WIDTH - 260, WINDOW_WIDTH, 'center')
  end
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(fonts['medium'])
  if gameState == 1 then
    love.graphics.printf("R TO RESTART P TO PAUSE" , 0, 10, WINDOW_WIDTH, "right")
    love.graphics.printf("SCORE " .. tostring(score), 5, 10, WINDOW_WIDTH, "left")
  end
  if gameState == 2 then
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf('PRESS R OR SPACE TO RESTART', 0 , WINDOW_HEIGHT  - 50, WINDOW_WIDTH, 'center')
    love.graphics.setFont(fonts['large'])
    love.graphics.printf("SCORE " .. tostring(score), 0, WINDOW_HEIGHT/2, WINDOW_WIDTH, "center")
    love.graphics.printf('GAME OVER', 0 , WINDOW_HEIGHT / 2 - 50, WINDOW_WIDTH, 'center')
  end
  if gamepause then
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf('GAME PAUSED', 0 , WINDOW_HEIGHT/2  - 50, WINDOW_WIDTH, 'center')
  end
end

function reset()
  ENEMY_DIMENSION = 40

  Enemies = {}
  x = (WINDOW_WIDTH - PLAYER_DIMENSIONS)/2
  y = (WINDOW_HEIGHT - PLAYER_DIMENSIONS)/2
  COUNT_DOWN_X = 75
  COUNT_DOWN_Y = 75
  Player = player(x,y)
  countx = COUNT_DOWN_X
  county = COUNT_DOWN_Y
  score = 0
  gameState = 0
  Game_Over = false
  gamepause = false
end
