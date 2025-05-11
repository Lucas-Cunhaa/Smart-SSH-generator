# Sm# SSH Key Setup and Automation 

This guide explains how to generate an SSH key (with the ed25519 algorithm), add it to a plataform, GitHub for example, and automatically load it using `ssh-agent` every time you start your computer or open a terminal session .

---

## 1. Generate a New SSH Key

1. To generate a new SSH key pair:

```bash
ssh-keygen -t ed25519 -C "your_plataform_email@example.com"
```

- t: select the algorithm for the key
- b: select the size of the key in bits
- -C: add a comment for the key, with the propurse of identification

2. Verify with: 

2.1

```bash cat myKey.pub
```

the result should be somethin like:

```bash ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICv...rest_of_key... user@example.com
```

2.2

```bash cat myKey
```

the result should be somethin like:

bash```-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAA...
...rest_of_the_key...
-----END OPENSSH PRIVATE KEY-----
```

---

## 2. Create, if does not exist, a .ssh repository and move the keys into

-1 Check the .ssh folder:

- Linux/Mac OS:

```bash
ls -a ls -a /home/<your_user>/
```

- Windows:

```bash
ls -a C:/Users/<your_user>/
```
- If does not exists, create a new one:

```bash mkdir ~/.ssh
```

2. Move the private and public key (key.pub) into the folder

```bash
mv myKey myKey.pub ~/.ssh/
```

---

## 3. Add the SSH to the agent

1. Active your ssh agent:

```bash
eval "$(ssh-agent -s)"
```

2. Add your private key

```bash
ssh-add ~/.ssh/myKey
```

3. Go the the plataform that you want to authenticate with ssh, and paste the public into it, copy the key with:

```bash
cat ~/.ssh/myKey.pub
```

## 4. Test your connection
- GitHub example:

```bash
ssh -T git@github.com
```

## 5. Create the script for smart connection

1. Entry in your terminal configuration file
example with zsh:

```bash
 nano ~/.zshrc
```

2. Enter the script for generate de agent when initializng the terminal:

```bash
if [ -z "$SSH_AUTH_SOCK" ]; then
    
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/gitHubKey
fi
```
if [ -z "$SSH_AUTH_SOCK" ]; then -> Verify if the "$SSH_AUTH_SOCK" (environment  that stores ssh-agent path) is empty

eval "$(ssh-agent -s)" -> generate anew SSH agent

ssh-add ~/.ssh/gitHubKey -> Add the private key into te agent


