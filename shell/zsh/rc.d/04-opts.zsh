# View the list the existing shell options `setopt`
# View a list of all default zsh options `emulate -lLR zsg`
# Don't let > silently overwrite files. To overwrite, use >! instead.
setopt NO_CLOBBER

# Treat comments pasted into the command line as comments, not code.
setopt INTERACTIVE_COMMENTS

# test casee
# ~/d* is expanded into /Users/armin/Desktop /Users/armin/Documents /Users/armin/Downloads
setopt NO_CASE_GLOB

setopt HASH_EXECUTABLES_ONLY
