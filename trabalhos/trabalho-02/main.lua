function love.load()
  text = "Seja   Bem   Vindo   "
  nome = "Igor  Touguinhó  S.  de  Souza"
  font = love.graphics.newFont("Abduction.tff",20)
  love.graphics.setFont(font)
end

function love.draw()
  love.graphics.print(nome,150,250)
  love.graphics.print(text,250,300)
end
