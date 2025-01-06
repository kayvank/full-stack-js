/*
 * build script
 */
import * as esbuild from 'esbuild'

await esbuild.build({
  entryPoints: ['src/app.jsx'],
  bundle: true,
  outfile: 'out/out.js',
})
