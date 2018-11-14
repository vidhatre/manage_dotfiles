# Expose the origin systems clipboard for paste in ssh session
  Use Case: When I ssh from Computer A to computer B. I usually need
  to paste the output of a command into computer A's clipboard. Currently
  I cat to terminal and use the tmux's copy operation to paste to A's buffer.
  This example setups a socket service to call xlclip to update A's buffer.
  The local socket is exposed to the remote over ssh's Remote Forward.

  Source: https://hackernoon.com/tmux-in-practice-copy-text-from-remote-session-using-ssh-remote-tunnel-and-systemd-service-dd3c51bca1fa

