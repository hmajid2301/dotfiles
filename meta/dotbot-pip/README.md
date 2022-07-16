# dotbot-pip

Install `pip` packages with `dotbot`. Also supports `pipsi` and `pipx`.


## Prerequirements

This plugin requires [`dotbot`](https://github.com/anishathalye/dotbot/) to be installed.


## How does it work

This plugin installs specified `requirements` file with the given `binary`.


## Installation

1. Run:

```bash
git submodule add https://github.com/sobolevn/dotbot-pip.git
```

2. Modify your `./install` with new plugin directory:

```bash
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" --plugin-dir dotbot-pip -c "${CONFIG}" "${@}"
```

3. Add required options to your [`install.conf.yaml`](/example.yaml):

```yaml
- pip:
    file: requirements.txt
    binary: /usr/local/bin/pip3
    user: true    # Like --user
    stdout: false # Print the execution stdout
    stderr: true  # Print the execution stderr

# Also supports pipsi and pipx, make sure they appear after `pip`!

- pipsi:
    file: requirements-pipsi.txt
    stdout: false # Print the execution stdout
    stderr: true  # Print the execution stderr

- pipx:
    file: requirements-pipx.txt
    stdout: false
    stderr: true
```

That's it!


## License

MIT. See [LICENSE](/LICENSE) for more details.
