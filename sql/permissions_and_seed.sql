INSERT INTO	map_variant (id, terrain) 
	VALUES	('95a66999127893f5925a5f591d54f8bcb9a670e6', 'E brown x brown black yellow x gray green red blue yellow blue E red yellow x blue gray red x x x yellow brown black gray E green black x x x brown green yellow x x x x E yellow gray green yellow black x blue red brown x green blue green E x x brown x x red black green gray x brown black E green red x x green x x x brown blue x gray red E gray x yellow gray blue red green x red gray x black E black blue x black brown gray blue x yellow black x red blue E gray green x red yellow black yellow x blue brown x brown E'), 
			('be8f6ebf549404d015547152d5f2a1906ae8dd90', 'brown gray green blue brown red brown black red blue green red black E yellow x x yellow black x x yellow green x x yellow E x x black x gray x green x black x red x x E green blue yellow x x red blue x red x gray brown E black brown red blue yellow brown green yellow x x green black red E gray green x x black gray x x x brown gray yellow E x x x gray x red x green x yellow black blue brown E yellow blue brown x x x blue black x gray brown red E blue black gray blue red green yellow brown gray x blue green gray E');

GRANT 
	INSERT, 
	SELECT, 
	UPDATE, 
	DELETE 
ON 
	email,
	to_validate,
	map_variant,
	game,
	game_player,
	game_active_time,
	game_role,
	blacklist,
	game_note,
	secret,
	chat_message,
	chat_read,
	player_ratings,
	game_events,
	game_options,
	player
TO 
	daemon; 