starship init fish | source
set -x PATH $PATH /home/haseeb/.pyenv/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/haseeb/google-cloud-sdk/path.fish.inc' ]; . '/home/haseeb/google-cloud-sdk/path.fish.inc'; end


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end
fish_ssh_agent