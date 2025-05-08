
# SSH Config Summary Script

This Bash script parses your SSH configuration file (`~/.ssh/config`) and displays a summarized, user-friendly overview of each SSH host entry. It also verifies if the specified private key files exist and generates ready-to-copy SSH connection commands.

---

## Features

- Lists all SSH hosts defined in your `~/.ssh/config`.
- Shows important details for each host:
  - Host alias
  - Hostname (remote server address)
  - User (or default if not specified)
  - Port (or default 22 if not specified)
  - Identity file (private key) and its existence status
- Generates simple and extended SSH commands for quick copying.
- Uses colored output and icons for better readability.

---

## Usage

1. Make sure your SSH config file exists at `~/.ssh/config`.
2. Save the script to a file, for example `wich_ssh.sh`.
3. Make the script executable:

   ```
   chmod +x wich_ssh.sh
   ```

4. Run the script:

   ```
   ./wich_ssh.sh
   ```

---

## Example Output

```bash 
    🔵 Host: myserver
    🌐 Hostname: example.com
    👤 User: ubuntu
    🔌 Port: 2222
    🔑 Key: ~/.ssh/id_rsa ✔️ exists

    💻 Commands ready to copy:
    ssh myserver
    ssh -p 2222 ubuntu@example.com
```

---

## Notes

- The script assumes your SSH config file uses standard keywords: `Host`, `HostName`, `User`, `Port`, and `IdentityFile`.
- It expands `~` in the identity file path to your home directory.
- If the identity file does not exist, it will notify you with a red "NOT FOUND" message.
- The script requires `awk`, `sed`, and basic Unix shell utilities.

---

## License

This script is provided as-is under the MIT License. Feel free to modify and use it as you like.

---

Enjoy easier SSH management! 🚀

---


If you want, I can also help you improve or extend the script further!
