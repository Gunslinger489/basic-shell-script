#!/bin/bash
clear
Menu(){
   echo "-----------------------------------------------------"
   echo "               SCRIPT DE ATUALIZACAO E BACKUP "
   echo "Obs.: A atualizacao de listas e pacotes funciona somente em distros baseados no Debian"
   echo "-----------------------------------------------------"
   echo
   echo "[ 1 ] Atualizar a lista de pacotes"
   echo "[ 2 ] Atualizar os pacotes"
   echo "[ 3 ] Atualizar o Sistema"
   echo "[ 4 ] Criar Backup"
   echo "[ 5 ] Sair"
   echo
   echo -n "Digite a opcao desejada? "
 read opcao
case $opcao in
      1) AtualizarRepo ;;
      2) AtualizarPac ;;
      3) AtualizarSist ;;
      4) CriaBackup;;
      5) exit ;;
      *) echo "Opcao Invalida. Digite novamente."
      sleep 2
      Menu;;
   esac
}
AtualizarRepo(){
clear
echo "Atualizando a lista de Pacotes"
if ! sudo apt update
then
	echo "Nao foi possivel atualizar os repositorios."
	echo "Por favor, verifique sua conexao."
fi
	echo "Atualizacao realizada com sucesso!"
Menu
}
AtualizarPac(){
clear
echo "Atualizando os pacotes"
if ! sudo apt upgrade -y
then
	echo "Nao foi possivel atualizar"
	exit 1
fi
	echo "Pacotes atualizados com sucesso"
Menu
}
AtualizarSist(){
clear
echo "Atualizando o Sistema"
if ! sudo apt dist-upgrade -y
then
	echo "Nao foi possivel atualizar o sistema"
	exit 1
fi
	echo "Sistema atualizado com sucesso"
Menu
}
CriaBackup(){
clear
BACKUPTIME=`date +%d-%m-%y-%H:%M` #Pega a Data/hora atual
echo "Por padrao, os arquivos de backup serao armazenados no diretorio /tmp."
echo "Caso queira altera-lo, modifique o parametro no script."
sleep 3
clear
DESTINO=/tmp/backup-$BACKUPTIME.tar.gz
echo "Digite o caminho completo do diretorio que voce deseja realizar o backup"
read ORIGEM
if [ -d "$ORIGEM" ]; then
	echo "Realizando backup dos arquivos"
	sudo tar -cvvjf $DESTINO $ORIGEM #cria o backup
	echo
	echo "Backup de $ORIGEM realizado com sucesso!"
	echo "O backup se encontra por padrao no diretorio /tmp."
	echo
	sleep 3
else
	echo "Diretorio inexistente."
	echo "Por favor, verique se o caminho do diretorio esta correto."
	sleep 3
fi
Menu
}
Menu
