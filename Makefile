.PHONY: all
all:
	@echo "List of pnpm commands. Use pnpm run <cmd> to run the command."
	@jq -r '.scripts' package.json
