starship init fish | source
set -x PATH $PATH $HOME/.pyenv/bin $HOME/.poetry/bin $HOME/.local/bin
set -gx PIPX_DEFAULT_PYTHON "$HOME/.pyenv/versions/3.10.5/bin/python"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/haseeb/google-cloud-sdk/path.fish.inc' ]; . '/home/haseeb/google-cloud-sdk/path.fish.inc'; end


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end
zoxide init fish | source