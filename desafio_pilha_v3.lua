TAM_PILHA = 5

--pop ou desempilhar a pilha
function pop(pilha)
    if pilha.topo > 0 then
        pilha.energia[pilha.topo] = 0
        pilha.topo = pilha.topo - 1
    else
        print("ERRO: Pilha vazia")
    end
end

--push ou empilhar a pilha
function push(pilha)
    if pilha.topo < TAM_PILHA then
        pilha.topo = pilha.topo + 1
        pilha.energia[pilha.topo] = pilha.topo
    else
        print("ERRO: Pilha ja esta cheia")
    end
end

--Criar uma pilha do tipo AAA, usando a metatable pilha
function criarPilha_AAA(pilha)
    local pilha_AAA = 
    {
        energia = {},
        topo = 0,
    }
        for i = pilha_AAA.topo, TAM_PILHA do --"guardar espaço da pilha na memoria"
            pilha_AAA.energia[i] = 0
        end

    pilha_AAA.__index = pilha_AAA
    pilha_AAA.push = push
    pilha_AAA.pop = pop

    pilha = setmetatable({}, pilha_AAA)
    return pilha 
end

--[[Simples exemplo, para atribuir facilmente quantas vezes queremos empilhar e 
quantas vezes se quer desempelhar. e no final, imprime na tela o topo e o valor]]
function correrExemplo(pilha)
    os.execute("cls")
    local empilhar = 6
    local desempilhar = 2

    for i = 1, empilhar do
        pilha:push()
    end

    for i = 1, desempilhar do
        pilha:pop()
    end
    print(string.format("-Apresentar Topo: %s -Apresentar Valor: %s", pilha.topo, pilha.energia[pilha.topo]))
end

function main()
    local duracell_AAA = {}
    duracell_AAA = criarPilha_AAA(duracell_AAA)

    correrExemplo(duracell_AAA)
end

main()