--[[
Números Romanos
Escreva um programa que converta números romanos, lidos através de uma string, em um inteiro em base decimal. Vale qualquer linguagem.

Ex:
$ convert_roman mmxxi
2021
]]
NUM_ROMANOS =
{
  ['I'] = 1,
  ['V'] = 5,
  ['X'] = 10,
  ['L'] = 50,
  ['C'] = 100,
  ['D'] = 500,
  ['M'] = 1000,
}
VERIFICADORES =
{
  ['I'] = {'X', 'V', 'I'},
  ['V'] = {'I'},
  ['X'] = {'C', 'L', 'X', 'V', 'I'},
  ['L'] = {'X', 'V', 'I'},
  ['C'] = {'M', 'D', 'C', 'L', 'X', 'V', 'I'},
  ['D'] = {'C', 'L', 'X', 'V', 'I'},
  ['M'] = {'M', 'D', 'C', 'L', 'X', 'V', 'I'},
  ["CASOS_ESPECIAIS"] = {"IVI", "VIV", "XLX", "LXL", "CDC", "DCD"}
}

-- como o proproio nome diz, vai passar as letras para numeros usando a tabela 'NUM_ROMANOS'
function LetrasParaNumeros(numRomano)
  local temp = {}
  for i, v in ipairs(numRomano) do
    table.insert(temp, NUM_ROMANOS[v])
  end
  return temp
end

--[[ Soma dos numeros romanos:
depois dos checkup's todos, e das letras agora estarem em numeros tudo sera facil.
    - no caso de apenas um numero, a soma sera o valor desse numero
    - no caso de mais numeros, vai somando normalmente excepto nos casos em que
    numRomano[i] < numRomano[i+1]... que em vez de somar temos de subtrair
]]
function SomaRomana(numRomano)
  local soma = 0
  local i = 1

    for i=1, #numRomano do
      if i < #numRomano then
          if numRomano[i] >= numRomano[i + 1] then
            soma = soma + numRomano[i]
          else
            soma = soma - numRomano[i]
          end
      else
        soma = soma + numRomano[i]
      end
    end

  return soma
end

function checkup_4_a(numRomano)
  local temp = table.concat (numRomano, "")
  local boolean4 = nil

  for i=1,#VERIFICADORES.CASOS_ESPECIAIS do
    boolean4 = (string.match (temp, VERIFICADORES.CASOS_ESPECIAIS[i]))
    if boolean4 then
      return false
    end
  end
  return true
end

function checkup_3_a(numRomano)
  for i = 1, (#numRomano - 3) do
    --aqui nao posso apenas comparar com o i+3
    -- exemplo possivel é o 290 - CCXC
    if numRomano[i] == numRomano[i + 1] and
       numRomano[i] == numRomano[i + 2] and
       numRomano[i] == numRomano[i + 3] then
      return false
    end
  end
  return true
end

function checkup_2_b(letra, letra_seguinte)
      for m, n in pairs(VERIFICADORES[letra]) do
        if letra_seguinte == n then
          return true
        end
      end
      return false
    end

    function checkup_2_a(numRomano)
      local boolean2 = nil
      for i, v in pairs(numRomano) do
        if i < #numRomano then
          boolean2 = checkup_2_b(numRomano[i], numRomano[i + 1])
          if not boolean2 then
            return false
          end
        end
      end
      return true
end

function checkup_1_b(v)
      for indice, value in pairs(NUM_ROMANOS) do
        if indice == v then
          return true
        end
      end
      return false
    end

    function checkup_1_a(numRomano)
      local boolean = nil
      for i, v in pairs(numRomano) do
        boolean = checkup_1_b(v)
        if not boolean then
          return false
        end
      end
      return true
end

--[[ um checkup para a informcao dada pelo utilizador
um pouco extenso mas numeracao romana é bem chata.
cada boolean representa o seguinte
  -boolean1 = confirma que a informacao dada, sejam letras romanas
  -boolean2 = confirma a ordem das letras da numeracao romana
  -boolean3 = confirma que as letras nao se repetem mais vezes do que o permitido
  -boolean4 = verifica os casos especiais, eles estao na tabela 'VERIFICADORES.CASOS_ESPECIAIS'

depois existem 4 casos possiveis para a informacao dada pelo utilizador
  1º- quando é de apenas 1 caracter
  2º- quando é de apenas 2 caracteres
  3º- quando é de mais de 2 caracteres
  4º- caso o utilizador nao insira nada
]]
function checkup_numRomano(numRomano)
  local boolean1 = nil
  local boolean2 = nil
  local boolean3 = nil
  local boolean4 = nil

  if #numRomano == 1 then
    boolean1 = checkup_1_a(numRomano)
    return boolean1

  elseif #numRomano == 2 then
    boolean1 = checkup_1_a(numRomano)
      if boolean1 then
        boolean2 = checkup_2_a(numRomano)
      end
      if boolean1 and boolean2 then
        return true
      else
        return false
      end

  elseif #numRomano > 2 then
    boolean1 = checkup_1_a(numRomano)
    if boolean1 then
      boolean2 = checkup_2_a(numRomano)
    end
    if boolean2 then
      boolean3 = checkup_3_a(numRomano)
    end
    if loolean3 then
      boolean4 = checkup_4_a(numRomano)
    end
    if boolean1 and boolean2 and boolean3 and boolean4 then
      return true
    else
      return false
    end

  else
      return false
  end
end

--funcao simples para inserir uma string numa tabela caracter a caracter
function tabelarString(...)
  local tabelaString = {}
  for caracter in string.gmatch(..., ".") do
    table.insert (tabelaString, caracter)
  end
  return tabelaString
end

--funcao simples de ler uma string inserida pelo utilizador
function ler()
  print("-------------------------------------------")
  print("||PARA SAIR DIGITE: 0 ||\nDIGITE UM NUMERO ROMANO:")
  local lido = tostring(io.read())
  return lido
end

--[[eh aqui que tudo comeca...
o que faz?
-le informacao inserido pelo utilizador
-verifica a qualidade dessa informacao
-caso informacao sem qualidade: pede por nova informacao
-caso informacao de qualidade: vai traduzir a numeracao romana
  para inteiro em base decimal. e volta a perguntar ao utilizador por nova informacao
]]
function main()
  local numRomano =
  {
    ['lido'] = "",
    ['lidoTabela'] = {},
    ['boolean'] = nil,
    ['traduzido'] = 0,
  }
  numRomano.lido = string.upper(ler())
  while numRomano.lido ~= '0' do
    numRomano.lidoTabela = tabelarString(numRomano.lido)
    numRomano.boolean = checkup_numRomano(numRomano.lidoTabela)
    if numRomano.boolean then
      numRomano.traduzido = SomaRomana(LetrasParaNumeros(numRomano.lidoTabela))
      print("O numero romano convertido eh: " .. numRomano.traduzido)
    else
      print("------------------------------------")
      print("ERRO LEITURA, NUMERO ROMANO INVALIDO")
      print("ERRO LEITURA, NUMERO ROMANO INVALIDO")
      print("ERRO LEITURA, NUMERO ROMANO INVALIDO")
      print("ERRO LEITURA, NUMERO ROMANO INVALIDO")
      print("ERRO LEITURA, NUMERO ROMANO INVALIDO")
    end
    numRomano.lido = string.upper(ler())
  end
end
main()
