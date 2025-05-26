setsebool -P httpd_can_network_connect 1

echo "Please config firewall manually."
read -p "Press any key to continue..."
git clone https://github.com/CH3COOOH/EasyFirewallCmd.git
python3 ./EasyFirewallCmd/efc.py
