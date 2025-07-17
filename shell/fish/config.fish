# Check if ssh-agent is already running, if not start it
# if not set -q SSH_AGENT_PID; or not ps -p $SSH_AGENT_PID > /dev/null 2>&1
#     eval (ssh-agent -c) > /dev/null 2>&1
# end

# env | grep -i ssh


if not contains "./bin" $PATH
  set -xg PATH ./bin $PATH
end

if not contains "node_modules/.bin" $PATH
  set -xg PATH node_modules/.bin $PATH
end

# not contain in path env variable
# dir exsits
if [ -d "/opt/homebrew/bin" ]; set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths; end
if [ -d "/opt/homebrew/sbin" ]; set -g fish_user_paths "/opt/homebrew/sbin" $fish_user_paths; end

if [ -d "/usr/local/go/bin" ]; set -g fish_user_paths "/usr/local/go/bin" $fish_user_paths; end

if [ -d (echo ~)"/.local/bin" ]; set -g fish_user_paths (echo ~)"/.local/bin" $fish_user_paths; end

if [ -d (echo ~)"/.cargo/bin" ]; set -g fish_user_paths (echo ~)"/.cargo/bin" $fish_user_paths; end
