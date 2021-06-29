--[[
DESAFIO NOVO: Dada    a    string    abaixo,    você    conseguiria    dizer    o    que    esta    escrito em    português?    Dica:    use    as    funções    string.byte(),    string.char(), string.sub()    e    string.len().
"gw gurgtq swg xqeg pcq vgpjc fguetkrvqitchcfq vqfc guvc uvtkpi ocpwcnogpvg rqtswg cngo fg owkvq fgoqtcfq ugtkc vqvcnogpvg gpvgfkcpvg"
]]

str = "gw gurgtq swg xqeg pcq vgpjc fguetkrvqitchcfq vqfc guvc uvtkpi ocpwcnogpvg rqtswg cngo fg owkvq fgoqtcfq ugtkc vqvcnogpvg gpvgfkcpvg"

a = {}
local temp = nil
for i = 1, string.len(str) do
    a[i] = string.byte(str,i,i)
    temp = a[i] - 2
    a[i] = string.char(temp)
    
end

print(table.concat(a))
