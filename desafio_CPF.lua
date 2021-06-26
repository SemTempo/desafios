--[[
Você deverá criar um programa que:

- Verifique se o CPF é válido;
- Identifique o estado de emissão do CPF;

Para isso você deverá utilizar estas informações recebidas do banco de dados.
CPFs: '160.668.448-57', '470.521.248-74', 95464, '094.846.974-48', '290.364.662-70',
	  '729.103.063-30', '527.249.491-10', '855.612.027-07', '049.548.654-54', '712.877.508-81';

Estados: 0 = Rio Grande do Sul,
		 1 = Distrito Federal,
		 2 = Amazonas,
		 3 = Ceará,
		 4 = Pernambuco,
		 5 = Bahia,
		 6 = Minas Gerais,
		 7 = Rio de Janeiro,
		 8 = São Paulo,
		 9 = Paraná

//// Exemplo de impressão na tela ////

CPF VÁLIDO! [CPF / ESTADO].
CPF INVÁLIDO! O CPF CPF é inválido.

]]

CPFS =
{
  '160.668.448-57',
  '470.521.248-74',
  95464,
  '094.846.974-48',
  '290.364.662-70',
  '729.103.063-30',
  '527.249.491-10',
  '855.612.027-07',
  '049.548.654-54',
  '712.877.508-81',
  89574521402,
  '712-877-508-81',
  '72.87.08-81',
  '4BB.AAA.508-81',
  '712.877.508-CC',
  '7293.103.063-1',
  '729.103.063-121',
}
ESTADOS =
{
  [0] = "Rio Grande do Sul",
  [1] = "Distrito Federal",
  [2] = "Amazonas",
  [3] = "Cearah",
  [4] = "Pernambuco",
  [5] = "Bahia",
  [6] = "Minas Gerais",
  [7] = "Rio de Janeiro",
  [8] = "Sao Paulo",
  [9] = "Paranah",
}

function CalculoDigitoVerificador(cpf)
  local v1, v2 = 0, 0
  for i = 1, #cpf do
    v1 = v1 + cpf[i] * (9 - (i - 1 % 10))
    v2 = v2 + cpf[i] * (9 - ((i - 1 + 1) % 10))
  end

  v1 = (v1 % 11) % 10
  v2 = v2 + v1 * 9
  v2 = (v2 % 11) % 10

  return v1, v2
end

function desformatarCPF (cpf)
  local cpfReverse = string.reverse(cpf)
  local cpfdigitoValidar1 = string.sub(cpfReverse, 2, 2)
  local cpfdigitoValidar2 = string.sub(cpfReverse, 1, 1)
  local f, g, h = string.match(cpfReverse, "-(%d+).(%d+).(%d+)")

  cpfReverse = string.format("%03d%03d%03d", f, g, h)
  return cpfReverse, cpfdigitoValidar1, cpfdigitoValidar2
end

function tabelarCPF(cpf)
  local tabelaCPF = {}
  local contador = 1

  for caracter in string.gmatch(cpf, "%d") do
    tabelaCPF[contador] = caracter
    contador = contador + 1
  end
  return tabelaCPF
end

--[[este main vai rodar todos os CPF's e apresentar uma mensagem de valido ou nao valido.
    acçoes realizadas:
    1º parte do if: Validar a formatacao do cpf. numeros a menos ou a mais serao classificados de Invalidos assim como letras ou simbolos
    2º parte do if: vai precisar de validar mais um pouco os CPF's
        -'cpfDigitoV1' e 'cpfDigitoV2', sao os digitos verificador inseridos pelo utilizador
        -'cpfInvertido'(apenas os primeiros 9 digitos) é criado por causa da formula usada no Cálculo dos dígitos verificadores (dv1, dv2)
        -'cpfTabela' é o 'cpfInvertido' em forma de tabela. Porque em forma de tabela? preciso da tabela para o metodo usado no Cálculo dos dígitos verificadores.
        -dv1, dv2 ; seriam os digitos validos para os 9 digitos do cpf em questao.
        -Pronto, depois de todas as variaveis necessarias, agora é so comparar e validar

ps. Cálculo do dígito verificador, esta aqui explicado: https://pt.wikipedia.org/wiki/Cadastro_de_pessoas_f%C3%ADsicas
]]
function main()
  for i = 1, #CPFS do
    -- Simplesmente valida a formatacao do cpf.
    if string.len(CPFS[i]) > 14 or string.match(CPFS[i], "%d%d%d%.%d%d%d%.%d%d%d%-%d%d") == nil then
      print("CPF INVALIDO! para o cpf: " .. CPFS[i])
    else
      local cpfInvertido, cpfDigitoV1, cpfDigitoV2 = desformatarCPF(CPFS[i])
      local cpfTabela = tabelarCPF(cpfInvertido)
      local dv1, dv2 = CalculoDigitoVerificador(cpfTabela)

      if dv1 == tonumber(cpfDigitoV1) and dv2 == tonumber(cpfDigitoV2) then
        print("CPF VALIDO! para o cpf: " .. CPFS[i] .. ", e o seu estado eh: " .. ESTADOS[tonumber(cpfTabela[1])])
      else
        print("CPF INVALIDO! para o cpf: " .. CPFS[i])
      end
    end

  end
end

main()
