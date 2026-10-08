SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    type sshd >/dev/null || {
        echo "No ssh-agent found. Please install openssh-client package."
        return
    }
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    file ~/.ssh/*|grep "private key"|awk -F: '{print $1}'|xargs ssh-add 
}

if [ -f "${SSH_ENV}" ]; then
    pgrep -u "$USER" ssh-agent > /dev/null || {
        . "${SSH_ENV}" > /dev/null
        start_agent;
    }
else
    start_agent;
fi
