#!/bin/bash
#
# Print banner art.

#######################################
# Print a board. 
# Globals:
#   BG_BROWN
#   NC
#   WHITE
#   CYAN_LIGHT
#   RED
#   BLUE
#   GREEN
#   YELLOW
# Arguments:
#   None
#######################################
print_banner() {

clear

  system=$(cat /etc/issue.net)
  usop=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')
  cpucores=$(grep -c cpu[0-9] /proc/stat)
  ram1=$(free -h | grep -i mem | awk {'print $2'})
  usoram=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
  hora=$(printf '%(%H:%M:%S)T')

  printf "\n"
  echo -e "\033[0;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e " \E[41;1;37m                      💻 LNETPLUS CHAT MANAGER 💻                        \E[0m"
  echo -e "\033[0;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

  echo -e "\033[1;32m  SISTEMA                        MEMÓRIA RAM                 PROCESSADOR "
  echo -e "\033[1;31m  OS: \033[1;37m$system          \033[1;31mTotal:\033[1;37m $ram1                 \033[1;31mNucleos: \033[1;37m$cpucores\033[0m"
  echo -e "\033[1;31m  Hora: \033[1;37m$hora                  \033[1;31mEm uso: \033[1;37m$usoram           \033[1;31m Em uso: \033[1;37m$usop\033[0m"
  echo -e "\033[0;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
}
