#!/bin/bash

# Este Script faz o Youtube-dl baixar uma playlist de videos do Youtube!!!

function executar {
	clear
	echo;echo;echo;echo;echo;echo
	echo "COLE AQUI ABAIXO A URL DA PLAYLIST DE VIDEOS DO YOUTUBE QUE DESEJA BAIXAR: "
	read pl
	playlist=$(echo $pl | sed 's/list=/*/' | cut -d'*' -f2)
	videos=$(hxwls https://www.youtube.com/playlist?list=$playlist | grep index | cut -d'&' -f1 | uniq 2> /dev/null)
	qtos=$(hxwls https://www.youtube.com/playlist?list=$playlist | grep index | cut -d'&' -f1 | uniq | wc -l 2> /dev/null)
	clear
	echo;echo;echo;echo;echo;echo

	echo "Nome da Playlist é: ${playlist}"
	echo
	echo "Há ${qtos} vídeos nessa playlist!!" 
	echo
	echo "Os vídeos são estes: "
	echo "==================="
	echo $videos | tr ' ' '\n'
	echo;echo;echo
	sleep 2

	echo "OPÇÕES PARA DOWNLOAD:"
	echo "===================="
	echo "1 - Para baixar todos os VÍDEOS dessa Playlist" 
	echo "2 - Para baixar apenas o AUDIO desses videos (.m4a)"
	echo "3 - SAIR sem baixar nada"

	while :
	do
		read opcao
		echo
			case $opcao in
				1) youtube-dl $videos; exit;;
				2) youtube-dl -f 140 $videos; exit;;
				3) exit;;
				*) echo "Opção Inválida. Digite um número válido...";;
			esac
	done
	echo
}

function instalar {
	echo; echo "Verificando se o YOUTUBE-DL está instalado no seu computador..."; echo
	youtube-dl &> /dev/null
	if [ $? -eq 2 ] 
	then
		sed -i 's/^instalar/#instalar/' youtube-dl-playlist.sh
	else 
		echo "*** O programa YOUTUBE-DL não está instalado no seu computador... ***"	
		echo "Pressione alguma tecla para instalá-lo ou CTLR+C para sair."
		read
		sudo apt-get install youtube-dl
	fi
}

# Se quiser executar esse programa como da primeira vez, ... 
# ... apenas tire (apague) o símbolo de # do inicio da palavra 'instalar' ABAIXO (caso tenha):
instalar
executar


# Caso o YOUTUBE-DL PARE DE FUNCIONAR e peça para atualizar e nem assim funciona,...
# ... neste link abaixo está a solução:
# https://rpibrasil.wordpress.com/2017/12/15/a-maneira-mais-simples-de-baixar-videos-do-youtube/

# Autor: Helio Giroto
