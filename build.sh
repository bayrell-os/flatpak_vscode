#!/bin/bash

case "$1" in
	
	setup)
		git config --global protocol.file.allow always
	;;
	
	download)
		
		if [ ! -f "app/code_1.105.1-1760482543_amd64.deb" ]; then
			wget -O "app/code_1.105.1-1760482543_amd64.deb" "https://update.code.visualstudio.com/1.105.1/linux-deb-x64/stable"
		fi
		
		if [ ! -f "app/code_1.109.0-1770171879_amd64.deb" ]; then
			wget -O "app/code_1.109.0-1770171879_amd64.deb" "https://update.code.visualstudio.com/1.109.0/linux-deb-x64/stable"
		fi
	;;
	
	build)
		flatpak-builder build-dir org.bayrell.vscode.yaml --force-clean --install-deps-from=flathub --repo=repo
	;;
	
	export)
		flatpak build-bundle repo org.bayrell.vscode.flatpak org.bayrell.vscode
	;;
	
	debug)
		flatpak-builder --run build-dir org.bayrell.vscode.yaml sh
	;;
	
	sh)
		flatpak run --command=sh org.bayrell.vscode
	;;
	
	run)
		flatpak run org.bayrell.vscode
	;;
	
	install)
		flatpak-builder --user --install --force-clean build-dir org.bayrell.vscode.yaml
	;;
	
	*)
		echo "Usage: $0 {download|build|export|run|debug|install}"
	;;
	
esac 
