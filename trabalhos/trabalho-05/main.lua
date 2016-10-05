function love.load()
    timer = 0
    timer2 = 0.6
    timer3 = 0.3
    jogador1_largura=100
    jogador1_altura=20
    jogador1_x = 0
    jogador1_y = 500
    jogador2_largura=100
    jogador2_altura=20
    jogador2_x = 700
    jogador2_y = 500
    listaDeCirculos = {}
	--[[ 
	listaDeCirculos é uma coleção dinâmica de objetos declarada globalmente e alocada de forma
	dinâmica no início do programa sem nenhum tamanho fixo e, por isso tem tamanho ilimitado.
	É executado desde sua declaração até o final do programa, onde é desalocado antes do encerramento
	da execução do mesmo.
	]]
		
    teveColisao = false
    i=0
    paused = false
    menu = true
    players = 0
    gameOver = false
end
 
function love.focus(b)
    if not b then
        paused = true
    end
end
 
 
function love.update(dt)

    if not paused then

        if players == 0 and menu == true then
            if love.keyboard.isDown("1") then
                players = 1
                menu = false
            elseif love.keyboard.isDown("2") then
                players = 2
                menu = false
            end
        end
        if players == 1 and menu == false then -- JOGANDO COM UM JOGADOR !!!!!
            timer = timer + dt
           
            timer2 = timer2 - dt
            if love.keyboard.isDown("d") then
                if jogador1_x < (love.graphics.getWidth() -100 ) then
                    jogador1_x = jogador1_x + 750 * dt
                end
            elseif love.keyboard.isDown("a") then
                if jogador1_x > 0 then
                    jogador1_x = jogador1_x  - 750 * dt
                end
           
            end
 
            for i,v in ipairs (listaDeCirculos) do
                v.y = v.y + v.velocidade* 0.75 * dt 
       
                teveColisao= testaColisao (jogador1_x, jogador1_y, jogador1_largura, jogador1_altura, v.x, v.y,v.largura,v.altura)
                if teveColisao == true then
                    table.remove(listaDeCirculos,i) -- Removendo o objeto da coleção dinâmica de objetos em função de uma colisão entre ele e o jogador 1.
                end
                if v.y >= 800 then
                    timer = timer + 0
                    players = 0
                    gameOver = true
                end
            end
            if timer2 <= 0 then
                table.insert (listaDeCirculos, criaCirculo()) -- Criando um novo objeto na coleção dinâmica de objetos em função do tempo.
                timer2 = 0.6
            end
           
            if timer3 <= 0 then
                table.insert (listaDeCirculos, criaCirculo()) -- Criando um novo objeto na coleção dinâmica de objetos em função do tempo.
                timer3 = 0.3
            end
        elseif players == 2 and menu == false then -- JOGANDO COM DOIS JOGADORES !!!!!
            timer = timer + dt
            timer2 = timer2 - dt
            if love.keyboard.isDown("d") then
                if jogador1_x < (love.graphics.getWidth() -100 ) and (jogador1_x+100)<jogador2_x then
                    jogador1_x = jogador1_x + 750 * dt
                end
            elseif love.keyboard.isDown("a") then
                if jogador1_x > 0 then
                    jogador1_x = jogador1_x  - 750 * dt
                end
           
            end
 
            if love.keyboard.isDown("right") then 
                if jogador2_x < (love.graphics.getWidth() -100 ) then
                    jogador2_x = jogador2_x + 750 * dt
                end
            elseif love.keyboard.isDown("left") then
                if jogador2_x > 0 and (jogador2_x>(jogador1_x+100)) then
                    jogador2_x = jogador2_x  - 750 * dt
                end
            end
           
            for i,v in ipairs (listaDeCirculos) do
                v.y = v.y + v.velocidade*1.5 * dt  
           
                teveColisao= testaColisao (jogador1_x, jogador1_y, jogador1_largura, jogador1_altura, v.x, v.y,v.largura,v.altura)
                if teveColisao == true then
                    table.remove(listaDeCirculos,i) -- Removendo o objeto da coleção dinâmica de objetos em função de uma colisão entre ele e o jogador 1.
                end
               
                teveColisao= testaColisao (jogador2_x, jogador2_y, jogador2_largura, jogador2_altura, v.x, v.y,v.largura,v.altura)
                if teveColisao == true then
                    table.remove(listaDeCirculos,i) -- Removendo o objeto da coleção dinâmica de objetos em função de uma colisão entre ele e o jogador 2.
                end
 
                if v.y >= 800 then
                    timer = timer + 0
                    players = 0
                    gameOver = true
                end
            end
            if timer2 <= 0 then
                table.insert (listaDeCirculos, criaCirculo()) -- Criando um novo objeto na coleção dinâmica de objetos em função do tempo.
                timer2 = 0.6
            end
           
            if timer3 <= 0 then
                table.insert (listaDeCirculos, criaCirculo()) -- Criando um novo objeto na coleção dinâmica de objetos em função do tempo.
                timer3 = 0.3
            end
        end
    end
end
 
function love.draw()
    if  menu == true then
        love.graphics.print('1 Jogador     - Pressione 1', 200, 150,0,2.5)
        love.graphics.print('2 Jogadores - Pressione 2', 200, 200,0,2.5)
        love.graphics.print('Controles :', 50,350,0,1)
        love.graphics.print('Jogador 1 - A e D', 50,400,0,1)
        love.graphics.print('Jogador 2 - Esquerda e Direita', 50, 425,0,1)
        love.graphics.print('Pause - ESC', 50, 450,0,1)
        love.graphics.print('Gerar nova pedra - ESPAÇO', 50, 475,0,1)
 
       
    elseif gameOver == false then
        if paused then
            love.graphics.print('Jogo Pausado', 200, 200,0,5)
        else
            if players == 1 then
                love.graphics.print("Tempo:".. timer,300,10,0,1.5)
                for i,v in ipairs (listaDeCirculos) do
                    love.graphics.circle ("fill",v.x,v.y,v.largura,v.altura)
                end
 
                love.graphics.rectangle ("fill",jogador1_x,jogador1_y,jogador1_largura,jogador1_altura)
               
            elseif players == 2 then
                love.graphics.print("Tempo:".. timer,300,10,0,1.5)
 
                for i,v in ipairs (listaDeCirculos) do
                    love.graphics.circle ("fill",v.x,v.y,v.largura,v.altura)
                end
                love.graphics.rectangle ("fill",jogador1_x,jogador1_y,jogador1_largura,jogador1_altura)
                love.graphics.rectangle ("fill",jogador2_x,jogador2_y,jogador2_largura,jogador2_altura) 
            end
        end
    elseif gameOver == true and players == 0 then
        love.graphics.print('Fim de jogo', 200, 200,0,5)
        love.graphics.print('Seu recorde:'.. timer, 100, 300,0,3)
    end
end
function love.keypressed(key)  
 
    if key == "escape" then
        paused = not paused
    end
 
    if key == "space" then
        table.insert (listaDeCirculos, criaCirculo()) -- Criando um novo objeto na coleção dinâmica de objetos em função de uma ação do usuário.
    end
 
end
 
 
function testaColisao (x1, y1, largura1, altura1, x2, y2,largura2, altura2)
 
     if x2+ largura2 < x1 then
       return false
     end
     
     if  x2 > x1 + largura1 then
       return false
     end
 
    if y2 + altura2 < y1 then
     return false
    end
 
    if y2 > y1 + altura1 then
     return false
    end
 
    return true
   
end
 
function criaCirculo() 
    circulo = {}
	
    circulo.x = math.random (0,800)
    circulo.y = 10
    circulo.largura = 5
    circulo.altura = 5
    circulo.velocidade = math.random (200,450)
    return circulo
   
end
