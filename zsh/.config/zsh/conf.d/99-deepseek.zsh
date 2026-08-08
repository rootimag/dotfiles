local deepseek_key_file="$HOME/.config/zsh/conf.d/secrets/deepseek.key"

if [[ -f "$deepseek_key_file" ]]; then
    export DEEPSEEK_API_KEY="$(cat "$deepseek_key_file" | tr -d '\n')"
fi
