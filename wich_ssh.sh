#!/bin/bash

# SSH config file path
CONFIG_FILE="$HOME/.ssh/config"

# Check if the file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "🔴 Error: $CONFIG_FILE not found"
  exit 1
fi

# Function to clean strings (remove quotes if any)
clean_string() {
  echo "$1" | sed "s/['\"]//g"
}

# Process the config file
awk '
  BEGIN { host=""; hostname=""; user=""; port=""; identity="" }
  /^[[:space:]]*Host[[:space:]]+/ {
    if (host != "") {
      print host "\t" hostname "\t" user "\t" port "\t" identity
    }
    host=$2; hostname=""; user=""; port=""; identity=""
  }
  /^[[:space:]]*HostName[[:space:]]+/ { hostname=$2 }
  /^[[:space:]]*User[[:space:]]+/ { user=$2 }
  /^[[:space:]]*Port[[:space:]]+/ { port=$2 }
  /^[[:space:]]*IdentityFile[[:space:]]+/ { identity=$2 }
  END {
    if (host != "") {
      print host "\t" hostname "\t" user "\t" port "\t" identity
    }
  }
' "$CONFIG_FILE" | while IFS=$'\t' read -r host hostname user port identity; do

  # Clean values
  host=$(clean_string "$host")
  hostname=$(clean_string "$hostname")
  user=$(clean_string "$user")
  port=$(clean_string "$port")
  identity=$(clean_string "$identity")

  echo ""
  echo "🔵 Host: $(tput bold)$host$(tput sgr0)"
  
  # Show details
  [ -n "$hostname" ] && echo "   🌐 Hostname: $hostname"
  [ -n "$user" ] && echo "   👤 User: $user" || echo "   👤 User: (default)"
  [ -n "$port" ] && echo "   🔌 Port: $port" || echo "   🔌 Port: 22 (SSH default)"
  
  # Check key file
  if [ -n "$identity" ]; then
    identity_expanded="${identity/#\~/$HOME}"
    if [ -f "$identity_expanded" ]; then
      echo "   🔑 Key: $identity $(tput setaf 2)✔️ exists$(tput sgr0)"
    else
      echo "   🔑 Key: $identity $(tput setaf 1)❌ NOT FOUND$(tput sgr0)"
    fi
  fi

  # Generate connection commands
  echo ""
  echo "   💻 Commands ready to copy:"
  echo "   $(tput setaf 4)ssh $host$(tput sgr0)"
  
  # Extended command
  cmd="ssh"
  [ -n "$port" ] && [ "$port" != "22" ] && cmd+=" -p $port"
  [ -n "$user" ] && cmd+=" $user@$hostname" || cmd+=" $hostname"
  echo "   $(tput setaf 4)$cmd$(tput sgr0)"
  
  echo "----------------------------------"

done
