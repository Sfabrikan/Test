package.cpath = package.cpath..";C:\\Users\\sfab\\Documents\\GitHub\\Test\\libs\\xml2lua-master\\?.dll"
package.path = package.cpath..";C:\\Users\\sfab\\Documents\\GitHub\\Test\\libs\\xml2lua-master\\?.lua"
local xml2lua = require("xml2lua");
local handler = require("xmlhandler.tree");

local xml = [[
<ss:Worksheet ss:Name="Лист2"><Table ss:StyleID="ta1"><Column ss:Width="64.0063"/><Column ss:Width="64.0063"/><Column ss:Width="92.6079"/><Column ss:Width="64.0063"/><Row ss:Height="12.8126"><Cell><Data ss:Type="String">Данник</Data></Cell><Cell><Data ss:Type="String">Привет</Data></Cell><Cell ss:Formula="of:=SUBSTITUTE([.B2];[.B2];&quot;Это особое слово&quot;)"><Data ss:Type="String">Это особое слово</Data></Cell><Cell ss:Formula="of:=[.B3]"><Data ss:Type="String">молчит</Data></Cell></Row><Row ss:Height="12.8126"><Cell ss:StyleID="ce2"/><Cell ss:StyleID="ce5"><Data ss:Type="String">Здарова</Data></Cell><Cell ss:StyleID="ce5"/><Cell ss:StyleID="ce8"/></Row><Row ss:Height="12.8126"><Cell ss:StyleID="ce3"/><Cell ss:StyleID="ce6"><Data ss:Type="String">молчит</Data></Cell><Cell ss:StyleID="ce6"><Data ss:Type="String">ENDDIALOG</Data></Cell><Cell ss:StyleID="ce9"/></Row><Row ss:Height="12.8126"><Cell><Data ss:Type="String">Путеец</Data></Cell><Cell><Data ss:Type="String">Привет</Data></Cell><Cell ss:Formula="of:=[.B5]"><Data ss:Type="String">Здарова</Data></Cell><Cell ss:Formula="of:=[.B6]"><Data ss:Type="String">молчит</Data></Cell></Row><Row ss:Height="12.8126"><Cell ss:StyleID="ce2"/><Cell ss:StyleID="Default"><Data ss:Type="String">Здарова</Data></Cell><Cell ss:StyleID="Default"/><Cell ss:StyleID="ce8"/></Row><Row ss:Height="12.8126"><Cell ss:StyleID="ce3"/><Cell ss:StyleID="ce6"><Data ss:Type="String">молчит</Data></Cell><Cell ss:StyleID="ce6"><Data ss:Type="String">ENDDIALOG</Data></Cell><Cell ss:StyleID="ce9"/></Row></Table><x:WorksheetOptions/></ss:Worksheet>]]

local parser = xml2lua.parser(handler)
parser:parse(xml)
ABC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
dialog = {}
--Manually prints the table (since the XML structure for this example is previously known)
iter = handler._stack.n
local vet
local path = "C:/Users/sfab/Desktop/parser"
local pathfile = path.."/lua.lua"
local popenfile = io.open(pathfile,"w+")
popenfile:write()
popenfile:close()
--file:close()
function gen(v,dia,x,y)
  local str = string.match(v, "(%a+%d+)")
  if str then
    local strnumber = string.match(str,"%a+")
    --print(strnumber,num)
    local i = 0
    local iterator = 0 --Точное число начало диалога
    local summ = 0 --Точное число ветки
    --dia Точный диалог
    for s in string.gmatch(strnumber,"%a") do
      local number = string.find(ABC,s)-1
      summ = summ+number*(#ABC)^i
      i = i+1
    end
  end
end

function codegen(dia)
  local file = io.open(pathfile,"r")
  if file then
    if dia ~= "?" then
      local reed = file:read()
      file:close()
      file = io.open(pathfile,"a")
      --file = io.open(pathfile,"a")
      local tab = "\t"
      --file:write("function dialog(x)\n\tlocal file\n")
      if not vet then
        vet = "if "
      else
        vet = "elseif "
      end
      local iif = tab..vet.."x == '"..dia.."' then\n\t\tfile = loadfile('"..dia..".sfabrikan')\n"
      if reed then
        file:write(iif)
        file:close()
      else
        file:write("function dialog(x)\n\tlocal file\n"..iif)
        file:close()
      end
    else
      file:close()
      file = io.open(pathfile,"a")
      file:write("\tend\nend")
      file:close()
    end
  else
    file = io.open(pathfile,"w")
    file:close()
  end
end

local salf
local iteration = 0
for i=1, iter do
  for k, w in pairs(handler._stack[i]) do
    if w.Table then
      for k, t in pairs(w.Table) do
        if k == "Row" then
          for i = 1, #t do
            for k, c in pairs(t[i].Cell) do
              if k == 1 and c.Data then
                iteration = 0
                salf = c.Data[1]
                dialog[c.Data[1]] = {{}}
                iteration = iteration+1
              elseif k >= 1 and c.Data and dialog[salf] then
                table.insert(dialog[salf][iteration], c.Data[1]) 
                if c._attr then
                  local key,value = next(c._attr)
                  if string.match(value,"%a.:") then
                    gen(value,salf,#dialog[salf][iteration],#dialog[salf])
                  end
                end
              elseif k == 1  and not c.Data then
                table.insert(dialog[salf], {})
                iteration = iteration+1
              end
            end
          end
        end
      end
    end
  end
end

local fileser
local name 
function serialize( tbl,filename )
	local charS,charE = "\t","\n"
	
	//local err = createSubDir(filename)
	//if err then return false,err end
	
	local file = io.open(path.."")
	file:open('w')

	-- initiate variables for save procedure
	local tables,lookup = { tbl; len = 1 },{ [tbl] = 1 }
	file:write( "return {"..charE )

	for idx,t in ipairs( tables ) do
		file:write( "-- Table: {"..idx.."}"..charE )
		file:write( "{"..charE )
		local thandled = {}

		for i,v in ipairs( t ) do
			thandled[i] = true
			local stype = type( v )
			-- only handle value
			if stype == "table" then
				if not lookup[v] then
					insert( tables, v )
					lookup[v] = #tables
				end
				file:write( charS.."{"..lookup[v].."},"..charE )
			elseif stype == "string" then
				file:write(  charS..exportstring( v )..","..charE )
			elseif stype == "number" or stype == 'boolean' then
				file:write(  charS..tostring( v )..","..charE )
			end
		end

		for i,v in pairs( t ) do
			-- escape handled values
			if (not thandled[i]) then
			
				local str = ""
				local stype = type( i )
				-- handle index
				-- if stype == "table" then
					-- if not lookup[i] then
						-- insert( tables,i )
						-- lookup[i] = #tables
					-- end
					-- str = charS.."[{"..lookup[i].."}]="
				if stype == "string" then
				-- elseif stype == "string" then
					str = charS.."["..exportstring( i ).."]="
				elseif stype == "number" or stype == 'boolean' then
					str = charS.."["..tostring( i ).."]="
				end
			
				if str ~= "" then
					stype = type( v )
					-- handle value
					if stype == "table" then
						if not lookup[v] then
							insert( tables,v )
							lookup[v] = #tables
						end
						file:write( str.."{"..lookup[v].."},"..charE )
					elseif stype == "string" then
						file:write( str..exportstring( v )..","..charE )
					elseif stype == "number" or stype == 'boolean' then
						file:write( str..tostring( v )..","..charE )
					end
				end
			end
		end
		file:write( "},"..charE )
	end
	file:write( "}" )
	file:close()
	
	return true
end

for k,v in pairs(dialog) do
  local t = {}
  t[k] = v
  
  codegen(k)
  serial(k,v)
end
codegen("?")

--function serialization(v)
--  io.open(path.."/"..k..".sfabrikan","w")
--  if type(v) == "table" then
--    serialization(v)
--  elseif type(v) ~= "table" then
    
--  end
--end

--serialization(dialog)


--METALUA
--local x 
--print(string.match("of:=SUBSTITUTE([.B20];[.B2];\"Это особое слово\")", "(%a+%d+)"));
