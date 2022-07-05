#!/usr/bin/env fish

### Fish function for setting up a Visual Studio Code python project using Poetry and Pyenv
### How to install: copy this into your ~/.config/fish/functions directory
### How to use: mkdir a project direct, cd into it, and run the code-python-setup function
### This function will:
### * install dependencies
### * select and/or install if necessary a particular python version (using pyenv)
### * set up a poetry virtual environment
### * configure the vscode project settings with the correct interpreter
### * install and configure a bunch of other python modules and/or vscode plugins
### Read the code to see everything

function code-python-setup
    ### Install and configure python environment

    set INSTALLED_VERSIONS (pyenv versions --bare | tail -r)
    dialog --no-items --menu "Select installed python" 0 0 (count $INSTALLED_VERSIONS) $INSTALLED_VERSIONS 2>| read PYTHON_VERSION
    if test -z $PYTHON_VERSION
        set AVAILABLE_VERSIONS (pyenv install --list | tail +2 | awk '{$1=$1};1')
        dialog --no-items --menu "Select Python to install" 0 0 (count $AVAILABLE_VERSIONS) $AVAILABLE_VERSIONS 2>| read PYTHON_VERSION
        if test -z $PYTHON_VERSION
            exit -1
        end
        pyenv install $PYTHON_VERSION
    end
    pyenv local $PYTHON_VERSION

    ### Set up poetry

    set_color bryellow; echo "Running poetry init"; set_color normal
    poetry init

    set_color bryellow; echo "Getting PYTHON_PATH"; set_color normal
    set PYTHON_PATH (poetry env info -p)

    set_color bryellow; echo "Upgrading PIP"; set_color normal
    poetry run pip install --upgrade pip

    ### Set up VS Code

    set_color bryellow; echo "Writing VSCode settings"; set_color normal
    set CODE_SETTINGS_PATH .vscode/settings.json
    mkdir -p (dirname $CODE_SETTINGS_PATH)
    if test -e $CODE_SETTINGS_PATH
        json5 $CODE_SETTINGS_PATH | jq '. + {"python.pythonPath": "'$PYTHON_PATH'"}' | sponge $CODE_SETTINGS_PATH
    else
        echo '{"python.pythonPath": "'$PYTHON_PATH'"}' | jq > $CODE_SETTINGS_PATH
    end

    if dialog --yesno "Install vscode python extension?" 0 0
        code --install-extension ms-python.python
    end

    if dialog --yesno "Override vscode launch.json for python files?" 0 0
        echo '{"version":"0.2.0","configurations":[{"name":"Python: Current File","type":"python","request":"launch","program":"${file}","console":"integratedTerminal"}]}' | jq > .vscode/launch.json
    end

    ### Some useful python and vscode modules/extensions

    if dialog --yesno "Install and configure `black` as python linter?" 0 0
        poetry add --dev black
        json5 $CODE_SETTINGS_PATH | jq '. + {"python.formatting.provider": "black"}' | sponge $CODE_SETTINGS_PATH
    end

    if dialog --yesno "Install ipykernel for python notebooks?" 0 0
        poetry add --dev ipykernel
        code --install-extension ms-toolsai.jupyter
    end

end

