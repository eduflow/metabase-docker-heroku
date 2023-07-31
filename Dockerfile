FROM metabase/metabase:v0.46.6.4
# Heroku passes the port to bind to in the $PORT environment variable.
# The Dockerfile `ENV`-command cannot be used since we don't know the $PORT at
# build time.

# Instead we use a "helper" script to translate the $PORT envvar to
# $MB_JETTY_PORT which is what Metabase expects.
# Principally, the `ENTRYPOINT` Dockerfile command can translate the envvar when
# in "shell-mode", but that has other issues.
COPY "./metabase_heroku_start.sh" "/app/metabase_heroku_start.sh"

# Metabase's own Docker image is broken on Heroku as it executes
# `/app/run_metabase.sh /app/run_metabase.sh` (it passes the executable as an
# argument to itself. Likely due to some weird CMD/ENTRYPOINT setup.
ENTRYPOINT ["/app/metabase_heroku_start.sh"]
CMD ["/app/run_metabase.sh"]
