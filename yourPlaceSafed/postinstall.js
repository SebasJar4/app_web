const { writeFile, copyFile, readFile } = require('fs').promises;

async function configureReactNativeMapsForWeb() {
  const modulePath = 'node_modules/react-native-maps';

  // Crea un módulo vacío para la plataforma web
  await writeFile(`${modulePath}/lib/index.web.js`, 'module.exports = {};', 'utf-8');

  // Copia las definiciones de TypeScript para la web
  await copyFile(`${modulePath}/lib/index.d.ts`, `${modulePath}/lib/index.web.d.ts`);

  // Actualiza el package.json de react-native-maps
  const pkg = JSON.parse(await readFile(`${modulePath}/package.json`, 'utf-8'));
  pkg['react-native'] = 'lib/index.js';
  pkg['main'] = 'lib/index.web.js';
  await writeFile(`${modulePath}/package.json`, JSON.stringify(pkg, null, 2), 'utf-8');

  console.log('Configuración de react-native-maps para web completada.');
}

configureReactNativeMapsForWeb().catch(console.error);
