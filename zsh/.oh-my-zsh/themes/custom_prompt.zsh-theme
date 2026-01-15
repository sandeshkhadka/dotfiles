# 1. Function to detect if we are in a Distrobox and return the ID
function distrobox_prompt() {
  if [ -f /run/.containerenv ]; then
    # Source os-release to get the ID (e.g., ubuntu, arch, fedora)
    local name=$(. /etc/os-release && echo $ID)
    # Return the name in a specific color (e.g., gray %F{242}) with a separator
    echo "%F{242}${name}:%f"
  fi
}

# 2. Your original prompt logic with the new function integrated
# We add $(distrobox_prompt) right after the opening bracket
PROMPT="%F{38}[%f$(distrobox_prompt)%F{222}%~%f"
PROMPT+='$(git_prompt_info)'
PROMPT+="%F{38}]%f%F{158}$%f "

# Your existing Git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{201}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
