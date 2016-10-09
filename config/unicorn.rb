worker_processes 2

working_directory "/home/makino/register"

pid "/var/tmp/unicorn.pid"

listen "/var/tmp/unicorn.sock"

stdout_path "./log/unicorn.stdout.log"
stderr_path "./log/unicorn.stderr.log"