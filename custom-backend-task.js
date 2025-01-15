// custom-backend-task.js
import path from 'node:path';
import fs from 'node:fs/promises';
import { constants } from 'node:fs';
import fetch from 'make-fetch-happen';



async function fetchAndCachePlaceCalData(config, context) {
  let placeCalData = null;
  const cacheDir = path.join(context.cwd, '.cache');
  const cachePath = path.join(cacheDir, `${config.collection}.json`);
  try {
    await fs.access(cacheDir, constants.F_OK);
  } catch (_error) {
    await fs.mkdir(cacheDir, { recursive: true });
  }

  try {
    const fileContent = await fs.readFile(cachePath, 'utf8');
    placeCalData = JSON.parse(fileContent);
  } catch (_error) {
    const response = await fetch(config.url, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ query: config.query.query })
    });

    if (response.ok) {
      const collectionJson = await response.json();
      await fs.writeFile(cachePath, JSON.stringify(collectionJson));
      placeCalData = collectionJson;
    } else {
      throw new Error(`Failed to fetch data: ${response.statusText}`);
    }
  }
  return placeCalData;
}

async function fetchSinglePlaceCalData(config, context) {
  try {
    const collectionJson = await query(config.url, config.query.query, config.query.variables)
    return collectionJson;
  } catch (_error) {
    console.error(_error)
  }
}


function query(endPoint, query, variables) {
  return new Promise((resolve, reject) => {
    fetch(endPoint, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify({
        variables,
        query
      })
    })
      .then(r => r.json())
      .then(data => resolve(data))
      .catch(err => reject(err));
  });
}

export {
  fetchAndCachePlaceCalData,
  fetchSinglePlaceCalData
};
