package.cpath = package.cpath..";C:\\Users\\sfab\\Documents\\GitHub\\Test\\libs\\xml2lua-master\\?.dll"
package.path = package.cpath..";C:\\Users\\sfab\\Documents\\GitHub\\Test\\libs\\xml2lua-master\\?.lua"
local xml2lua = require("xml2lua");
local handler = require("xmlhandler.tree");

local xml = [[
<ss:Worksheet ss:Name="Лист2"><Table ss:StyleID="ta1"><Column ss:Width="64.0063"/><Column ss:Width="64.0063"/><Column ss:Width="92.6079"/><Column ss:Width="64.0063"/><Row ss:Height="12.8126"><Cell><Data ss:Type="String">Данник</Data></Cell><Cell><Data ss:Type="String">Привет</Data></Cell><Cell ss:Formula="of:=SUBSTITUTE([.B2];[.B2];&quot;Это особое слово&quot;)"><Data ss:Type="String">Это особое слово</Data></Cell><Cell ss:Formula="of:=[.B3]"><Data ss:Type="String">молчит</Data></Cell></Row><Row ss:Height="12.8126"><Cell ss:StyleID="ce2"/><Cell ss:StyleID="ce5"><Data ss:Type="String">Здарова</Data></Cell><Cell ss:StyleID="ce5"/><Cell ss:StyleID="ce8"/></Row><Row ss:Height="12.8126"><Cell ss:StyleID="ce3"/><Cell ss:StyleID="ce6"><Data ss:Type="String">молчит</Data></Cell><Cell ss:StyleID="ce6"><Data ss:Type="String">ENDDIALOG</Data></Cell><Cell ss:StyleID="ce9"/></Row><Row ss:Height="12.8126"><Cell><Data ss:Type="String">Путеец</Data></Cell><Cell><Data ss:Type="String">Привет</Data></Cell><Cell ss:Formula="of:=[.B5]"><Data ss:Type="String">Здарова</Data></Cell><Cell ss:Formula="of:=[.B6]"><Data ss:Type="String">молчит</Data></Cell></Row><Row ss:Height="12.8126"><Cell ss:StyleID="ce2"/><Cell ss:StyleID="Default"><Data ss:Type="String">Здарова</Data></Cell><Cell ss:StyleID="Default"/><Cell ss:StyleID="ce8"/></Row><Row ss:Height="12.8126"><Cell ss:StyleID="ce3"/><Cell ss:StyleID="ce6"><Data ss:Type="String">молчит</Data></Cell><Cell ss:StyleID="ce6"><Data ss:Type="String">ENDDIALOG</Data></Cell><Cell ss:StyleID="ce9"/></Row></Table><x:WorksheetOptions/></ss:Worksheet>]]

local parser = xml2lua.parser(handler)
parser:parse(xml)

dialog = {}
--Manually prints the table (since the XML structure for this example is previously known)
iter = handler._stack.n

for i=1, iter do
  for k, w in pairs(handler._stack[i]) do
    if w.Table then
      for k, t in pairs(w.Table) do
        if k == "Row" then
          for i = 1, #t do
            for k, c in pairs(t[i].Cell) do
              if k == 1 and c.Data then
                
              end
              print(c)
            end
          end
        end
      end
    end
  end
end