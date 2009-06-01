git :init

file '.gitignore', <<-END
log/*
doc/*
tmp/**/*
config/database.yml
db/*.sqlite3
END

# git:hold_empty_dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")

git :add => "."
git :commit => "-a -m 'Setting up new rails app'
