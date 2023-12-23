{ pkgs, ... }: {
  home.packages = with pkgs; [
    choose
    curlie
    chafa
    dogdns
    duf
    delta
    du-dust
    dysk
    entr
    erdtree
    fd
    gdu
    gping
    hyperfine
    hexyl
    lazydocker
    ouch
    silver-searcher
    thefuck
    procs
    psensor
    trash-cli
    ripgrep
    sd
    xcp
    yq
  ];
}