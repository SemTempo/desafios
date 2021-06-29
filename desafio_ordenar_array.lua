--Desafio: Dada uma sequencia de inteiros em um array 
--escrever uma função que ordene o array em ordem crescente.

function preencher(tam_)
    local array = {}
    math.randomseed(os.time())
    for i = 1, tam_ do
    array[i] = math.random(NUMERO_BAIXO, NUMERO_ALTO)
    end
    return array
end

function maiorTrocaComMenor(array, i)
    local temp = array[i]-- vamos salvar aqui o valor na posicao i
    array[i] = array[i + 1] -- fazer a troca das posicoes para ficar ordenado 
    array[i + 1] = temp -- fazer a troca das posicoes para ficar ordenado
    
    return array, i - 1
end

function compararValores(array, i)--vai comparar dois valores seguidos. i e i+1

    if array[i] > array[i + 1] then
        array, i = maiorTrocaComMenor(array, i)
        return array ,i
    end
    
    return array, i + 1
end

function ordenarArray(array)
    if #array == 1 then -- caso array tamanho 1, ele nao pode comparar com array[i+1]
        return array
    else 

        local i = 1-- iterador para o loop
        while i < #array do --loop para manter a leitura dentro do array
        
            if i == 1 then  -- caso especial, primeira posicao do array, fazendo ou nao a troca de posicoes vamos sempre querer avançar o i, para a segunda posicao do array
                array, i = compararValores(array, i)
                i = 2
            else -- o resto dos casos, para i > 1
                array, i = compararValores(array, i)
            end
        end
        return array -- depois de tudo ordenado, o i alcancou a ultima posicao do array, e ja nao tem mais nada para comparar a frente. saindo do loop. e retornando o array
    end
end

function printArray(array) 
    for i = 1, #array do
        print(array[i])
    end
end
--######################

TAMANHO_ARRAY = 20 --tamanho que se quer para o array
NUMERO_BAIXO = 1 --qual o menor numero que se quer para o array
NUMERO_ALTO = 50 --qual o maior numero que se quer para o array

function main()

local array = preencher(TAMANHO_ARRAY)
array = ordenarArray(array)
printArray(array)

end

main()
