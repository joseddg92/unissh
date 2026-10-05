# Upstream admin panel image with English as the default language.
#
# The panel hardcodes Russian as its default (server-ui/src/store/prefs.ts:
# `lang: "ru"`, and i18n `fallbackLng: "ru"`), and the language switch is only
# reachable after login. Patch the two defaults in the built bundle instead of
# rebuilding the SPA (and its wasm crypto) from source.
#
# Fails the build if the patterns are gone, so an upstream change is noticed
# rather than silently shipping Russian again. Rebuild after pulling upstream:
#   docker compose build --pull caddy && docker compose up -d
FROM ghcr.io/goduni/unissh-caddy:latest

RUN set -eu; \
    f=$(grep -l 'density:`cards`,lang:`ru`' /srv/assets/index-*.js); \
    grep -q 'fallbackLng:`ru`' "$f"; \
    sed -i -e 's/density:`cards`,lang:`ru`/density:`cards`,lang:`en`/' \
           -e 's/fallbackLng:`ru`/fallbackLng:`en`/' "$f"; \
    grep -q 'density:`cards`,lang:`en`' "$f"; \
    grep -q 'fallbackLng:`en`' "$f"
