  Managing the server

  Start
  docker compose up -d

  Stop (data is kept)
  docker compose down
  docker compose stop also works; it keeps the containers instead of removing them. Both containers restart on their own after a reboot unless you stopped them.

  Status and logs
  docker compose ps
  docker compose logs -f server

  Reset (start from scratch)
  docker compose down -v
  docker compose up -d
  docker compose logs server 2>&1 | grep -i "setup code"
  -v deletes the stack's volumes, including the SQLite database with all accounts, vaults and devices. This can't be undone. Back up the unissh_unissh-data volume first if you might want it
  later. After a reset, the server is unclaimed and prints a new setup code, which you then use to claim it again.

  Clients that were linked to the old server will stop working with it. In each client, remove that server or sign out, then claim or join again. Local vaults on your devices are not
  affected.

  Upgrade
  docker compose pull server
  docker compose build --pull caddy
  docker compose up -d

