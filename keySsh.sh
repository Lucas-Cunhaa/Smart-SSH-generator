#!/bin/bash

# === CONFIG ===
KEY_NAME="myKey"
EMAIL="your_email@example.com"
SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/$KEY_NAME"

# === STEP 1: Generate SSH key ===
echo "Generating SSH key..."
ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_NAME" -N ""

# === STEP 2: Create ~/.ssh if needed ===
if [ ! -d "$SSH_DIR" ]; then
  echo "Creating .ssh directory..."
  mkdir -p "$SSH_DIR"
  chmod 700 "$SSH_DIR"
fi

# === STEP 3: Move keys to ~/.ssh ===
echo "Moving keys to $SSH_DIR..."
mv "$KEY_NAME" "$SSH_DIR/"
mv "$KEY_NAME.pub" "$SSH_DIR/"
chmod 600 "$KEY_PATH"
chmod 644 "$KEY_PATH.pub"

# === STEP 4: Start SSH agent ===
echo "Starting ssh-agent..."
eval "$(ssh-agent -s)"

# === STEP 5: Add key to agent ===
echo "Adding key to agent..."
ssh-add "$KEY_PATH"

# === STEP 6: Print public key for copying to GitHub or other ===
echo "Your public key:"
cat "$KEY_PATH.pub"

echo "Done ✅"
