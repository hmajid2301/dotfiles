#!/bin/bash

eval $(which ssh-agent)
export GPG_TTY=$TTY
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
echo UPDATESTARTUPTTY | gpg-connect-agent > /dev/null
gpgconf --launch gpg-agent

sudo docker run -it --rm \
  -w "$HOME" \
  -v "$HOME/.dotfiles":/dotfiles \
  -v $PWD:/cwd \
  -v $HOME/.config:/config:rw \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ${HOME}/.gnupg/:/.gnupg/:ro \
  -v /run/user/$(id -u)/:/run/user/$(id -u)/:ro \
  -v $SSH_AUTH_SOCK:$SSH_AUTH_SOCK \
  -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
  -u `id -u` \
  --network host \
  registry.gitlab.com/hmajid2301/dotfiles "$@"