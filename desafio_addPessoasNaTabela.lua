--[[Bom dia, so cheguei hoje, e estou a comecar a apreender lua, tenho muito pouca experiencia em programacao.
Decidi fazer o desafio do dia 3/06, espero nao haver problema.
tentei comentar, para parecer mais bonito, e comecar ja a ganhar experiencia em comentar, disseram me que era muito importante.
]]

local pessoas = {
  jorge = 1,
  maria = 2,
  sofia = 3,
}

function adcNaTabela (input)
--Variavel find, para saber se encontrou o INPUT
--ou nao encontro o INPUT dentro na tabela
local find = false

    -- Roda dentro da tabela, procurando o nome da pessoa que demos no input
    -- Se encontrar, adiciona 1 ao valor, e salta fora.
    -- tambem vai alterar a variavel find para TRUE,
    -- avisando assim que encontrou match com INPUT
    for k,v in pairs(pessoas) do
      if k == input then
        find = true
        pessoas[input] = pessoas[input]+1
        break
      end
    end

    -- no caso de rodar a tabela e nao encontrar nada (not find)
    -- entao com uma simples linha adiciona um novo indice e value na tabela
    -- demorei imenso tempo para descobrir isto
    if not find then
      pessoas[input] = 1
    end
end

-- decidi acrescentar uma impressora para a tabela,
-- para ver o estado da tabela no final
-- usa um simples for in pairs, com um print la dentro
function imprimirTabelaPessoas ()
  for k,v in pairs(pessoas) do
    print("nome: " .. k .. ", quantidade: " .. v)
  end
end


function main ()
-- aqui temos o que seria o input dado pelo utilizador.
-- ainda nao sei pedir o input.
local input = "rui"

adcNaTabela(input);
imprimirTabelaPessoas()
end

main()
