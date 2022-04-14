<h1 align="center">🧰 Drones 🛠</h1>
> Bora fazer Drone?

Sumario:
- [Como conectar o VSCODE em um computador no OpenComputers](#configurando-o-vscode-junto-com-o-opencomputers)
- [Como fazer e configurar um drone](#como-fazer-e-configurar-um-drone)

Por: Gabriel Ramires<br>
Documentação Oficial de [OpenComputers](https://ocdoc.cil.li)

_versão: 1.12.2_

# Configurando o VSCODE junto com o OpenComputers
Vou usar o VSCODE então se você quizer também usar o VSCODE para editar codigos no OpenComputers você precisara configurar o OpenComputers!

`C:\Users\[Seu Nome]\AppData\Roaming\.minecraft\config\opencomputers\settings.conf` Esse path é o local de configuração do OpenComputers onde fica Tuuuuuuuuuudo do OpenComputers mas você ira atras de uma em especifico.

Essa Configuração:

![unknown](https://cdn.discordapp.com/attachments/703756917465546752/964118425330909184/unknown.png)

Como mostra a imagem a cima já está `false` pois ja tinha mechido nele mas no seu caso estará `true` se quizer usar o vscode desative essa configuração, e Abra novamente o Minecraft

_Essa configuração ira fazer o VSCODE ou outros editores que fazer auterações nos scripts em tal computador sejam contados caso esteja `true` o codigo feito pelo VSCODE não ira funcionar! é preciso desativar essa função._

## Abrindo um computador no VSCODE

va em Abrir pasta no vscode

depois procure nesse path: `C:\Users\[Seu Nome]\AppData\Roaming\.minecraft\saves\[Nome do seu mapa]\opencomputers`

Agora você tera que achar seu computador nesse path.

Depois você podera abrir a pasta do computador especifico que vocÊ deseja.

e pronto agora você tem seu computador no VSCODE :)

![unknown](https://cdn.discordapp.com/attachments/703756917465546752/964124297092276334/unknown.png)


# Como fazer e configurar um drone
> Ta, vou tentar fazer um Drone junto com você ai

Você **PRECISA** saber disso:
1. Eu só vou mostrar como fazer um drone nada mais.
2. Não vou mostrar como que faz por exemplo um PC
3. Só vou mostrar os materiais

# Fazendo um drone

Usaremos o `Electronics Assembler`:

![unknown](https://cdn.discordapp.com/attachments/954776132497055835/964125611041902643/unknown.png)

Agora use um Drone case de qualquer level que você preferir<br>
vou esta usando o level 2<br>
![unknown](https://cdn.discordapp.com/attachments/954776132497055835/964126075066155021/unknown.png)

Vou estar usando essa config humilde

![unknown](https://cdn.discordapp.com/attachments/954776132497055835/964126556391870524/unknown.png)

## Configurando uma EEPROM

![image](https://user-images.githubusercontent.com/69019082/163383288-6fb296b3-938b-482f-b713-260c336f4c16.png)

Essa EEPROM está vazia e tem que está vazia.!

agora coloque uma EEPROM vazia no computador 

![image](https://user-images.githubusercontent.com/69019082/163384322-9f487576-945a-4052-a1ef-33a1c6bdc3fd.png)

Agora vamos para o VSCODE

Crie um arquivo dentro de `home` com o nome `Bios.lua`

![image](https://user-images.githubusercontent.com/69019082/163384398-6a7c07fd-7cb6-490c-8ed7-2f861d47c826.png)

então cole o codigo da [Bios.lua](Bios.lua) desse repositorio no arquivo

Checando a existencia do arquivo:

![image](https://user-images.githubusercontent.com/69019082/163384912-dc91e99e-ff79-41cd-b85b-c8143113e61e.png)

![image](https://user-images.githubusercontent.com/69019082/163384958-d9bbc969-0eeb-4bf4-a1b9-32f0466fbbbf.png)

Certinho 👌

Proximo passo

vamos usar o Flash para clonar o Bios.lua (arquivo criado) e colocar dentro da EEPROM com o comando `flash /home/Bios.lua`

![image](https://user-images.githubusercontent.com/69019082/163385124-3c8029ab-f43a-4bef-b04c-04610b89abfe.png)

adicione um nome de preferencia na EEPROM

![image](https://user-images.githubusercontent.com/69019082/163385324-b42c7fe3-b1bf-47e8-9742-c84998d62b47.png)

depois pode remover a bios do PC

![image](https://user-images.githubusercontent.com/69019082/163385429-c4bd7728-7f63-4db2-825d-d56bab1e000c.png)

e adicione ela ao drone:

![image](https://user-images.githubusercontent.com/69019082/163385479-4e05be5c-ec78-4234-a5ac-7c902eb92c13.png)

Monteo apertando em Assemble...

![image](https://user-images.githubusercontent.com/69019082/163385575-08d5d7c4-531c-4404-b85d-a011606e427c.png)

Coloque no chão e ligue-o

![image](https://user-images.githubusercontent.com/69019082/163385635-9d196697-c890-48f4-b7f4-3b64d06f7ad7.png)

Caso tenha feito tudo corretamente o drone ira ligar

mas agora vamos mandar comandos paara ele!

## Client

Crie um arquivo denovo no seu PC que sera onde iremos enviar mensagens para o drone

![image](https://user-images.githubusercontent.com/69019082/163385857-6ee9ef27-602b-4241-89c0-3c6be1904ae4.png)

e cole o codigo de [Client.lua](Client.lua) deste repositorio para o PC

![image](https://user-images.githubusercontent.com/69019082/163385965-1dccebb7-a8ef-4560-b510-89bd86d19a6b.png)

![image](https://user-images.githubusercontent.com/69019082/163386027-fb0f3fea-4e4e-4929-b40d-88f6c12390cb.png)

Agora vamos usar o script

![image](https://user-images.githubusercontent.com/69019082/163386219-666de38b-5753-4223-8ec0-d414488a24d0.png)

Ações:

![image](https://user-images.githubusercontent.com/69019082/163386294-c237d463-2a5e-4451-8521-4a0047d59b14.png)

![image](https://user-images.githubusercontent.com/69019082/163386250-a9c9daf8-0e71-4417-8410-b7e47a94acc3.png)

setstatustext

![image](https://user-images.githubusercontent.com/69019082/163386355-6ab15c79-d6fa-4318-9f1b-1e3372a83841.png)

![image](https://user-images.githubusercontent.com/69019082/163386367-02cb9f8f-1d08-465d-907e-90c4458c44a8.png)

setlightcolor

![image](https://user-images.githubusercontent.com/69019082/163386586-f8f95c75-d84e-4988-ad5c-c94f1d94a1dd.png)

![image](https://user-images.githubusercontent.com/69019082/163386567-0c0398a8-9312-4399-9d75-53f78705f434.png)

# Terminando

espero que tenha gostado fiz isso ja faz uns 3 dias :)

e agora ta documentado no Github mas em fim,
talvez venha mais updates na bios ou client então se o codigo daqui pra frente esteja diferente não tenha panico.

vlw por ver e espero ter te ajudado.

<h1 align="center">🧰 Drones 🛠</h1>
