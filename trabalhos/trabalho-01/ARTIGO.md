# C\# 

###Origens e Influencias
**C# (C-Sharp)** é uma linguagem de programação criada pela _Microsoft_ e tem como principal desenvolvedor Anders Hejlsberg (Criador de Delphi e Turbo Pascal). Foi desenvolvida devido a necessidade de um software que fosse acessível para qualquer um e disponível em qualquer dispositivo. A princípio recebeu o nome de **Cool**, mas com o lançamento da plataforma .NET foi renomeada para **C#**.

Sua criação teve como base a linguagem C++ e com diversos elementos de Java, Pascal, Eiffel, Modula-3

###Classificação
+ Orientada a Objetos
+ Fortemente tipada
+ Compilada
+ Estática

>O C# é a linguagem principal quando se fala de Microsoft. Desde serviços e plataformas web a dispositivos móveis que utilizam Windows Phone. Também é uma das linguagens usadas do motor gráfico de desenvolvimento de jogos Unity é o C#. Se você quer programar para Windows 7, 8, 10, etc. aprenda C#.

###Comparação
Comparando a linguagem C# com Java, vemos que as duas são bastante semelhantes em alguns pontos devido a grande influência que Java teve na criação de C#. Com isso, a legibilidade do código em Java e em C# é muito parecida. Há algumas alterações na sintaxe, porém nenhuma mudança mais brusca. E, por isso, a redigibilidade também é bastante parecida. O ponto que faz com que C# perca em popularidade para Java, é sua restrição ao ambiente da Microsoft. O que faz com que Java seja uma linguagem bem mais popular do que C# por ser livre para todos os ambientes de programação. Porém, C# é uma linguagem mais expressiva do que Java de acordo com Matthias Felleisen (professor alemão de Ciências da Computação nos Estados Unidos). 

Conforme uma explicação dele, uma linguagem A é mais expressiva do que uma linguagem B, quando a linguagem A é capaz de fazer tudo que a B faz sem mudanças radicais no código e, além disso, programas na linguagem A devem ser totalmente reestruturados para que possam funcionar na linguagem B. C# possui suporte a indexadores, o que faz com que seja expressiva que Java neste quesito. Indexadores permitem que as instâncias de uma classe ou estrutura sejam indexadas apenas como vetores.

Exemplo _"Hello World"_ mostrando a utilização de indexadores:

    class SampleCollection<T>{
        private T[] arr = new T[100];
        public T this[int i]{
            get{
              return arr[i];
            }
            set{
              arr[i] = value;
            }
        }
    }
    
    class Program{
       static void Main(string[] args){
          SampleCollection<string> stringCollection = new SampleCollection<string>();
          stringCollection[0] = "Hello, World";
          System.Console.WriteLine(stringCollection[0]);
       }
    }

###Conclusões

Após diversas pesquisas sobre esta linguagem de programação, chegamos a conclusão de que ela é uma excelente linguagem de propósito geral, usada somente na plataforma Microsoft e que é capaz de desenvolver desde pequenos e simples programas até softwares robustos como alguns tipos de jogos.


Fonte: 

http://csharpbrasil.com.br/

https://msdn.microsoft.com

http://www.portaldaprogramacao.com/

https://pt.wikipedia.org/wiki/C_Sharp
