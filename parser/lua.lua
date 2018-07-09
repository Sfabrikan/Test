function dialog(x)
	local file
	if x == 'Данник' then
		file = loadfile('Данник.sfabrikan')
	elseif x == 'Путеец' then
		file = loadfile('Путеец.sfabrikan')
	end
end