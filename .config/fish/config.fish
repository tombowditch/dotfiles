eval (/opt/homebrew/bin/brew shellenv)

# Path
fish_add_path ~/.config/bin
fish_add_path ~/.config/bin/platform-tools
fish_add_path ~/.local/bin
fish_add_path ~/go/bin
fish_add_path ~/.bun/bin
fish_add_path ~/.config/tmux/plugins/t-smart-tmux-session-manager/bin

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings

set -Ux EDITOR nvim
set -Ux TERM xterm-256color
set -Ux BUN_INSTALL "/Users/tom/.bun"
set -Ux SSH_AUTH_SOCK "~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"


# Aliases

abbr k "kubectl"
abbr tf "terraform"
abbr lg "lazygit"
abbr vim "nvim"

# gcloud
bass source '~/gcloud/google-cloud-sdk/path.bash.inc'
bass source '~/gcloud/google-cloud-sdk/completion.bash.inc'

# zoxide
zoxide init fish | source

# atuin
atuin init fish | source

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
