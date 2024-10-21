#!/bin/bash

# Verifica argumentos
if [ "$#" -lt 1 ]; then
    echo "Uso: $0 {tamanho}"
    echo "Exemplo: $0 4G"
    echo "(Caminho padrão: /swapfile)"
    echo "Caminho opcional: Uso: $0 {tamanho} {caminho}"
    exit 1
fi

## Introdução
echo "Bem-vindo ao script de configuração de Swap! Este script configurará automaticamente um arquivo de swap e o ativará."
echo "Este script deve ser executado como root." 
echo "Source: @ https://github.com/adfastltda/swap"
echo

## Definir variáveis

# Tamanho do swap a partir do primeiro argumento
SWAP_SIZE=$1

# Caminho do swap a partir do segundo argumento (padrão para /swapfile)
SWAP_PATH="/swapfile"
if [ ! -z "$2" ]; then
    SWAP_PATH=$2
fi

## Executar
echo "Alocando $SWAP_SIZE em $SWAP_PATH..."
fallocate -l $SWAP_SIZE $SWAP_PATH  # Alocar tamanho
chmod 600 $SWAP_PATH                # Ajustar permissão correta
mkswap $SWAP_PATH                   # Configurar swap         
swapon $SWAP_PATH                   # Ativar swap
echo "$SWAP_PATH   none    swap    sw    0   0" | tee -a /etc/fstab  # Adicionar ao fstab para ativar automaticamente

## Finalização

echo
echo "Concluído! Agora você tem um arquivo de swap de $SWAP_SIZE em $SWAP_PATH."
