#!/bin/bash

fun_bar () {
  comando[0]="$1"
  comando[1]="$2"
  (
  [[ -e $HOME/fim ]] && rm $HOME/fim
  ${comando[0]} -y > /dev/null 2>&1
  ${comando[1]} -y > /dev/null 2>&1
  touch $HOME/fim
  ) > /dev/null 2>&1 &
  tput civis
  echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
  while true; do
    for((i=0; i<18; i++)); do
    echo -ne "\033[1;31m#"
    sleep 0.1s
    done
    [[ -e $HOME/fim ]] && rm $HOME/fim && break
    echo -e "\033[1;33m]"
    sleep 1s
    tput cuu1
    tput dl1
    echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
  done
  echo -e "\033[1;33m]\033[1;37m -\033[1;32m SUCESSO\033[1;37m"
  tput cnorm
}

first_install() {

  print_banner
  printf "${WHITE} 💻 Fazendo atualizações e instalações necessárias...${GRAY_LIGHT}"
  printf "\n\n"
}

instancia_install() {

  print_banner
  printf "${WHITE} 💻 Fazendo instalação do sistema...${GRAY_LIGHT}"
  printf "\n\n"
}

get_mysql_root_user() {
  
  print_banner
  printf "${WHITE} 💻 Insira usuário para esse banco de dados:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " mysql_root_user
  clear
}

get_mysql_root_password() {
  
  print_banner
  printf "${WHITE} 💻 Insira senha padrão do banco de dados:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " mysql_root_password
}

get_instancia_add() {
  
  print_banner
  printf "${WHITE} 💻 Digite o nome da empresa (Utilizar Letras minusculas):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " instancia_add
}

get_max_whats() {
  
  print_banner
  printf "${WHITE} 💻 Digite o numero maximo de conexões para a ${instancia_add}:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " max_whats
}

get_max_user() {
  
  print_banner
  printf "${WHITE} 💻 Digite o numero maximo de atendentes para a ${instancia_add}:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " max_user
}

get_frontend_url() {
  
  print_banner
  printf "${WHITE} 💻 Digite o domínio do FRONTEND para a ${instancia_add}:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " frontend_url
}

get_backend_url() {
  
  print_banner
  printf "${WHITE} 💻 Digite o domínio do BACKEND para a ${instancia_add}:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " backend_url
}

get_frontend_port() {
  
  print_banner
  printf "${WHITE} 💻 Digite a porta do FRONTEND para a ${instancia_add}; Ex: 3000 A 3305 ${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " frontend_port
}


get_backend_port() {
  
  print_banner
  printf "${WHITE} 💻 Digite a porta do BACKEND para esta instancia; Ex: 4000 A 4999 ${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " backend_port
}

get_phpmyadmin_port() {
  
  print_banner
  printf "${WHITE} 💻 Digite a porta PHPMYADMIN para a ${instancia_add}; Ex: 8000 A 8999 ${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " phpmyadmin_port
}

get_mysql_port() {
  
  print_banner
  printf "${WHITE} 💻 Digite a porta MYSQL para ${instancia_add}; Ex: 3306 A 3399 ${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " mysql_port
}

software_list_all() {
  
  print_banner
  printf "${WHITE} 💻 Listando todos os serviços online... ${GRAY_LIGHT}"
  printf "\n\n"

  sudo su - deploy <<EOF
  pm2 list
EOF
  sleep 2
}

pm_start_list() {
  
  print_banner
  printf "${WHITE} 💻 Iniciando serviços da ${instancia_add}... ${GRAY_LIGHT}"
  printf "\n\n"

  sudo su - deploy <<EOF
  pm2 start ${instancia_add}-frontend
  pm2 start ${instancia_add}-backend
  pm2 save
EOF
  sleep 2
}

pm_stop_list() {
  
  print_banner
  printf "${WHITE} 💻 Parando serviços da ${instancia_add}... ${GRAY_LIGHT}"
  printf "\n\n"

  sudo su - deploy <<EOF
  pm2 stop ${instancia_add}-frontend
  pm2 stop ${instancia_add}-backend
  pm2 save
EOF
  sleep 2
}

pm_remove_list() {
  
  print_banner
  printf "${WHITE} 💻 Parando serviços da ${instancia_add}... ${GRAY_LIGHT}"
  printf "\n\n"

  sudo su - deploy <<EOF
  pm2 delete ${instancia_add}-frontend
  pm2 delete ${instancia_add}-frontend
  pm2 save
EOF
  sleep 2
}

pm_remove_all() {
  
  print_banner
  printf "${WHITE} 💻 Parando serviços da ${instancia_add}... ${GRAY_LIGHT}"
  printf "\n\n"

  sudo su - deploy <<EOF
  pm2 stop ${instancia_add}-frontend
  pm2 stop ${instancia_add}-backend
  pm2 delete ${instancia_add}-frontend
  pm2 delete ${instancia_add}-frontend
  pm2 save
EOF
}

nginx_remove() {
  
  print_banner
  printf "${WHITE} 💻 Removendo nginx da ${instancia_add}... ${GRAY_LIGHT}"
  printf "\n\n"
  rm /etc/nginx/sites-available/${instancia_add}-frontend
  rm /etc/nginx/sites-available/${instancia_add}-backend
  rm /etc/nginx/sites-enabled/${instancia_add}-frontend
  rm /etc/nginx/sites-enabled/${instancia_add}-backend
  sleep 2
  service nginx restart
  sleep 2
}


files_remove() {
  
  print_banner
  printf "${WHITE} 💻 Removendo arquivos da ${instancia_add}... ${GRAY_LIGHT}"
  printf "\n\n"
  rm -rf /home/deploy/${instancia_add}
  sleep 2

}

container_remove() {
  
  print_banner
  printf "${WHITE} 💻 Removendo banco MySQL e phpMyAdmin via Docker da ${instancia_add}... ${GRAY_LIGHT}"
  printf "\n\n"
  docker stop phpmyadmin-${instancia_add}
  sleep 2
  docker rm phpmyadmin-${instancia_add}
  sleep 2
  docker stop mysql-${instancia_add}
  sleep 2
  docker rm mysql-${instancia_add}
  sleep 2
}

firewall_remove() {
  
  print_banner
  printf "${WHITE} 💻 Removendo regras de firewall da ${instancia_add}... ${GRAY_LIGHT}"
  printf "\n\n"
  ufw delete allow ${phpmyadmin_port}
}

get_urls() {
  get_mysql_root_user
  get_mysql_root_password
  get_instancia_add
  get_max_whats
  get_max_user
  get_frontend_url
  get_backend_url
  get_frontend_port
  get_backend_port
  get_phpmyadmin_port
  get_mysql_port
}

get_urls_install() {
  get_mysql_root_password
}

alter_domain() {
  get_mysql_root_user
  get_mysql_root_password
  get_instancia_add
  get_max_whats
  get_max_user
  get_frontend_url
  get_backend_url
  get_frontend_port
  get_backend_port
  get_phpmyadmin_port
  get_mysql_port

}

software_update() {
  get_instancia_add
  frontend_update
  backend_update
}

software_lock() {
  get_instancia_add
  pm_stop_list
  sleep 2
}

software_unlock() {
  get_instancia_add
  pm_start_list
  sleep 2
}


manager_update() {
  print_banner
  printf "${WHITE} 💻 Atualizando gerenciador... ${GRAY_LIGHT}"
  printf "\n\n"
  git reset --hard
  git pull
  sleep 2
}


software_uninstall() {
  get_instancia_add
  get_phpmyadmin_port
  files_remove
  nginx_remove
  firewall_remove
  container_remove
  sleep 2
  pm_remove_all
}

inquiry_options() {
  
  print_banner
  printf "${WHITE} 💻 Bem-vindo ao Menu Inicial${GRAY_LIGHT}"
  printf "\n\n"
  echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
  echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mINSTALAR \033[1;31m                 [\033[1;36m09\033[1;31m] \033[1;37m• \033[1;33mSAIR \033[1;31m
[\033[1;36m02\033[1;31m] \033[1;37m• \033[1;33mATUALIZAR \033[1;31m 
[\033[1;36m03\033[1;31m] \033[1;37m\033[1;37m• \033[1;33mDESINSTALAR \033[1;31m
[\033[1;36m04\033[1;31m] \033[1;37m• \033[1;33mLISTAR TODOS \033[1;31m
[\033[1;36m05\033[1;31m] \033[1;37m• \033[1;33mBLOQUEAR \033[1;31m
[\033[1;36m06\033[1;31m] \033[1;37m• \033[1;33mDESBLOQUEAR \033[1;31m
[\033[1;36m07\033[1;31m] \033[1;37m• \033[1;33mALTERAR DOMÍNIO \033[1;31m
[\033[1;36m08\033[1;31m] \033[1;37m• \033[1;33mATUALIZAR GERENCIADOR \033[1;31m"
  echo ""
  echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m? >"; read option

  case "${option}" in
    1) get_urls ;;

    2) software_update
      exit
      ;;
    3) software_uninstall
      exit;;
    
    4) software_list_all
      exit;;

    5) software_lock
      exit;;

    6) software_unlock 
      exit;;

    7) alter_domain;;

    8) manager_update 
      exit;;

    9) echo -e "\n\033[1;31mSAINDO...\033[0m"
    sleep 2
    clear
    exit;;
    *)
   echo -e "\n\033[1;31mOPÇÃO INVÁLIDA...\033[0m"
   sleep 2
   exit
  esac
}

install_options() {
  
  print_banner
  printf "${WHITE} 💻 Instalação do Gerenciador...${GRAY_LIGHT}"
  printf "\n\n"
  echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
  echo -e "\033[1;31m[\033[1;36m01\033[1;31m] \033[1;37m• \033[1;33mINSTALAR GERENCIADOR \033[1;31m   [\033[1;36m09\033[1;31m] \033[1;37m• \033[1;33mSAIR \033[1;31m"
  echo ""
  echo -ne "\033[1;32mOQUE DESEJA FAZER \033[1;33m? >"; read option

  case "${option}" in
    1) get_urls_install ;;

    9) echo -e "\n\033[1;31mSAINDO...\033[0m"
    sleep 2
    clear
    exit;;
    *)
   echo -e "\n\033[1;31mOPÇÃO INVÁLIDA...\033[0m"
   sleep 2
   exit
  esac
}