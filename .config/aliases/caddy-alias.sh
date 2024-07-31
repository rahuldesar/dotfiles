alias ccad='update_caddy_function'

update_caddy_function() {
	if [ $# -ne 1 ]; then
		echo "Usage: update_caddy <directory_path>"
		return 1
	fi

	new_directory_path="$1"
	caddy_config_file="/etc/caddy/test/hello.caddy"

	sudo sed "2s|.*|        root * ${new_directory_path}|" "$caddy_config_file" >hello.caddy

	sudo mv -f hello.caddy $caddy_config_file

	if [ $? -ne 0 ]; then
		echo "Error: Failed to update the Caddy configuration file."
		return 1
	fi

	sudo caddy reload --config /etc/caddy/Caddyfile

	if [ $? -ne 0 ]; then
		echo "Error: Failed to reload Caddy."
		return 1
	fi

	echo "Caddy configuration updated with the new directory path and reloaded successfully."
}
