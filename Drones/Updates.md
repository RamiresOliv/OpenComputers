<h1 align="center">📑 Ducumentações de updates 📑</h1>

> less go<br>
> Todos os updates

Os uptades estão sendo catalogados da V0.4 para cima.<br>
Pois não foi possivel catalogar a versão `0.1`, `0.2` ou `0.3`.

### Registrados:
  - [0.5.0](#-2112-17042022-v050)
  - [0.4.0](#-0016-16042022-v040)

---
<h2 align="center">📑 21:12 17/04/2022 V0.5.0:</h2>
<p align="center">type: ALPHA</p><br>

### 1. ADDED Agora existe uma pequena sincronização com a cor do drone e as cores dos comandos

![image](https://user-images.githubusercontent.com/69019082/163737134-a1e39a42-3261-4c71-a4ce-7be6d0ccb891.png)

### 2. ADDED Mais um comando foi adicionados padronicamente na bios.

`[]` = `Necessario`<br>
`()` = `Não necessario`

  + place EX: `place [DIREÇÃO 0 até 6] (SORRATEIRAMENTE true ou false)`

### 3. CHANGE Bios mais optimizada

agora a bios está com variaveis menores e compactas para que alterações por vocês ou eventualmente sejam possivels. O total seria de 

### 4. _external_/ADDED Aquivo Novo chamado de Control.lua

Esse arquivo faz download dos 2 arquivos Bios e Client automaticamente.<br>
Muito util para quem odeio ficar copiando e colando codigo agora é só usar `wget https://raw.githubusercontent.com/RamiresOliv/OpenComputers/master/Drones/Control.lua Control.lua`.<br>
Para usar essa função é necessario usar uma Internet Card.<br>
Em fim ela faz download para você os arquivos.

### 5. ADDED Troca de port

Agora tanto a port do Client e da Bios foi trocada para `2412`<br>
É possivel mudar caso não queira, só lembre-se de mudar as portas como<br>
![image](https://user-images.githubusercontent.com/69019082/163737588-de7720ae-6b3c-48fc-95b5-b986d7b7def8.png)

  - Receive em Client tem que ser a mesma da função de Bios<br>
![image](https://user-images.githubusercontent.com/69019082/163737612-1bc98967-c712-4377-8d5e-bb0f34dcfdbc.png)

  - E Send em Client temm que ser a emsma de Bios em `m.open()`!<br>
   ![image](https://user-images.githubusercontent.com/69019082/163737644-1e171a70-4355-48ae-8b4d-831e23f15759.png)


<h2 align="center">📑 00:16 16/04/2022 V0.4.0:</h2>
<p align="center">type: ALPHA</p>

### 1. Mais comandos foram adicionados padronicamente na bios.
  + name EX: `name`
  + selecttank EX: `selecttank/ 1`
  + tanklevel EX: `tanklevel/tl`
  + drain EX: `drain 0 3000`
  + fill EX: `fill 0 3000`
  + select EX: `select 1`
  + drop EX: `drop 64`
  + suck EX: `suck 0 64`
  + help EX: `help/h`

  **Nota: para mostrar melhor oque cada comando desses fazem é só usar o comando `help`**<br>

### 3. Comando de ajuda! 'help'
  ![image](https://user-images.githubusercontent.com/69019082/163658869-f4ef19fd-f76f-49c7-a1cd-36f5277d98f2.png)<br>

### 4. Opmitização
  Agora os codigos estão "menores" com um total variado entre 3,50KB de 4KB<br>
  
### 5. Configurabilidade de Client
  + Configurações rapidas<br>
    ![image](https://user-images.githubusercontent.com/69019082/163658968-ce1fe24c-6aff-40d5-b212-2b2438217814.png)
  + Configurações de comandos<br>
    Ao usar o comando 'help' ira criar um novo arquivo com o nome pre-definido como 'commands.conf' onde você pode editar ou adicionar comandos para aparecer no comando help e outros<br>
    ![image](https://user-images.githubusercontent.com/69019082/163659005-6bd022ba-3369-455d-af35-d2569e9f8e36.png)<br>
    ![image](https://user-images.githubusercontent.com/69019082/163659001-4b2e75ac-8816-4316-8fdc-5e38638fb23f.png)<br>

### 6. E outros detalhes como
  + Uma pequena flecha<br>
    Significando que é possivel usar comandos ali<br>
    ![image](https://user-images.githubusercontent.com/69019082/163659159-1ffd34b0-8c4a-40bc-9341-5b96af7150bd.png)<br>
  + Pre mensagens<br>
    Estarão ali... e ficara ali para sempre.<br>
    ![image](https://user-images.githubusercontent.com/69019082/163659202-0d7988c2-747a-4b80-a961-4a5877b4ed3d.png)<br>
  + Sleep time
    Nunca queria ver o codigo sendo executado em tempo real? que tal dar um tempo antes de executar o codigo?<br>
    Usando essa nova ferramenta você pode usar no console `sleep [tempo]` e depois digitar o comando.<br>
    Ao usar essa ferramenta o evento definido vai ser executado após o tempo que foi colocado no `sleep`<br>
    Tome cuidado para não colocar tipo... `sleep 999999991` que pode não dar bom resultados.<br>
