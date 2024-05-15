### some aliases

new = new-session
ls = list-session
a = at = attach = attach-session
kill-ses = kill-session

## GENERAL (session commands with tmux)

| Command                           | Description                                          |
| --------------------------------- | ---------------------------------------------------- |
| tmux                              | Start tmux                                           |
| tmux ls                           | Display sessions                                     |
| tmux a /attach-session            | Restore tmux session                                 |
| tmux a -t mysession               | Attach to a session with the name `mysession`        |
| tmux attach -d                    | Detach an already attached session                   |
| tmux new -s mysession             | Start a new session with name `mysession`            |
| tmux kill-ses -t mysession        | Kill session with name `mysession`                   |
| tmux kill-ses -a                  | Kill all session but the current                     |
| tmux new -s mysession -n mywindow | Start session with `mysession` and window `mywindow` |

## Sessions

| Command                  | Description                               |
| ------------------------ | ----------------------------------------- |
| Ctrl-b :new -s mysession | Start a new session with name `mysession` |
| Ctrl-b :kill-session     | Kill current session                      |
| Ctrl-b d                 | Detach from tmux                          |
| Ctrl-b $                 | Rename session                            |
| Ctrl-b s                 | Switch session                            |
| Ctrl-b w                 | Session and Window Preview                |
| Ctrl-b s                 | Show all session                          |
| Ctrl-b (                 | Move to previous session                  |
| Ctrl-b )                 | Move to next session                      |

## Windows

| COMMANDS                              | DESCRIPTION                                |
| ------------------------------------- | ------------------------------------------ |
| Ctrl-b c                              | Create a window                            |
| Ctrl-b ,                              | Rename Window                              |
| Ctrl-b &                              | Close current window                       |
| Ctrl-b [0-9]                          | Switch between windows using numeric index |
| Ctrl-b Arrows                         | Switch between windows using arrow keys    |
| Ctrl-b w                              | Session and Window Preview                 |
| Ctrl-b n                              | Go to the next window                      |
| Ctrl-b p                              | Go to the previous window                  |
| Ctrl-b l                              | Toggle last active window                  |
| Ctrl-b :swap-window -s [0-9] -t [0-9] | Swap windows                               |

## PANES

| COMMANDS               | DESCRIPTION                                  |
| ---------------------- | -------------------------------------------- |
| Ctrl-b x               | Close the current pane                       |
| Ctrl-b ;               | Toggle last active pane                      |
| Ctrl-b z               | Maximize the current pane (toggle zoom)      |
| Ctrl-b %               | Split windows horizontally                   |
| Ctrl-b "               | Split windows vertically"                    |
| Ctrl-b {               | Move the current pane left                   |
| Ctrl-b }               | Move the current pane right                  |
| Ctrl-b space           | Toggle between pane layouts                  |
| Ctrl-b Ctrl-arrow keys | Resize panes                                 |
| Ctrl-b arrow keys      | Switch between panes (left, right, up, down) |
| Ctrl-b !               | Convert pane to a window                     |
| Ctrl-b q               | Show pane numbers                            |
| Ctrl-b q [0-9]         | Select pane by number                        |

## GENERAL COMMANDS

| COMMANDS                                                            | DESCRIPTION                      |
| ------------------------------------------------------------------- | -------------------------------- |
| Ctrl-b ?                                                            | List keys bindings               |
| Ctrl+b :list-keys                                                   | List keys bindings               |
| tmux list-keys                                                      | List keys bindings               |
| tmux info                                                           | Show every session, window, pane |
| Ctrl-b PageUp/PageDown                                              | To scroll in a window            |
| Ctrl-b : source-file /path/to/file                                  | To reload the configuration file |
| tmux -S /tmp/your_shared_session chmod 777 /tmp/your_shared_session | To start a shared session        |

## COPY MODE

| Key Binding                      | Description                                                           |
| -------------------------------- | --------------------------------------------------------------------- |
| Ctrl-b [                         | Enter copy mode                                                       |
| q                                | Exit copy mode                                                        |
| Arrow Up/Down                    | Scroll up or down in copy mode                                        |
| Space                            | Start selection                                                       |
| Enter                            | Copy selected text                                                    |
| Ctrl-b ]                         | Paste copied text                                                     |
| Ctrl-b PgUp/PgDown               | Scroll through the scrollback buffer                                  |
| Ctrl-u/Ctrl-d                    | Scroll a half page up or down                                         |
| Ctrl-b =                         | List all windows and their current sizes                              |
| Ctrl-b :resize-pane -U/D/L/R [N] | Resize the pane Up/Down/Left/Right by N lines or cells                |
| Ctrl-b ]                         | Search forward in the scrollback buffer (press again for next match)  |
| Ctrl-r                           | Enter search mode to search backward in the scrollback buffer         |
| H/J/K/L                          | Move the cursor left/down/up/right in copy mode (vim-like navigation) |
