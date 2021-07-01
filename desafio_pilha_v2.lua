--Vai descarregar a pilha de 20% em 20%
function descarregarPilha(pilha)
    if pilha.energia_negativa < 100 then
        pilha.energia_negativa = pilha.energia_negativa + 20
        pilha.energia_positiva = pilha.energia_positiva - 20
    else
        print("INFORMACAO: Pilha sem energia")
    end
end

--Vai carregar a pilha de 20% em 20%
function carregarPilha(pilha)
    if pilha.energia_positiva < 100 then
        pilha.energia_negativa = pilha.energia_negativa - 20
        pilha.energia_positiva = pilha.energia_positiva + 20
    else
        print("INFORMACAO: Pilha cheia de energia!")
    end
end

--Criar uma pilha do tipo AAA, usando a metatable pilha
function criarPilha_AAA(pilha)
    local pilha_AAA = 
    {
        energia_positiva = 0,
        energia_negativa = 100,
    }
    pilha_AAA.__index = pilha_AAA
    pilha_AAA.carregarPilha = carregarPilha
    pilha_AAA.descarregarPilha = descarregarPilha

    pilha = setmetatable({}, pilha_AAA)
    return pilha 
end


--[[ EXEMPLIFICAR()
é uma funcao que vai mostrar o funcionamento da pilha, 
vai carregar bateria, e decarregar a bateria. imprimindo a energia positiva
e energia negativa. Vai imprimir no inicio, depois de a bateria estar totalmente caregada
e no final depois de a bateria estar totalmente descarregada. 
]]
function exemplificar(duracell_AAA)
    local text = "%s da experiencia-> %s/%s Energia Positiva/Energia Negativa\n"
    print(string.format(text, "Inicio", duracell_AAA.energia_positiva, duracell_AAA.energia_negativa))

    for i = 1, 6 do
        duracell_AAA:carregarPilha()
    end

    print(string.format(text, "Metade", duracell_AAA.energia_positiva, duracell_AAA.energia_negativa))

    for i = 1, 6 do
        duracell_AAA:descarregarPilha()
    end

    print(string.format(text, "Fim", duracell_AAA.energia_positiva, duracell_AAA.energia_negativa))
end

function main()
 
    local duracell_AAA = {}
    duracell_AAA = criarPilha_AAA(duracell_AAA)

    exemplificar(duracell_AAA)
end

main()
