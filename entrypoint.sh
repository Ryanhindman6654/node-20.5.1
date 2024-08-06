#!/bin/bash

# Pull the latest code if AUTO_UPDATE is set to 1 and the directory is a git repository
if [[ -d .git ]] && [[ "${AUTO_UPDATE}" == "1" ]]; then 
    git pull
fi

# Install specific Node packages if NODE_PACKAGES is set
if [[ -n ${NODE_PACKAGES} ]]; then 
    npm install ${NODE_PACKAGES}
fi

# Uninstall specific Node packages if UNNODE_PACKAGES is set
if [[ -n ${UNNODE_PACKAGES} ]]; then 
    npm uninstall ${UNNODE_PACKAGES}
fi

# Install dependencies if package.json exists
if [[ -f /home/container/package.json ]]; then 
    npm install
fi

# Execute the main file with node or ts-node based on its extension
if [[ "${MAIN_FILE}" == *.js ]]; then 
    node "/home/container/${MAIN_FILE}" ${NODE_ARGS}
else 
    ts-node --esm "/home/container/${MAIN_FILE}" ${NODE_ARGS}
fi
