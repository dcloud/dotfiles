% zsh, help

# View zsh help page
bat /usr/share/zsh/$(zsh --version | awk '{print $2}')/help/<topic>

$ topic: ls /usr/share/zsh/$(zsh --version | awk '{print $2}')/help/
