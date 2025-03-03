# How to add new secret identity

## Machine Key

1. Generate new SSH Key

```shell
ssh-keygen -t ed25519 -f ~/.ssh/id_machine
cat ~/.ssh/id_machine.pub
cp ~/.ssh/id_machine.pub $(hostname).ssh.pub
```

2. Generate new Age SE Key (Apple's Secure Enclave)

```shell
age-plugin-se keygen -o $(hostname).se
micro $(hostname).se.pub  # paste public key from $(hostname).se file
```

## YubiKey

TBD;
