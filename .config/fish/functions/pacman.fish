function pacman --description 'Keyring-based package manager'
    if test "$argv[1]" = "-S"; and test -n "$argv[2]"
        set -l pkg "$argv[2]"
        echo "[+] [SINIX] Adding '$pkg' to your config..."

        sudo lua /etc/sinix/src/add-pkg.lua "$pkg"
        sudo sinix-rebuild
    else
        command pacman $argv
    end
end
