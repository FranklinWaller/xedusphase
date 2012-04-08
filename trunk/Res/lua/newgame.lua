NewGame={}
MapLoad()

function NewGame:update()
	if love.keyboard.isDown("d") then
      player.x = player.x + 4
   elseif love.keyboard.isDown("a") then
      player.x = player.x - 4
   end
	
	if player.jumpstate=="jumping" then
	player.jumpspeed = player.jumpspeed - 0.5
	player.gravity = player.gravity - player.jumpspeed
	end
	
	if player.gravity < 460 and player.jumpstate == "falling" then
	player.gravity = player.gravity + (player.jumpspeed +3)
	end
	
	if player.gravity == 460 then
	player.jumpspeed = 10
	player.jumpstate = "ground"
	end
	
	if player.gravity > 460 then player.gravity = 460 end
	
	player.y = player.gravity
	
end

function NewGame:draw()
	--love.graphics.draw(playertile, player.x, player.y)
	for rowIndex=1, #GameTable do
		local row = GameTable[rowIndex]
		for columnIndex=1, #row do
			local number = row[columnIndex]
			local x = (columnIndex-1)*TileW
			local y = (rowIndex-1)*TileH
			love.graphics.drawq(Tileset, Quads[number], x, y)
		end
	end
	for rowIndex=1, #PlayerTable do
		local row = PlayerTable[rowIndex]
		for columnIndex=1, #row do
			local number2 = row[columnIndex]
			local x2 = (columnIndex-1)*TileW + player.x
			local y2 = (rowIndex-1)*TileH + player.y
			love.graphics.drawq(playertile, QuadsP[number2], x2, y2)
		end
	end
end

function NewGame:keypressed(key)
	if key == " " and player.jumpstate == "ground" then player.jumpstate = "jumping" end
	
	if key == "escape" then
	love.filesystem.load("Res/lua/menu.lua")()
	end
end